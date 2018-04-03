class Ticket < ApplicationRecord
  belongs_to :event
  has_many :user_tickets
  has_many :users, through: :user_tickets
  validates :price, numericality: { greater_than: 0 }
  validates :start_date_has_to_be_future

  def start_date_has_to_be_future
    if event.start_date.present? && event.start_date < Date.today
      errors.add(:start_date, "the event has started. No more tickets.")
    end
  end
end
