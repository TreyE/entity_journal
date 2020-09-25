class ConsumeEntityUpdateNotification < Sequent::Command
  attrs aggregate_id: String, event_body: String
  validates :aggregate_id, presence: true,
                    length: { minimum: 5 }
end

class CategorizeEntityUpdateNotification < Sequent::Command
  attrs aggregate_id: String
  validates :aggregate_id, presence: true,
                    length: { minimum: 5 }
end

class FailEntityUpdateNotificationCategorization < Sequent::Command
  attrs aggregate_id: String, status: String, error_messages: String
  validates :aggregate_id, presence: true,
                    length: { minimum: 5 }
  validates :status, presence: true,
                    length: { minimum: 5 }
end

class CompleteEntityUpdateNotificationCategorization < Sequent::Command
  attrs aggregate_id: String, entity_name: String
  validates :aggregate_id, presence: true,
                    length: { minimum: 5 }
  validates :entity_name, presence: true,
                    length: { minimum: 5 }
end