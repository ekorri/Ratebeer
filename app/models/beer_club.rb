class BeerClub < ActiveRecord::Base
	has_many :memberships
	has_many :users, through: :memberships

	def is_member?(user)
		users.include? user
	end
end
