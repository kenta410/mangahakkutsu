class Admin::CustomersController < ApplicationController
  def show
    @customer = Customer.find(params[:id])
    @comics = Customer.comics
    @coments = Customer.coments
  end

  def index
    @customers = Customer.all.page(params[:page]).per(10)
  end

  def edit
    @customer = Customer.find([:id])
  end

  def update
    if @customer.update(customer_params)
      redirect_to admin_customer_path(@customer)
    else
      render "edit"
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :introduction, :email, :is_deleted)

  end
end
