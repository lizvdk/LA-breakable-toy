module Admin
  class ReportsController < ApplicationController
    def index
      @reports = Report.all
    end

    def update
      @report = Report.find(params[:id])
      if @report.update(report_params)
        flash[:notice] = "Report Updated"
        redirect_to admin_reports_path
      else
        render :index
      end
    end

    private

    def report_params
      params.require(:report).permit(:category_id, :user_id, :description,
      :latitude, :longitude, :address, :photo, :status)
    end
  end
end
