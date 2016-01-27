module RatingAverage
	def average_rating
		Rating.average(:score)
	end
end