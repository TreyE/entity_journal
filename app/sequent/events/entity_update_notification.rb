class EntityUpdateNotificationConsumed < Sequent::Event
  attrs aggregate_id: String, event_body: String, version: Integer
end

class EntityUpdateNotificationCategorizationRequested < Sequent::Event
  attrs aggregate_id: String, event_body: String, version: Integer
end