class User < ApplicationRecord
    validates :fullname, presence: true, length: { maximum: 30 }

end
