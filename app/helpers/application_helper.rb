# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
	def collection_from_types(types)
		out = []
		types.each_with_index { |e,i| out << [e,i] }
		return out
	end
end
