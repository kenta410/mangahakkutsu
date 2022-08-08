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
      render "edit"
    end
  end

  def unsubscribe
  end


  def withdraw
    @customer = current_customer
    @customer.update(is_delete: true)
    reset_session
    flash[:notice] = "退会処理を完了しました"
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :profile_image, :introduction, :email, :is_delete)
  end

  def ensure_current_customer
    @customer = Customer.find(params[:id])
    unless @customer == current_customer
      redirect_to customer_path(current_customer)
    end
  end
end
