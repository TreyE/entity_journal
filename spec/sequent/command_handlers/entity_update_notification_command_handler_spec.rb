require "rails_helper"

describe EntityUpdateNotificationCommandHandler do

  before :each do
    Sequent.configuration.event_store = Sequent::Test::CommandHandlerHelpers::FakeEventStore.new
  end

  it "trying to categorize a bogus, unparsable xml" do
    when_command ConsumeEntityUpdateNotification.new(aggregate_id: "abcde", event_body: "some xml")
    then_events EntityUpdateNotificationConsumed, EntityUpdateNotificationCategorizationRequested, EntityUpdateNotificationCategorizationFailed
  end

  it "trying to categorize an xml with an unknown root" do
    event_body = "<some_xml></some_xml>"
    when_command ConsumeEntityUpdateNotification.new(aggregate_id: "abcde", event_body: event_body)
    then_events EntityUpdateNotificationConsumed, EntityUpdateNotificationCategorizationRequested, EntityUpdateNotificationCategorizationFailed
  end

  it "trying to categorize an externally verified family" do
    event_body = "<ns0:external_verified_family xmlns:ns0=\"http://openhbx.org/api/terms/1.0\"></ns0:external_verified_family>"
    when_command ConsumeEntityUpdateNotification.new(aggregate_id: "abcde", event_body: event_body)
    then_events EntityUpdateNotificationConsumed, EntityUpdateNotificationCategorizationRequested, EntityUpdateNotificationCategorizationSuccessful
  end
end