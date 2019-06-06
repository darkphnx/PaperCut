class VotingController < ApplicationController
  skip_before_action :login_required
  before_action :find_event, :find_submissions

  def index
    @voting_slip = VotingSlip.new(event: @event)
  end

  def create
    @voting_slip = VotingSlip.new(safe_voting_slip_params.merge(event: @event))

    if @voting_slip.save
      render 'thanks'
    else
      render 'index'
    end
  end

  private

  # Generate an integer based on the browser's browser_id cookie which ensures someone always sees things in the same
  # order from this browser
  def browser_random_seed
    Digest::MD5.new.digest(cookies[:browser_id]).unpack('Q').first
  end

  def safe_voting_slip_params
    params.require(:voting_slip).permit(:email_address, submissions: {})
  end

  def find_event
    @event = Event.find_by!(id: params[:event_id], voting_token: params[:voting_token])
  end

  def find_submissions
    @submissions = @event.submissions.by_random(browser_random_seed)
  end
end
