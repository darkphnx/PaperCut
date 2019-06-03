class SubmissionsController < ApplicationController
  before_action :find_event

  def index
    @submissions = @event.submissions.by_popularity
  end

  def upload
  end

  def process_upload
    Submission.transaction do
      Submission.destroy_all if params[:delete_existing] == '1'
      Submission.from_csv(@event, params[:csv_upload].to_io)
    end

    redirect_to event_submissions_path(@event)
  end

  private

  def find_event
    @event = current_user.events.find(params[:event_id])
  end
end
