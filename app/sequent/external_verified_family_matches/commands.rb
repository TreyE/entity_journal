class RequestExternalVerifiedFamilyMatch < Sequent::Command
  attrs aggregate_id: String, entity_update_notification_aggregate_id: String, event_body: String
  validates :aggregate_id, presence: true,
    length: { minimum: 5 }
  validates :entity_update_notification_aggregate_id, presence: true,
    length: { minimum: 5 }
  validates :event_body, presence: true
end