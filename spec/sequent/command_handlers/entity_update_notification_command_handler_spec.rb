require "rails_helper"

describe EntityUpdateNotificationCommandHandler do
  include Sequent::Test::CommandHandlerHelpers

  before :each do
    Sequent.configuration.event_store = Sequent::Test::CommandHandlerHelpers::FakeEventStore.new
  end

  it "results in a consumed event" do
    when_command ConsumeEntityUpdateNotification.new(aggregate_id: "abcde", event_body: "some xml")
    then_events EntityUpdateNotificationConsumed
  end

  it "results in a categorization requested event" do
    given_events EntityUpdateNotificationConsumed.new(aggregate_id: "abcde", event_body: "some xml", sequence_number: 1)
    when_command CategorizeEntityUpdateNotification.new(aggregate_id: "abcde", event_body: "some xml")
    then_events EntityUpdateNotificationCategorizationRequested
  end
end