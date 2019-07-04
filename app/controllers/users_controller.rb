class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    @user.build_address
    @user.build_company
    @user.company.build_address
  end

  def create
    @user = User.new(permited_params)

    if @user.save
      redirect_to @user
    else
      render :new
    end
  end

  private

  def permited_params
    params.require(:user).permit(:first_name, :last_name, :email_address, :date_of_birth, :phone_number,
                                 address_attributes: [
                                     :street, :city, :zip_code, :country
                                 ],
                                 company_attributes: [
                                     :name,
                                     address_attributes: [
                                            :street, :city, :zip_code, :country
                                      ]
                                 ])
  end
end


