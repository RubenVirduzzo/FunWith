class User < ApplicationRecord
    validates :fullname, presence: true, length: { maximum: 30 }
    validates :username, presence: true
    validates :age, numericality: true

end
