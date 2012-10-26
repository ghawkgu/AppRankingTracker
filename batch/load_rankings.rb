require 'open-uri'
require 'queue_classic'

rankings = [
  'topfreeapplications',
  'toppaidapplications',
  'topgrossingapplications',
]

app_root = Rails.application.config.root
rss_storage_path = Rails.application.config.rss_storage_path
rss_storage_path = "#{app_root}/#{rss_storage_path}"

region = Region.find_by_code('JP')

timestamp = Time.now.strftime("%Y%m%d%H%M")

rankings.each do |ranking|
  Category.where(:level => [0,1]).each do |category|
    region_code = region.code.downcase
    genre = category.id
    rss_url = "https://itunes.apple.com/#{region_code}/rss/#{ranking}/limit=300/genre=#{genre}/xml"
    puts rss_url

    target_xml = "#{rss_storage_path}/#{timestamp}_#{region_code}_#{ranking}_#{genre}_#{category.label}.xml"
    open(target_xml, 'w+:UTF-8') do |file|
      file << open(rss_url, "r:UTF-8").read
    end

    QC::enqueue("RankingHistory.record", target_xml)

  end
end
