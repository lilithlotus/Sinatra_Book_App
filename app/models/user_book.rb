class UserBook < ActiveRecord::Base
  has_many :users
  has_many :books 
end
