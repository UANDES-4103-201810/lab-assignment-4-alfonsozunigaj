class Event < ApplicationRecord
  belongs_to :place
  has_many :tickets
  validate :start_date_has_to_be_future, :no_other_events_in_venue

  def start_date_has_to_be_future
    if start_date.present? && start_date < Date.today
      errors.add(:start_date, "start date must be in the future")
    end
  end

  def no_other_events_in_venue
    events = Event.all
    events.each {|event|
        if event.place == place && event.start_date == start_date
          errors.add(:start_date, "there's another event at that time")
        end
    }
  end
end
