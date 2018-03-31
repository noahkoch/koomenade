class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :sites
  has_many :documents

  before_create :set_username

  def set_username
    new_username = self.email.split("@").first

    while !!User.find_by(username: new_username) do
      new_username = "#{new_username}#{rand(1000)}"
    end

    self.username = new_username
  end
end
