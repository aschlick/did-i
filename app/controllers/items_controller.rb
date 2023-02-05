class ItemsController < ApplicationController
  def index
    @items = Item.where(user_id: current_user.id)
  end

  def new
    @item = Item.new
  end

  def create
    @button_text = 'Create'
    @item = Item.new
    assign_params
    @item.save

    if @item.valid?
      redirect_to items_path
    else
      render :new
    end
  end

  def destroy
    Item.find(params[:id]).destroy
    redirect_to items_path
  end

  def edit
    @button_text = 'Update'
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    assign_params
    if @item.valid?
      @item.save
      redirect_to items_path
    else
      render :edit
    end
  end

  private

  def assign_params
    @item.name = params[:item][:name]
    @item.period_count = params[:item][:period_count].to_i
    @item.period_type = params[:item][:period_type].downcase
    @item.user_id = current_user.id
  end
end
