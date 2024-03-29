class ProfilesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :update]

  def create
  end

  def edit
    @profile = found_profile
    verify_edit(@profile)
  end

  def update
    @profile = found_profile
    new_profile = profile_params

    if verify_update(@profile, new_profile)
      @profile.update_attributes(new_profile)
      redirect_to profile_path(id: @profile.id), notice: 'Your profile has been updated successfully!'
    end
  end

  private

  def found_profile
    Profile.find_by_id(params[:id])
  end

  def profile_params
    params.require(:profile).permit(:bio, :url, :stage_name, :image)
  end

  def owner?(profile, message = 'You are not the owner of this profile.')
    return true if profile.user_id == current_user.id
    redirect_to profile_path(profile), alert: message
    false
  end

  def verify_edit(profile)
    return true if profile && owner?(profile)
    redirect_to profile_path, alert: 'Oops! Profile not found.' if profile.blank?
    false
  end

  def verify_update(old_profile, new_profile, message = 'Oops! It looks like you forgot to enter a bio.')
    if new_profile[:bio].blank?
      redirect_to edit_profile_path, id: old_profile.id, alert: message
      return false
    end
    return true if owner?(old_profile)
    false
  end
end
