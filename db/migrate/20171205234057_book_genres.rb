class BookGenres < ActiveRecord::Migration
  def change
    t.integer :book_id
    t.integer :genre_id
  end
  end
end
