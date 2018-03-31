class Folder < ApplicationRecord
  has_many :folders
  has_many :documents

  belongs_to :site
  belongs_to :folder, optional: true
  belongs_to :user
end
