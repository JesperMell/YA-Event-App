class EventsController < ApplicationController
  before_action :load_events

  def index
  end

  def load_events
    @events ||= Event.all
  end
end
