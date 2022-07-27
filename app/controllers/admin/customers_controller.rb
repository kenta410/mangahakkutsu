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
    @customer.name = params[:customer][:name]
    @customer.introduction = params[:customer][:introduction]
    @customer.email = params[:customer][:email]
    if @customer.save
      redirect_to admin_customers_path(@customer)
    else
      render "edit"
    end
  end


  private

  def customer_params
    params.require(:customer).permit(:name, :introduction, :email, :is_deleted)

  end
end
