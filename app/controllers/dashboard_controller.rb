class DashboardController < ApplicationController
  def index
    @expenses = Expense.all
    @calendar_event = CalendarEvent.all
    @upcoming_events = CalendarEvent.where('start_time >= ?', Date.today).order(:start_time)
  end
end
