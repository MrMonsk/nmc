class BetaCandidatesController < ApplicationController
  def create
    BetaCandidate.create!(beta_candidate_params)
    flash[:success] = 'Thank you for signing up for the beta! You will be notified when the site goes live.'
    redirect_to root_path
  rescue ActiveRecord::RecordInvalid => e
    flash[:info] = e.message
    redirect_to root_path
  end

  private

  def beta_candidate_params
    params.require(:beta_candidate).permit(:email)
  end
end
