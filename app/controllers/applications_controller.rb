class ApplicationsController < ApplicationController
  def index
  end

  def search
    @result = Application.joins(:details).where("applications.id = :id OR application_details.name ILIKE :kw", {:id => params[:keyword], :kw => "%#{params[:keyword]}%"} )

    if (@result.empty?)
      render :status => 404
    end
  end
end
