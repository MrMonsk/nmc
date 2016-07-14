class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def edit
    @profile = Profile.find_by_id(params[:id])
    verify_edit(@profile)
  end

  def update
    @profile = Profile.find_by_id(params[:id])
    new_profile = profile_params

    if verify_update(@profile, new_profile)
      @profile.update_attributes(new_profile)
      redirect_to profile_path(id: @profile.id), notice: 'Your profile has been updated successfully!'
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:bio, :url, :stage_name, :image)
  end

  def owner?(profile)
    message = 'You are not the owner of this performance.'
    return true if profile.user_id == current_user.id
    redirect_to profile_path(profile), alert: message
    false
  end

  def verify_edit(profile)
    redirect_to profile_path, alert: 'Oops! Profile not found.' if profile.blank?
    return true if owner?(profile)
    false
  end

  def verify_update(old_profile, new_profile)
    message = 'Oops! It looks like you forgot to enter a bio.'
    redirect_to edit_profile_path, id: old_profile.id, alert: message if new_profile[:bio].blank?
    return true if owner?(old_profile)
    false
  end
end
