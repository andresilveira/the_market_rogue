class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def destroy
    Item.destroy(params[:id])

    respond_to do |format|
      format.html { redirect_to items_path }
    end
  end
end
