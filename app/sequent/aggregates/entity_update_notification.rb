class EntityUpdateNotification < Sequent::AggregateRoot
  def initialize(command)
    super(command.aggregate_id)
    apply EntityUpdateNotificationConsumed, {aggregate_id: command.aggregate_id, event_body: command.event_body, version: 1}
  end

  def begin_categorization(command)
    apply EntityUpdateNotificationCategorizationRequested, {aggregate_id: command.aggregate_id, event_body: command.event_body, version: @version + 1}
  end

  on EntityUpdateNotificationConsumed do |event|
    @status = "consumed"
    @event_body = event.event_body
    @version = 1
  end

  on EntityUpdateNotificationCategorizationRequested do |event|
    @status = "categorizing"
    @version = event.version
  end
end