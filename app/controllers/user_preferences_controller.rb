class UserPreferencesController < ApplicationController
  def edit
    @prefences = current_user.user_preference || current_user.create_user_preference
  end

  def update
    current_user.user_preference.update!(allowed_params)

    flash[:success] = "Successfully updated preferences"

    redirect_to edit_user_preference_path
  end

  def allowed_params
    params.require(:user_preference).permit(:notification_time)
  end
end
