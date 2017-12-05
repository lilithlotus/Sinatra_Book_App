class BookGenre < ActiveRecord::Base
  has_many :books
  has_many :genres
end
