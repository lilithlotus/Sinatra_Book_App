class Book < ActiveRecord::Base
  belongs_to :genre
  belongs_to :user
  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods
end
