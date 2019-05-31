class EventsController < ApplicationController
  before_action :find_event

  def index
    @events = current_user.events.by_upcoming
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

  def edit
  end

  def update
    if @event.update(safe_event_params)
      redirect_to events_path
    else
      render 'edit'
    end
  end

  private

  def safe_event_params
    params.require(:event).permit(:name, :website, :cfp_open_until, :date_of_event, :logo)
  end

  def find_event
    @event = current_user.events.find(params[:id]) if params[:id]
  end
end
