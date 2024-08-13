class User < ApplicationRecord
  validates :uid, :email, :name, presence: true, uniqueness: true

end
