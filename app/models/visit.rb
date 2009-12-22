class Visit < ActiveRecord::Base
	belongs_to :offer, :counter_cache => true
	has_ip_address :ip
end