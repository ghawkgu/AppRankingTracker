require 'nokogiri'

app_root = Rails.application.config.root
rss_storage_path = Rails.application.config.rss_storage_path
rss_storage_path = "#{app_root}/#{rss_storage_path}"

file = ARGV[0] || "#{rss_storage_path}/jp_toppaidapplications_6014_Games.xml"
dom = Nokogiri::XML(open(file, 'r:UTF-8'))

category_raw =  file.split("/").last.split("_")
ranking_category = {
  :id => category_raw[2],
  :region_code => category_raw[0],
}

update_time = Time.iso8601(dom.css('feed > updated').text)

puts ranking_category
puts update_time

dom.css('entry').each_with_index { |entry, index|
  # Redy to update
  category_id = entry.css('category').attr('id').value
  category = Category.find(category_id)

  artist_node = entry.xpath('im:artist')
  if artist_node.attr('href')
    artist_url = artist_node.attr('href').value
    artist_id = artist_url.match(/id(\d+)/)[1]
    artist_name = artist_node.text()
    artist = Artist.where(:id => artist_id).first
    artist = Artist.create(:id => artist_id, :name => artist_name) unless artist
  end

  app_id_node = entry.css('id')
  app_id = app_id_node.attr('id').value
  app_bundle_id = app_id_node.attr('bundleId').value

  app_detail = {
    :url => "https://itunes.apple.com/jp/app/id493470467?mt=8",
    :name => entry.xpath('im:name').text(),
    :price => entry.xpath('im:price').attr('amount').value,
    :currency => entry.xpath('im:price').attr('currency').value,
    :releaseDate => Time.iso8601(entry.xpath('im:releaseDate').text),
  }

  puts app_detail

  application = Application.where(:id => app_id).
    first_or_create(:bundle_id => app_bundle_id,
                    :ipad => false,
                    :iphone => true,
                    :artist => artist)

  application_detail = ApplicationDetail.where(:application_id => app_id, :region_code => ranking_category[:region_code]).first_or_create()
  application_detail.icon_url = entry.xpath('im:image[@height="100"]').text()
  application_detail.summary = entry.css('summary').text()
  application_detail.application = application
  application_detail.save

  history = RankingHistory.create(
    :update_time => update_time,
    :category_id => ranking_category[:id],
    :region_code => ranking_category[:region_code].upcase,
    :ranking => index + 1,
    :application => application
    )
}
