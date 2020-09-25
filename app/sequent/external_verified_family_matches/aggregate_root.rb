class ExternalVerifiedFamilyMatch < Sequent::AggregateRoot
  def initialize(command)
    super(command.aggregate_id)
    apply(
      ExternalVerifiedFamilyMatchInitiated,
      {
        aggregate_id: command.aggregate_id,
        event_body: command.event_body,
        entity_update_notification_aggregate_id: command.entity_update_notification_aggregate_id
      }
    )
  end

  on ExternalVerifiedFamilyMatchInitiated do |event|
    @status = "initiated"
    @version = 1
    @entity_update_notification_aggregate_id = event.entity_update_notification_aggregate_id
  end
end