class Book < ActiveRecord::Base
  belongs_to :genre
  has_many :user_books
  has_many :users, through: :user_books
  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods
end
