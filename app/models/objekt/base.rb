class Objekt::Base < ApplicationRecord
  VALID_TYPES = {
    database: 'DATABASE',
    page: 'PAGE',
    folder: 'FOLDER'
  }
end
