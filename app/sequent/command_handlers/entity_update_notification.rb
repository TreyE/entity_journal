class EntityUpdateNotificationCommandHandler < Sequent::CommandHandler
  on ConsumeEntityUpdateNotification do |command|
    repository.add_aggregate EntityUpdateNotification.new(command)
  end
end