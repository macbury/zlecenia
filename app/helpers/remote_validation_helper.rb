module RemoteValidationHelper
	def errors_to_json(record)
		#achievement_description_input
		klass_name = record.class.to_s.downcase
		json = {}
		
		record.errors.each do |field, error|
			field_id = "#{klass_name}_#{field}_input"
			json[field_id] ||= [] 
			json[field_id] << error
		end
		
		return json.to_json
	end
end