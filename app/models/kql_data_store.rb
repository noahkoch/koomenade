# Koomenade Query Language
class KQLDataStore < ApplicationRecord

  belongs_to :user

  def self.get_structure user, store_name
    get_store(store_name).try(:structure) || {}
  end

  def self.get_values user, store_name
    get_store(store_name).try(:values) || {}
  end

  def self.get_store user, store_name
    data_store = KQLDataStore.where(user: user, name: store_name).first_or_initialize
    KQLQueryObject.new(data_store)
  end

  class KQLQueryObject
    attr_accessor :data_store, :_limit, :_offset, :_length, :_each

    VALID_METHODS = [
      'limit',
      'length',
      'each'
    ]

    def initialize data_store
      self.data_store = data_store 
      self._limit = nil
      self._offset = 0 
    end

    def write attributes_hash
      if data_store.values.empty?
        data_store.values = []
      end
      data_store.values << attributes_hash
      data_store.save
    end

    def get
      if _each
        _each
      elsif !_length.nil?
        _length
      else
        if _limit
          data_store.values[0..._limit]
        else
          data_store.values
        end
      end
    end

    def run_methods methods
      if VALID_METHODS.include? methods.first.to_s
        send(methods.first, *methods[1..-1])
      else
        raise ArgumentError, "KQO ERROR: Method `#{methods.first}` not valid."
      end
    end

    def limit n = 10
      self.limit = n
      return self
    end

    def length args = nil
      self._length = data_store.values.length
      return self
    end

    def each *args
      self._each = data_store.values.map do |value|
        pulled_values = []
        args.each do |arg|
          pulled_values << parse_block(value, arg) 
        end
        pulled_values.join
      end.join
      return self
    end

    def parse_block data_value, arg
      each_obj_name = self.data_store.name.singularize
      column_name = arg.match(/#{each_obj_name}:(\w*)/)[1]
      string_to_replace = arg.match(/\{(.*)\}/)[1] 
      string_to_replace.gsub(
        "#{each_obj_name}:#{column_name}", 
        (data_value[column_name] || "")
      )
    end

  end

end
