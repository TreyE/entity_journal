require_relative '../sequent_migrations'
require_relative "../../app/sequent/init"
  
Sequent.configure do |config|
 config.database_schema_directory = 'config'

 config.database_config_directory = 'config'

 config.migrations_class_name = 'SequentMigrations'
  
 config.command_handlers = [
  EntityUpdateNotificationCommandHandler.new,
  ExternalVerifiedFamilyMatchCommandHandler.new
 ]
  
 config.event_handlers = [
   # add you Sequent::Projector's or Sequent::Workflows's here
   EntityUpdateNotificationProjector.new,
   EntityUpdateNotificationWorkflow.new,
   ExternalVerifiedFamilyMatchProjector.new
 ]
    
 # this is the location of your sql files for your view_schema
 config.migration_sql_files_directory = 'db/sequent'
end
