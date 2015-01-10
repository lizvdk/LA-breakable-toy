class ReportsController < ApplicationController
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
    end
  end

  private

  def report_params
    params.require(:report).permit(:category_id, :user_id, :description,
                                   :latitude, :longitude)
  end
end
