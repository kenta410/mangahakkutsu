class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @customer = Customer.find(params[:id])
    @comics = @customer.comics
    @coments = @customer.comments
  end

  def index
    @customers = Customer.all.page(params[:page]).per(10)
  end

  def edit
    @customer = Customer.find([:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admin_customers_path(@customer), notice: "You have updated customer successfully."
    else
      render "edit"
    end
  end


  private

  def customer_params
    params.require(:customer).permit(:name, :introduction, :email, :is_deleted)

  end
end
