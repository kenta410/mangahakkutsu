class Public::CustomersController < ApplicationController
  before_action :ensure_current_customer, only: [:edit, :update]

  def show
    @customer = Customer.find(params[:id])
    @comics = @customer.comics
    @comic = Comic.new
  end

  def index
    @customers = Customer.all.page(params[:page]).per(10)
    @comic = Comic.new
  end

  def edit
     @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to customer_path(@customer), notice: "You have updated customer successfully."
    else
      @customer = Customer.all
      render "edit"
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :profile_image, :introduction, :email, :is_deleted)
  end

  def ensure_current_customer
    @customer = Customer.find(params[:id])
    unless @customer == current_customer
      redirect_to customer_path(current_customer)
    end
  end
end
