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
end
