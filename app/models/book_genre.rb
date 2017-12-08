class BookGenre < ActiveRecord::Base
  belongs_to :book
  belongs_to :genres
end
