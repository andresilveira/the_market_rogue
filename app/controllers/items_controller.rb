class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update]
  def index
    @items = Item.order(updated_at: :desc)
  end

  def show
  end

  def destroy
    Item.destroy(params[:id])

    respond_to do |format|
      format.html { redirect_to items_path }
    end
  end

  def update
    @item.update_attributes(item_params)
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:track_sellers, :track_buyers)
  end
end
