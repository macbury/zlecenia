module ToolsHelper
	
	def tools_collection
		out = []
		TOOL_TYPES.each_with_index { |e,i| out << [e,i] }
		return out
	end
	
end
