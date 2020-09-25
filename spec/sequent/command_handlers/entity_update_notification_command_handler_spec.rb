require "rails_helper"

describe EntityUpdateNotificationCommandHandler do

  before :each do
    Sequent.configuration.event_store = Sequent::Test::CommandHandlerHelpers::FakeEventStore.new
  end

  it "results in a consumed event" do
    when_command ConsumeEntityUpdateNotification.new(aggregate_id: "abcde", event_body: "some xml")
    then_events EntityUpdateNotificationConsumed
  end

  it "trying to categorize a bogus, unparsable xml" do
    given_events EntityUpdateNotificationConsumed.new(aggregate_id: "abcde", event_body: "some xml", sequence_number: 1)
    when_command CategorizeEntityUpdateNotification.new(aggregate_id: "abcde")
    then_events EntityUpdateNotificationCategorizationRequested, EntityUpdateNotificationCategorizationFailed
  end

  it "trying to categorize an xml with an unknown root" do
    event_body = "<some_xml></some_xml>"
    given_events EntityUpdateNotificationConsumed.new(aggregate_id: "abcdef", event_body: event_body, sequence_number: 1)
    when_command CategorizeEntityUpdateNotification.new(aggregate_id: "abcdef")
    then_events EntityUpdateNotificationCategorizationRequested, EntityUpdateNotificationCategorizationFailed
  end

  it "trying to categorize an externally verified family" do
    event_body = "<ns0:external_verified_family xmlns:ns0=\"http://openhbx.org/api/terms/1.0\"></ns0:external_verified_family>"
    given_events EntityUpdateNotificationConsumed.new(aggregate_id: "abcdefg", event_body: event_body, sequence_number: 1)
    when_command CategorizeEntityUpdateNotification.new(aggregate_id: "abcdefg")
    then_events EntityUpdateNotificationCategorizationRequested, EntityUpdateNotificationCategorizationSuccessful
  end
end