class ApplicationsController < ApplicationController

  def new
    @pets = Pet.find(favorites.contents.keys)
  end

  def create
    if params[:applied_for] == nil
      flash[:notice] = "You have no favorites to apply for" #<---WORKS!
      redirect_to "/pets"
    else
      application = Application.new(application_params)
      if application.save
        applied_for = params[:applied_for]
        applied_for.each do |pet_id|
          pet = Pet.find(pet_id)
          application.application_pets.create!(pet_id: pet.id, application_id: application.id)
        end
        remove_app_pets
        flash[:notice] = "Your application has been submitted"
        redirect_to "/favorites"
      else
        @pets = Pet.find(favorites.contents.keys)
        flash[:notice] = "Please fill in the required fields"
        render :new
      end
    end
  end

  def update
    pet = Pet.find(params[:pet_id])
    application = Application.find(params[:app_id])
    pet.update_column(:status, "Pending")
    flash[:notice] = "On hold for #{application.name}"
    redirect_to "/pets/#{pet.id}"
  end

  def show
    @application = Application.find(params[:id])
  end

  def index
    @pet = Pet.find(params[:pet_id])
  end

  private

  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone, :description)
  end

  def remove_app_pets
    app_pets = params[:applied_for]
    app_pets.each {|pet| favorites.contents.delete(pet)}
  end
end
