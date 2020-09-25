require "rails_helper"

describe ExternalVerifiedFamilyMatchCommandHandler do

  before :each do
    Sequent.configuration.event_store = Sequent::Test::CommandHandlerHelpers::FakeEventStore.new
  end

  it "results in an initiated event" do
    when_command RequestExternalVerifiedFamilyMatch.new(aggregate_id: "abcde", entity_update_notification_aggregate_id: "abcdefg", event_body: "some xml")
    then_events ExternalVerifiedFamilyMatchInitiated
  end

end