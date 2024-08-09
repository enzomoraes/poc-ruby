class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show update destroy activate deactivate ]
  before_action :validate_active_param, only: %i[ index ]

  # GET /products
  def index
    @products = Product.active(@active_status)

    render json: @products
  end

  # GET /products/1
  def show
    if @product.active
      render json: @product
    else
      head :not_found
    end
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy!
  end

  # PATCH /products/1/activate
  def activate
    if @product.update(active: true)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH /products/1/deactivate
  def deactivate
    if @product.update(active: false)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :description, :price, :model)
    end

    def validate_active_param
      # Check if 'active' parameter is present and valid
      if params[:active].present? && %w(true false).include?(params[:active])
        @active_status = params[:active] == 'true'
      else
        render json: { error: 'Required parameter `active` is missing or invalid' }, status: :unprocessable_entity
      end
    end
end
