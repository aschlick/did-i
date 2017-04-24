class ReplacementsController < ApplicationController

  before_action :setup_item

  def create
    replacement = @item.replacements.create( replaced_at: params[:time] || DateTime.current)
    redirect_to items_url
  end

  private

  def setup_item
    @item = Item.find(params[:item_id])
  end

end
