class Document < ApplicationRecord
  belongs_to :site
  belongs_to :user
  belongs_to :folder, optional: true

  has_many :available_forms

  before_save :set_valid_forms

  def set_valid_forms
    self.available_forms.destroy_all

    forms = self.contents.scan(/\[kqlform::([^\]]*)/).flatten

    forms.each do |form|
      table_name, *fields = form.split(" ")
      fields_hash = {}
      fields.each do |field|
        key, value = field.split(":")
        fields_hash[key] = value
      end

      self.available_forms << AvailableForm.new(
        table_name: table_name,
        fields: fields_hash 
      )
    end
  end
end
