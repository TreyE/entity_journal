class EntityUpdateNotificationConsumed < Sequent::Event
  attrs aggregate_id: String, event_body: String
end