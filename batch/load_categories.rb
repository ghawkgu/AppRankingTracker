#! /usr/bin/env ruby

require 'open-uri'
require 'nokogiri'

page = Nokogiri::HTML(open('https://itunes.apple.com/us/genre/ios/id36?mt=8'))

def upsert_category(id, label, parent = nil)
  level = parent ? parent.level + 1 : 1;
  category = Category.where(:id => id).first_or_create(:label => label, :level => level, :parent => parent)
end

top = Category.where(:id => '0').first_or_create(:label => 'All', :level => 0)
puts top

page.css('.grid3-column > ul > li').each { |node|

  node_info = nil

  node.css('> a').each { |link|
    href = link.attr('href')
    title = link.text()
    id = href.match(/id(\d+)/)[1]
    node_info = {:id => id, :label => title, :href => href}
  }

  category = upsert_category(node_info[:id], node_info[:label], top)
  puts category

  node.css('>ul > li > a').each { |sub|
    sub_id = sub.attr('href').match(/id(\d+)/)[1]
    sub_title = sub.text()
    sub_category = upsert_category(sub_id, sub_title, category)
    puts sub_category
  }
}
