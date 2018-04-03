class UserTicket < ApplicationRecord
  belongs_to :user
  belongs_to :ticket
  validate :start_date_has_to_be_future, before_create
  validate :check_if_all_paid, before_create

  def start_date_has_to_be_future
    if ticket.event.start_date.present? && ticket.event.start_date < Date.today
      errors.add(:start_date, "the event has started. No more ticket sales.")
    end
  end

  def check_if_all_paid
    tickets_sold = UserTicket.all
    tickets_sold.each {|sell|
        if !sell.paid
          errors.add(:user, "another user hasn't paid his or her ticket yet.")
        end
    }
  end
end
