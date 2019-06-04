class VotingController < ApplicationController
  skip_before_action :login_required
  before_action :find_event

  def index
    @submissions = @event.submissions.by_random
  end

  def create
  end

  private

  def find_event
    @event = Event.find_by!(id: params[:event_id], voting_token: params[:voting_token])
  end
end
