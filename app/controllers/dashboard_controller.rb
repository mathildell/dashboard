class DashboardController < ApplicationController
  def index
    @expenses = Expense.all
    @calendar_event = CalendarEvent.all
    @upcoming_bills = CalendarEvent.where('category != ? AND start_time >= ?', 'payday', Date.today).order(:start_time)
  end
end
