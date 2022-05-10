class Inscription < ApplicationRecord
  belongs_to :event
  belongs_to :user

  scope :by_user, ->(user_id) { where( user_id: user_id ) }
  scope :by_event, ->(event_id) { where( event_id: event_id ) }

end
