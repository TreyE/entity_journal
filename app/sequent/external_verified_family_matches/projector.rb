class ExternalVerifiedFamilyMatchProjector < Sequent::Projector
  manages_tables ExternalVerifiedFamilyMatchRecord

  on ExternalVerifiedFamilyMatchInitiated do |event|
    create_record(
      ExternalVerifiedFamilyMatchRecord,
      {
        aggregate_id: event.aggregate_id,
        entity_update_notification_record_aggregate_id: event.entity_update_notification_aggregate_id,
        status: "initiated",
        version: 1
      }
    )
  end
end