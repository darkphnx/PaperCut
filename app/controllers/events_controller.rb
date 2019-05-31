class EventsController < ApplicationController
  def index
  end

  def new
    @event = current_user.events.build
  end

  def create
    @event = current_user.events.build(safe_event_params)

    if @event.save
      redirect_to events_path
    else
      render 'new'
    end
  end

  private

  def safe_event_params
    params.require(:event).permit(:name, :website, :cfp_open_until, :date_of_event, :logo)
  end
end
