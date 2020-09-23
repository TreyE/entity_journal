class EntityUpdateNotificationProjector < Sequent::Projector
    manages_tables EntityUpdateNotificationRecord
end
