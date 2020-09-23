class EntityUpdateNotification < Sequent::AggregateRoot
  def initialize(command)
    super(command.aggregate_id)
    apply EntityUpdateNotificationConsumed, {aggregate_id: command.aggregate_id, event_body: command.event_body}
  end

  on EntityUpdateNotificationConsumed do |event|
    @event_body = event.event_body
  end
end