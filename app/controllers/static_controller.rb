class StaticController < ActionController::Base
  def landing
    puts user_signed_in?
    if user_signed_in?
      redirect_to items_url
    end
  end

  def unconfirmed
  end
end
