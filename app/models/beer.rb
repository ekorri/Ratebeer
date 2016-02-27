class Beer < ActiveRecord::Base
	include RatingAverage

	validates :name, presence: true
	validates :style, presence: true

	belongs_to :brewery
	has_many :ratings, dependent: :destroy
	has_many :raters, -> { uniq }, through: :ratings, source: :user
	belongs_to :style

	def to_s
		"#{self.name}, panimo #{self.brewery.name}"
	end

	def self.top(n)
   	  sorted_by_rating_in_desc_order = Beer.all.sort_by{ |b| -(b.average_rating||0) }
   	  sorted_by_rating_in_desc_order.take(n)
 	end
end
