class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  acts_as_token_authenticatable
  after_initialize :set_default_role, :if => :new_record?

  enum role: [:customer, :owner]
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  def set_default_role
    self.role ||= :user
  end

  has_many :franchises, dependent: :destroy
  has_many :orders
  has_many :menu_items, through: :orders

  has_many :follows
  
  has_many :following_follows, class_name: "Follow", foreign_key: :follower_id
  has_many :followeds, through: :following_follows, source: :followed
  has_many :followed_follows, class_name: "Follow", foreign_key: :followed_id
  has_many :followers, through: :followed_follows, source: :follower
  has_many :chats
end
