class EntityUpdateNotificationProjector < Sequent::Projector
  manages_tables EntityUpdateNotificationRecord

  on EntityUpdateNotificationConsumed do |event|
    create_record(
      EntityUpdateNotificationRecord,
      {
        aggregate_id: event.aggregate_id,
        message_body: event.event_body,
        status: "consumed",
        version: 1
      }
    )
  end

  on EntityUpdateNotificationCategorizationRequested do |event|
    create_record(
      EntityUpdateNotificationRecord,
      {
        aggregate_id: event.aggregate_id,
        message_body: event.event_body,
        status: "categorizing",
        version: event.version
      }
    )
  end

  on EntityUpdateNotificationCategorizationFailed do |event|
    create_record(
      EntityUpdateNotificationRecord,
      {
        aggregate_id: event.aggregate_id,
        message_body: event.event_body,
        status: event.status,
        error_messages: event.error_messages,
        version: event.version
      }
    )
  end

  on EntityUpdateNotificationCategorizationSuccessful do |event|
    create_record(
      EntityUpdateNotificationRecord,
      {
        aggregate_id: event.aggregate_id,
        message_body: event.event_body,
        status: "completed",
        version: event.version,
        entity_name: event.entity_name
      }
    )
  end
end
