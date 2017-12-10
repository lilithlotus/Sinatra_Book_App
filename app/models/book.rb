class Book < ActiveRecord::Base
  belongs_to :genre
  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods
end
