class ApplicationsController < ApplicationController

  def new
    @pets = Pet.find(favorites.contents.keys)
  end

  def create
    Application.create(application_params)
    remove_app_pets
    flash[:notice] = "Your application has been submitted"

    redirect_to "/favorites"
  end

  private

  def remove_app_pets
    app_pets = params[:applied_for]
    app_pets.each {|pet| favorites.contents.delete(pet)}
  end

  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone, :description)
  end

end
