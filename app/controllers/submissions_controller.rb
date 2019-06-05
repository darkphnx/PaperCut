class SubmissionsController < ApplicationController
  before_action :find_event, :find_submission

  def index
    @submissions = @event.submissions.by_popularity
  end

  def show
  end

  def new
  end

  def create
    Submission.transaction do
      Submission.destroy_all if params[:delete_existing] == '1'
      Submission.from_csv(@event, params[:csv_upload].to_io)
    end

    redirect_to event_submissions_path(@event)
  end

  def destroy
    @submission.destroy

    redirect_to event_submissions_path(@event)
  end

  private

  def find_event
    @event = current_user.events.find(params[:event_id])
  end

  def find_submission
    @submission = @event.submissions.find(params[:id]) if params[:id]
  end
end
