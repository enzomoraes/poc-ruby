class CartItemsController < ApplicationController
  include DomainExceptions
  before_action :validate_user_id, only: %i[ index destroy ]
  before_action :set_user, only: %i[ index destroy ]

  # GET /cart_items
  def index
    if @user
      aggregated_items = CartItem.aggregate_for_user(@user.id)
      render json: aggregated_items
    else
      render json: { error: "User with id #{params[:user_id]} not found" }, status: :not_found
    end
  end

  # POST /cart_items
  def create
    user_id = cart_item_params[:user_id]
    product_id = cart_item_params[:product_id]
    quantity = cart_item_params[:quantity].to_i

    @cart_item = CartItem.find_or_initialize_by(user_id: user_id, product_id: product_id)
    if quantity.zero?
      @cart_item.destroy if @cart_item.persisted?
      head :no_content
    else
      @cart_item.quantity = quantity
      if @cart_item.save
        render json: @cart_item, status: :created, location: cart_items_url(user_id: @cart_item.user_id)
      else
        render json: @cart_item.errors, status: :unprocessable_entity
      end
    end
  end

  # DELETE /cart_items
  def destroy
    if @user
      @user.cart_items.destroy_all
      head :no_content
    else
      render json: { error: "User with id #{params[:user_id]} not found" }, status: :not_found
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # Only allow a list of trusted parameters through.
    def cart_item_params
      params.require(:cart_item).permit(:user_id, :product_id, :quantity)
    end

    # Only allow updating quantity
    def update_cart_item_params
      params.require(:cart_item).permit(:quantity)
    end

    def validate_user_id
      unless params[:user_id].present?
        render json: { error: "User ID is required" }, status: :bad_request
      end
    end

    def set_user
      @user = User.find_by(id: params[:user_id])
    end

end