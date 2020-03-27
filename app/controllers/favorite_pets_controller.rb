class FavoritePetsController < ApplicationController

  def destroy
    pet = Pet.find(params[:pet_id])
    favorites.contents.delete(pet.id.to_s)
    flash[:notice] = "#{pet.name} has been removed from your favorites."
    redirect_to "/favorites" 
  end
end