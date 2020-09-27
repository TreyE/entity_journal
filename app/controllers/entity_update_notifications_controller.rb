require "securerandom"

class EntityUpdateNotificationsController < ApplicationController
  def index
    @entity_update_notifications = EntityUpdateNotificationRecord.all
  end

  def new
    @entity_update_notification = ConsumeEntityUpdateNotification.new({aggregate_id: "placeholder"})
  end

  def create
    params[:entity_update_notification].permit!
    @entity_update_notification = ConsumeEntityUpdateNotification.from_params(params[:entity_update_notification].merge(:aggregate_id => SecureRandom.uuid))
    if @entity_update_notification.valid?
      Sequent.command_service.execute_commands @entity_update_notification
      redirect_to entity_update_notifications_path
    else
      raise @entity_update_notification.errors.inspect
      render "new"
    end
  end
end