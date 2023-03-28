class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, authentication_keys: [:employee_number]

  validates :name, presence: true
  validates :name_kana, presence: true
  validates :employee_number, presence: true, uniqueness: true

  belongs_to :company

  #登録時にemailを不要とする
  def email_required?
    false
  end

  def email_changed?
    false
  end

  def will_save_change_to_email?
    false
  end

  def active_for_authentication?
    super && (self.is_displayed == true)
  end
end
