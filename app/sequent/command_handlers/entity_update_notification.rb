class EntityUpdateNotificationCommandHandler < Sequent::CommandHandler
  on ConsumeEntityUpdateNotification do |command|
    repository.add_aggregate EntityUpdateNotification.new(command)
  end

  on CategorizeEntityUpdateNotification do |command|
    do_with_aggregate(command, EntityUpdateNotification) do |aggregate|
      aggregate.begin_categorization(command)
    end
  end
end