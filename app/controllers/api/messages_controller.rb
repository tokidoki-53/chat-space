class Api::MessagesController < ApplicationController
  before_action :set_group

  def index
    @messages = @group.messages.where('id > ?', params[:id])
  end

  private

  def set_group
    last_message_id = params[:id].to_i
    @group = Group.find(params[:group_id])
  end
end
