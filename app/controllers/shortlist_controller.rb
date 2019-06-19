class ShortlistController < ApplicationController
  before_action :find_event, :find_submission

  def create
    respond_to do |wants|
      if @submission.shortlist!
        wants.html { redirect_to event_submission_path(@event, @submission) }
        wants.json do
          render json: { status: 'ok', table: render_submissions_table }
        end
      else
        wants.html do
          redirect_to event_submission_path(@event, @submission), alert: "Couldn't add this submission to shortlist"
        end
        wants.json { render json: { status: 'error' } }
      end
    end
  end

  def destroy
    respond_to do |wants|
      if @submission.unshortlist!
        wants.html { redirect_to event_submission_path(@event, @submission) }
        wants.json do
          render json: { status: 'ok', table: render_submissions_table }
        end
      else
        wants.html do
          redirect_to event_submission_path(@event, @submission), alert: "Couldn't remove this submission from shortlist"
        end
        wants.json { render json: { status: 'error' } }
      end
    end
  end

  private

  def render_submissions_table
    @submissions = @event.submissions

    render_to_string partial: 'submissions/table', locals: { event: @event, submissions: @submissions }, layout: false,
      formats: [:html]
  end

  def find_event
    @event = current_user.events.find(params[:event_id])
  end

  def find_submission
    @submission = @event.submissions.find(params[:submission_id])
  end
end
