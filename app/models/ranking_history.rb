require 'nokogiri'


class RankingHistory < ActiveRecord::Base
  attr_accessible :update_time, :region_code, :category_id, :ranking, :application, :application_id
  belongs_to :application

  def self.record(file)
    dom = Nokogiri::XML(open(file, 'r:UTF-8'))

    category_raw =  file.split("/").last.split("_")
    ranking_category = {
      :id => category_raw[-2],
      :region_code => category_raw[-4],
    }

    update_time = Time.iso8601(dom.css('feed > updated').text)

    #load each entry
    dom.css('entry').each_with_index { |entry, index|
      # Redy to update
      category_id = entry.css('category').attr('id').value
      category = Category.find(category_id)

      artist_node = entry.xpath('im:artist')
      artist_url = artist_node.attr('href').value
      artist_id = artist_url.match(/id(\d+)/)[1]
      artist_name = artist_node.text()
      artist = Artist.find_or_create_by_id(artist_id)
      artist.update_attributes({:id => artist_id, :name => artist_name})

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


      application = Application.find_or_create_by_id(app_id)
      application.update_attributes(:bundle_id => app_bundle_id,
                                    :ipad => false,
                                    :iphone => true,
                                    :artist => artist)

      application_detail =
        ApplicationDetail.find_or_create_by_application_id_and_region_code(
          app_id,
          ranking_category[:region_code]
        )

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

  end
end
