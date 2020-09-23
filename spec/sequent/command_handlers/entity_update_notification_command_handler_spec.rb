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
end