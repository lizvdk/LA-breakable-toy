class VotesController < ApplicationController
  before_filter :authenticate_user!

  def create
    report = Report.find(params[:report_id])
    vote = current_user.votes.build
    vote.report = report

    if vote.save
      redirect_to :back, notice: "Your concern has been recorded!"
    else
      redirect_to :back
    end
  end

  def destroy
    current_user.votes.destroy(params[:id])
    redirect_to :back, notice: "Your vote has been removed"
  end
end
