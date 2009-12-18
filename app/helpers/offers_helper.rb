module OffersHelper
	def offers_collection
		out = []
		OFFER_TYPES.each_with_index { |e,i| out << [e,i] }
		return out
	end
end
