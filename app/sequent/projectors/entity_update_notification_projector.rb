class EntityUpdateNotificationProjector < Sequent::Projector
  manages_tables EntityUpdateNotificationRecord

  on EntityUpdateNotificationConsumed do |event|
    create_record(
      EntityUpdateNotificationRecord,
      {
        aggregate_id: event.aggregate_id,
        message_body: event.event_body
      }
    )
  end
end
