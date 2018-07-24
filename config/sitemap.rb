require 'rubygems'
require 'sitemap_generator'

SitemapGenerator::Sitemap.default_host = 'https://www.dexicelandmorrie.us/'
SitemapGenerator::Sitemap.create do
  add "/basic", :changefreq => 'daily', :priority => 0.9
  # add '/contact_us', :changefreq => 'weekly'
end
SitemapGenerator::Sitemap.ping_search_engines # Not needed if you use the rake tasks

