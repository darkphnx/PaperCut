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

    redirect_to event_submissions_path(@event), notice: "Submissions for #{@event.name} have been processed successfully"
  end

  def update
    respond_to do |wants|
      if @submission.update(safe_submission_params)
        wants.html { redirect_to event_submission_path(@event, @submission) }
      else
        wants.html { redirect_to event_submission_path(@event, @submission), alert: "Couldn't update submission right now" }
      end
    end
  end

  def destroy
    @submission.destroy

    redirect_to event_submissions_path(@event), notice: "Submission #{@submission.title} has been removed"
  end

  private

  def safe_submission_params
    params.require(:submission).permit(:shortlisted)
  end

  def find_event
    @event = current_user.events.find(params[:event_id])
  end

  def find_submission
    @submission = @event.submissions.includes(:submission_votes).find(params[:id]) if params[:id]
  end
end
