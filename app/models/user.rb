class User < ActiveRecord::Base
  has_many :user_books
  has_many :books, through: :user_books
  validates_presence_of :name, :username, :password, :email
  has_secure_password

  def slug
    self.username.split(" ").map!{|e| e.downcase}.join("-")
    #creates a slug from username separated by "-"
    #different from slugifiable.rb due to username vs name
  end

  def self.find_by_slug(slug)
    find_name = slug.split("-").map!{|e| e}.join(" ")
    #self.find_by name: find_name
    #need to iterate over all instances to find slug
    #returns that object
    self.all.find{|e| e.slug == slug}
  end
end
