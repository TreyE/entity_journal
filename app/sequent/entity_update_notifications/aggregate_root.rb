class EntityUpdateNotification < Sequent::AggregateRoot
  def initialize(command)
    super(command.aggregate_id)
    apply EntityUpdateNotificationConsumed, {aggregate_id: command.aggregate_id, event_body: command.event_body, version: 1}
  end

  def begin_categorization(command)
    apply EntityUpdateNotificationCategorizationRequested, {aggregate_id: command.aggregate_id, event_body: @event_body, version: @version + 1}
  end

  def fail_categorization(command)
    apply(
      EntityUpdateNotificationCategorizationFailed,
      {
        aggregate_id: command.aggregate_id,
        status: command.status,
        version: @version + 1,
        error_messages: command.error_messages,
        event_body: @event_body
      }
    )
  end

  def complete_categorization(command)
    apply(
      EntityUpdateNotificationCategorizationSuccessful,
      {
        aggregate_id: command.aggregate_id,
        version: @version + 1,
        entity_name: command.entity_name,
        event_body: @event_body 
      }
    )
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

  on EntityUpdateNotificationCategorizationFailed do |event|
    @status = event.status
    @error_messages = event.error_messages
    @version = event.version
  end

  on EntityUpdateNotificationCategorizationSuccessful do |event|
    @status = "completed"
    @entity_name = event.entity_name
    @version = event.version
  end
end