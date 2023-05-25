class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  acts_as_token_authenticatable
  after_initialize :set_default_role, :if => :new_record?

  enum role: [:customer, :owner]

  def set_default_role
    self.role ||= :user
  end

  has_many :franchises, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
