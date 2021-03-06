class Public::CustomersController < ApplicationController
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
  end

  def update
    if @customer.update(customer_params)
      redirect_to customer_path(@customer), notice: "You have updated customer successfully."
    else
      render "edit"
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :introduction, :email, :is_deleted)
  end

  def ensure_current_customer
    @customer = Customer.find(params[:id])
    unless @customer == current_customer
      redirect_to customer_path(current_customer)
    end
  end
end
