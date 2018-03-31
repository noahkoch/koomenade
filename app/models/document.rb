class Document < ApplicationRecord
  belongs_to :site
  belongs_to :user
  belongs_to :folder, optional: true
end
