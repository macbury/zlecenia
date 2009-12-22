# Set the host name for URL creation
# rake sitemap:refresh
SitemapGenerator::Sitemap.default_host = "http://www.example.com"

SitemapGenerator::Sitemap.add_links do |sitemap|
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: sitemap.add path, options
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly', 
  #           :lastmod => Time.now, :host => default_host

  
  # Examples:
  
  # add '/articles'
  sitemap.add offers_path, :priority => 1.0, :changefreq => 'daily'

  # add all individual articles
  Offer.all(:order => "created_at DESC", :conditions => { :created_at.gte => 3.days.ago.at_beginning_of_day } ).each do |o|
    sitemap.add seo_offer_path(o), :lastmod => o.updated_at
  end

  # add merchant path
  #sitemap.add '/purchase', :priority => 0.7, :host => "https://www.example.com"
  
end

# Including Sitemaps from Rails Engines.
#
# These Sitemaps should be almost identical to a regular Sitemap file except 
# they needn't define their own SitemapGenerator::Sitemap.default_host since
# they will undoubtedly share the host name of the application they belong to.
#
# As an example, say we have a Rails Engine in vendor/plugins/cadability_client
# We can include its Sitemap here as follows:
# 
# file = File.join(Rails.root, 'vendor/plugins/cadability_client/config/sitemap.rb')
# eval(open(file).read, binding, file)