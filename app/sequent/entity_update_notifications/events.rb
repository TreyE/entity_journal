class EntityUpdateNotificationConsumed < Sequent::Event
  attrs aggregate_id: String, event_body: String, version: Integer
end

class EntityUpdateNotificationCategorizationRequested < Sequent::Event
  attrs aggregate_id: String, event_body: String, version: Integer
end

class EntityUpdateNotificationCategorizationFailed < Sequent::Event
  attrs aggregate_id: String, error_messages: String, version: Integer, status: String, event_body: String
end

class EntityUpdateNotificationCategorizationSuccessful < Sequent::Event
  attrs aggregate_id: String, entity_name: String, event_body: String, version: Integer
end