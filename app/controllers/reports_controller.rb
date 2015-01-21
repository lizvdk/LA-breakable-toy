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
          photo: report.photo.small_thumb.url,
          created_at: report.created_at.localtime,
          updated_at: report.updated_at.localtime.strftime("%m/%d/%Y at %I:%M%p"),
          id: "report-#{report.id}",
          icon: {
            html: report.iconHTML,
            iconSize: [50, 50],
            iconAnchor: [25, 25],
            popupAnchor: [0, -25],
            className: "#{report.marker_color} map-icon"
          }
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

  def edit
    @report = current_user.reports.find(params[:id])
  end

  def update
    @report = current_user.reports.find(params[:id])
    if @report.update(report_params)
      flash[:notice] = "Your report has been updated successfully"
      redirect_to report_path(@report)
    else
      render :edit
    end
  end

  def destroy
    @report = current_user.reports.find(params[:id])
    if @report.destroy
      flash[:notice] = "Report deleted"
      redirect_to reports_path
    else
      render :show
    end
  end

  private

  def report_params
    params.require(:report).permit(:category_id, :user_id, :description,
                                   :latitude, :longitude, :address, :photo)
  end
end
