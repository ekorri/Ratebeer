class User < ActiveRecord::Base
	include RatingAverage

	validates :username, uniqueness: true
	validates :username, length: { minimum: 3, maximum: 15, }
	validates :password, length: { minimum: 4 }
 	validates_format_of :password, :with => /(?=.*\d)(?=.*([A-Z]))/
	
	has_many :ratings, dependent: :destroy
	has_many :beers, through: :ratings

	has_many :memberships, dependent: :destroy
	has_many :beer_clubs, through: :memberships
	
	has_secure_password
end