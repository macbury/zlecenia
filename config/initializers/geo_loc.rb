env = ENV['RAILS_ENV']
if env && (env.downcase == 'production' || env.downcase == 'staging')
  GOOGLE_APPLICATION_ID = "ABQIAAAA4WhJYunRL5hTNCRIxFyokxRqg62AKsIpcWmRQTTCu6ZDId8nMxRLyA2IQh9gbyP0ai3R2HQtvX12oA"
else
 GOOGLE_APPLICATION_ID = "ABQIAAAAnfs7bKE82qgb3Zc2YyS-oBT2yXp_ZAY8_ufC3CFXhHIE1NvwkxSySz_REpPq-4WZA27OwgbtyR3VcA" 
end

Geocode.geocoder = Graticule.service(:google).new GOOGLE_APPLICATION_ID