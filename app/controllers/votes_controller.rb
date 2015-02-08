class VotesController < ApplicationController
  before_filter :authenticate_user!

  def create
    report = Report.find(params[:report_id])
    vote = current_user.votes.build
    vote.report = report
    respond_to do |format|
      if vote.save
        format.html { redirect_to :back, notice: "Your concern has been recorded!" }
        format.json { render json: vote }
      else
        format.html { redirect_to :back }
        format.json { render json: vote.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    current_user.votes.destroy(params[:id])
    respond_to do |format|
      format.html { redirect_to :back, notice: "Your vote has been removed" }
      format.json { head :no_content }
    end
  end
end
