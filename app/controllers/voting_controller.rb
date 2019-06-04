class VotingController < ApplicationController
  before_action :find_event

  private

  def find_event
    @event = Event.find_by!(id: params[:id], voting_token: params[:voting_token])
  end
end
