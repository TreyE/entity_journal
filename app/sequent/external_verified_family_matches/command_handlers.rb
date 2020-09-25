class ExternalVerifiedFamilyMatchCommandHandler < Sequent::CommandHandler
  on RequestExternalVerifiedFamilyMatch do |command|
    repository.add_aggregate ExternalVerifiedFamilyMatch.new(command)
  end
end