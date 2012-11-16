class RankingHistoriesController < ApplicationController
  def list
    app = Application.find_by_id(params[:id])
    detail = app.details.first
    @app_details = detail

    order = 'region_code ASC, category_id ASC, update_time DESC'
    @gross_ranking = app.rankings.where("category_id = '0'").order(order).limit(144)
    @rankings = app.rankings.where("category_id <> '0'").order(order).limit(144)
  end
end
