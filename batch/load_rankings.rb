require 'open-uri'

rankings = [
  'topfreeapplications',
  'toppaidapplications',
  'topgrossingapplications',
]

app_root = Rails.application.config.root
rss_storage_path = Rails.application.config.rss_storage_path
rss_storage_path = "#{app_root}/#{rss_storage_path}"

region = Region.find_by_code('JP')

rankings.each do |ranking|
  Category.where(:level => [0,1]).each do |category|
    region_code = region.code.downcase
    genre = category.id
    rss_url = "https://itunes.apple.com/#{region_code}/rss/#{ranking}/limit=300/genre=#{genre}/xml"
    puts rss_url

    target_xml = "#{rss_storage_path}/#{region_code}_#{ranking}_#{genre}_#{category.label}.xml"
    open(target_xml, 'w+:UTF-8') do |file|
      file << open(rss_url, "r:UTF-8").read
      process_ranking(target_xml)
    end
  end
end
