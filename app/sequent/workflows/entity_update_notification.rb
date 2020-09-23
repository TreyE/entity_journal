class EntityUpdateNotificationWorkflow < Sequent::Workflow
  on EntityUpdateNotificationConsumed do |event|
    after_commit do
      categorize_command = CategorizeEntityUpdateNotification.new({
        aggregate_id: event.aggregate_id,
        event_body: event.event_body
      })
      Sequent.command_service.execute_commands categorize_command
    end
  end

  on EntityUpdateNotificationCategorizationRequested do |event|
    after_commit do
      # TODO: Add lookup to parse the XML and figure out what kind of entity it is,
      #       either failing to figure it out or moving to the next step
    end
  end
end