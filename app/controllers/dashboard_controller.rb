class DashboardController < ApplicationController
  def index
    @expenses = Expense.all
    @calendar_event = CalendarEvent.all
  end
end
