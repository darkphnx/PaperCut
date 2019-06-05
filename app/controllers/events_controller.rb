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
      redirect_to events_path, notice: "#{@event.name} created successfully"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @event.update(safe_event_params)
      redirect_to events_path, notice: "#{@event.name} updated successfully"
    else
      render 'edit'
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path, notice: "#{@event.name} removed successfully"
  end

  private

  def safe_event_params
    params.require(:event).permit(:name, :website, :cfp_open_until, :date_of_event, :logo, :voting_open)
  end

  def find_event
    @event = current_user.events.find(params[:id]) if params[:id]
  end
end
