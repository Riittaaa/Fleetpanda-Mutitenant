class Organization < ApplicationRecord
  validates :name, presence: true
  has_many :memberships
  has_many :users, through: :memberships
end
