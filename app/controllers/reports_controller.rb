class ReportsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @reports = Report.all
    @features = []
    @reports.each do |report|
      @features << {
        type: "Feature",
        geometry: {
          type: "Point",
          coordinates: [report.longitude, report.latitude]
        },
        properties: {
          category: report.category.name,
          url: report_path(report),
          photo: "http://lorempixel.com/g/100/100/city/"
        }
      }
    end
    @geojson = Hash.new
    @geojson[:type] = "FeatureCollection"
    @geojson[:features] = @features

    respond_to do |format|
      format.html
      format.json { render json: @geojson }
    end

  end

  def show
    @report = Report.find(params[:id])
  end

  def new
    @report = Report.new
  end

  def create
    @report = Report.new(report_params)
    @report.user = current_user
    if @report.save
      redirect_to report_path(@report), notice: "Report Submitted"
    else
      render :new
    end
  end

  private

  def report_params
    params.require(:report).permit(:category_id, :user_id, :description,
                                   :latitude, :longitude)
  end
end
