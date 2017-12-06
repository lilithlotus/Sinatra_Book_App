class Genre < ActiveRecord::Base
  has_many :book_genres
  has_many :books, through: :book_genres
  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods
end
