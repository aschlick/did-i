class StaticController < ActionController::Base
  def landing
    if @current_user
      redirect_to items_url
    end
  end

  def unconfirmed
  end
end
