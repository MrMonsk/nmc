class BetaCandidatesController < ApplicationController
  def create
    BetaCandidate.create!(beta_candidate_params)
    flash[:success] = 'Thank you for signing up for the beta! You will be notified when the site goes live.'
    redirect_to root_path
  rescue ActiveRecord::RecordInvalid => e
    if e.message == 'Validation failed: Email has already been taken'
      flash[:info] = "It looks like you're already signed up for the beta!"
    elsif e.message == "Validation failed: Email can't be blank"
      flash[:info] = "Oops! It looks like you forgot to enter your email address."
    end
    redirect_to root_path
  end

  private

  def beta_candidate_params
    params.require(:beta_candidate).permit(:email)
  end
end
