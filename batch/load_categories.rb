#! /usr/bin/env ruby

require 'open-uri'
require 'nokogiri'

page = Nokogiri::HTML(open('http://itunes.apple.com/us/genre/ios/id36?mt=8'))

def upsert_category(id, label, parent = nil)
  category = nil
  categories = Category.where({:id => id})
  if categories.empty?
    category = Category.create({:id => id, :label => label, :parent => parent})
  else
    category = categories.first
  end

  category
end

page.css('.grid3-column > ul > li').each { |node|

  node_info = nil

  node.css('> a').each { |link|
    href = link.attr('href')
    title = link.text()
    id = href.match(/id(\d+)/)[1]
    node_info = {:id => id, :label => title, :href => href}
  }

  category = upsert_category(node_info[:id], node_info[:label])
  puts category

  node.css('>ul > li > a').each { |sub|
    sub_id = sub.attr('href').match(/id(\d+)/)[1]
    sub_title = sub.text()
    sub_category = upsert_category(sub_id, sub_title, category)
    puts sub_category
  }
}
