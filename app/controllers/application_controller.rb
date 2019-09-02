class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def pre_process
    @expenses = Expense.all
    @current_home = Home.find(1)
    @calendar_event = CalendarEvent.all
    @upcoming_bills = CalendarEvent.where('category != ? AND start_time >= ?', 'payday', Date.today).order(:start_time)
  end
end
