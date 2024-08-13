class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :memberships
  has_many :organizations, through: :memberships

  attr_accessor :organization_id

  after_create :create_membership

  private

  def create_membership
    return unless organization_id.present?
    memberships.create(organization_id: organization_id)
  end
end
