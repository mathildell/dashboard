namespace :data do

  #  rake data:generate_payday weeks=(n)
  desc "Generates pay day events for X weeks"
  task generate_payday: :environment do
    nbr_weeks = ENV['weeks'].to_i
    last_entry_mathilde = CalendarEvent.where(name: '[Mathilde] Payday').last.start_time
    last_entry_virgile = CalendarEvent.where(name: '[Virgile] Payday').last.start_time
    objects = []

    i = 0
    loop do
      i += 1
      next_time = (2 * i)

      next_pay_mathilde = last_entry_mathilde + next_time.weeks
      object_mathilde = { name: '[Mathilde] Payday', start_time: next_pay_mathilde, category: 'payday', icon: 'icon-money' }
      objects << object_mathilde

      next_pay_virgile = last_entry_virgile + next_time.weeks
      object_virgile = { name: '[Virgile] Payday', start_time: next_pay_virgile, category: 'payday', icon: 'icon-money' }
      objects << object_virgile

      if i == nbr_weeks
        break
      end
    end

    events = CalendarEvent.create(objects)

    puts events.inspect
  end

  #  rake data:generate_rent months=(n)
  task generate_rent: :environment do
    nbr_months = ENV['months'].to_i
    last_entry = CalendarEvent.where(category: 'rent').last.start_time
    objects = []

    i = 0
    loop do
      i += 1

      next_rent = last_entry + i.months
      object_rent = { name: 'Loyer', start_time: next_rent, category: 'rent', icon: 'icon-home' }
      objects << object_rent

      if i == nbr_months
        break
      end
    end

    events = CalendarEvent.create(objects)

    puts events.inspect
  end

end
