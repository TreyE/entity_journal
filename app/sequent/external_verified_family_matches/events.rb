class ExternalVerifiedFamilyMatchInitiated < Sequent::Event
  attrs aggregate_id: String, entity_update_notification_aggregate_id: String, event_body: String
end