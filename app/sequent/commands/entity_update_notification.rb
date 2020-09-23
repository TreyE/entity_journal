class ConsumeEntityUpdateNotification < Sequent::Command
  attrs aggregate_id: String, event_body: String
  validates :aggregate_id, presence: true,
                    length: { minimum: 5 }
end

class CategorizeEntityUpdateNotification < Sequent::Command
  attrs aggregate_id: String, event_body: String
  validates :aggregate_id, presence: true,
                    length: { minimum: 5 }
end