class User < ApplicationRecord
  before_save :downcase_email
  has_many :tasks

  enum role:   %w(seller manager admin)

  validates :first_name, presence: true
  validates :last_name,  presence: true
  validates :email,      presence: true, uniqueness: true
  validates :phone,      presence: true, uniqueness:  { case_sensitive: false }
  validates :role,       inclusion: { in: roles.keys }

  def full_name
    "#{formatted_first_name} #{formatted_last_name}"
  end

  private

  def downcase_email
    self.email = email.downcase
  end

  def formatted_first_name
    first_name.capitalize
  end

  def formatted_last_name
    last_name.capitalize
  end
end
