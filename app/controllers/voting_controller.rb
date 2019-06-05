class VotingController < ApplicationController
  skip_before_action :login_required
  before_action :find_event

  def index
    @submissions = @event.submissions.by_random
  end

  def create
    voter = Voter.create!(safe_voter_params)

    params[:ratings].each do |submission_id, vote_weight|
      submission = @event.submissions.find(submission_id)

      voter.submission_votes.create!(submission: submission, weight: vote_weight)
    end

    render 'index'
  end

  private

  def safe_voter_params
    params.permit(:email_address)
  end

  def find_event
    @event = Event.find_by!(id: params[:event_id], voting_token: params[:voting_token])
  end
end
