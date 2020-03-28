class ApplicationsController < ApplicationController

  def new
    @pets = Pet.find(favorites.contents.keys)
  end

  def create
    Application.create(application_params)
    # need to remove pets applied for from favorites # <--own method??
    # flash "Your application has been submitted"
    # redirect_to "/favorites"

    # params[:applied_for] # <-- ???
  end

  # need application_params
  private

  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone, :description)
  end

end
