class Objekt::Base < ApplicationRecord

  self.table_name = "objekts"

  belongs_to :user

  validates :name, presence: true

  VALID_TYPES = {
    database: 'DATABASE',
    page: 'PAGE',
    folder: 'FOLDER',
    site: 'SITE'
  }

  def name= value
    write_attribute(:name, value.gsub(" ", "-"))
  end

end
