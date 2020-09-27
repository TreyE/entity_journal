require 'securerandom'

class EntityUpdateNotificationWorkflow < Sequent::Workflow
  on EntityUpdateNotificationConsumed do |event|
    categorize_command = CategorizeEntityUpdateNotification.new({
      aggregate_id: event.aggregate_id
    })

    after_commit do
      execute_commands categorize_command
    end
  end

  on EntityUpdateNotificationCategorizationRequested do |event|
    parsed_xml = Nokogiri::XML(event.event_body)
    if parsed_xml.errors.any?
      xml_parse_failed_command = FailEntityUpdateNotificationCategorization.new({
        aggregate_id: event.aggregate_id,
        status: "xml_parsing_failed",
        error_messages: parsed_xml.errors.to_json
      })
      execute_commands xml_parse_failed_command
    else
      categorized_info = categorize_xml(parsed_xml)
      case categorized_info
      when :external_verified_family
        categorize_success_command = CompleteEntityUpdateNotificationCategorization.new({
          aggregate_id: event.aggregate_id,
          entity_name: "external_verified_family"
        })
        execute_commands categorize_success_command
      else
        xml_parse_failed_command = FailEntityUpdateNotificationCategorization.new({
          aggregate_id: event.aggregate_id,
          status: "unknown_root_entity"
        })
        execute_commands xml_parse_failed_command
      end
    end
  end

  on EntityUpdateNotificationCategorizationSuccessful do |event|
    after_commit do
      if event.entity_name == "external_verified_family"
        start_match_command = RequestExternalVerifiedFamilyMatch.new({
          aggregate_id: SecureRandom.uuid,
          entity_update_notification_aggregate_id: event.aggregate_id,
          event_body: event.event_body
        })
        execute_commands start_match_command
      end
    end
  end

  def categorize_xml(xml)
    xml_root = xml.root
    return :unknown_root if xml_root.blank?
    root_ns = xml_root.namespace
    return :unknown_root if root_ns.blank?
    if root_ns.href == "http://openhbx.org/api/terms/1.0"
      if xml_root.name == "external_verified_family"
        return :external_verified_family
      end
    end
    :unknown_root
  end
end