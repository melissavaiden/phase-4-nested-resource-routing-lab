class ItemsController < ApplicationController

  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items
    else
      items = Item.all
    end
    render json: items, include: :user
  rescue ActiveRecord::RecordNotFound
    render_not_found
  end

  def show
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items
      item = items.find(params[:id])
    else
      item = Item.find(params[:id])
    end
    render json: item, include: :user
  rescue ActiveRecord::RecordNotFound
    render_not_found
  end

  def create
    if params[:user_id]
      user = User.find(params[:user_id])
      new_item = user.items.create(name: params[:name], description: params[:description], price: params[:price])
      render json: new_item, status: :created
    end
  rescue ActiveRecord::RecordNotFound
    render_not_found
  end

  private

  def render_not_found
    render json: { error: 'user not found'}, status: :not_found
  end

end
