class ItemsController < ApplicationController
  def index
    @items = Item.where(users_id: current_user.id)
  end
end
