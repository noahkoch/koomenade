class Site < ApplicationRecord
  has_many :documents
  has_many :folders
  belongs_to :user
end
