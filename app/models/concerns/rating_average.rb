module RatingAverage
	extend ActiveSupport::Concern
	def average_rating
		return 0 if self.ratings.empty?
		ratings.average(:score)
	end
end