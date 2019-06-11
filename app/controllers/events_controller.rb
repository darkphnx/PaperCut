class EventsController < ApplicationController
  before_action :find_event

  def index
    @events = current_user.events.by_upcoming
  end

  def new
    @event = current_user.events.build(available_slots: 10, cfp_open_until: 1.month.from_now,
                                       date_of_event: 3.months.from_now)
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
    params.require(:event).permit(:name, :website, :available_slots, :cfp_open_until, :date_of_event, :logo)
  end

  def find_event
    @event = current_user.events.find(params[:id]) if params[:id]
  end
end
