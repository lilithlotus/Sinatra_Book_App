class Books < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :name
      t.string :author
    end
  end
end
