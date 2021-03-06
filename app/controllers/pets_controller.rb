class PetsController < ApplicationController

  def index
    @pets = Pet.all
  end

  def show
    @pet = Pet.find(params[:pet_id])
  end

  def edit
    @pet_to_edit = Pet.find(params[:pet_id])
  end

  def update
    @pet_to_edit = Pet.find(params[:pet_id])
    if @pet_to_edit.update(pet_params)
      redirect_to "/pets/#{params[:pet_id]}"
    else
      flash.now[:error] = @pet_to_edit.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    pet_to_delete = Pet.find(params[:pet_id])
    if pet_to_delete.status == "Pending"
      flash[:error] = "Pet cannot be deleted due to pending application status"
        redirect_to "/pets/#{pet_to_delete.id}"
    else
      favorites.contents.delete(pet_to_delete.id.to_s)
      pet_to_delete.destroy
      redirect_to "/pets/"
    end
  end

  private

  def pet_params
    params.permit(:image, :name, :description, :approx_age, :sex)
  end
end
