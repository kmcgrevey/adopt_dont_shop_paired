class FavoritesController < ApplicationController

  def update
    pet = Pet.find(params[:pet_id])
    pet_id_str = pet.id.to_s
    session[:favorites] ||= Hash.new
    session[:favorites][pet_id_str] ||= 1
    # session[:favorites][pet_id_str] ||= pet
    flash[:notice] = "#{pet.name} has been added to your favorites"
    redirect_to "/pets/#{pet.id}"
  end

  def index
    @fav_pets = Pet.where(id: favorites.contents.keys)
    @applied_pets = pets_with_app
  end

  def destroy
    pet = Pet.find(params[:pet_id])
    favorites.contents.delete(pet.id.to_s)
    flash[:notice] = "#{pet.name} has been removed from your favorites."
    redirect_to "/pets/#{pet.id}"
  end

  def destroy_favs
    session[:favorites] = Hash.new
    redirect_to '/favorites'
  end

  def pets_with_app
    if Application.all == []
      0
    else
      Pet.distinct.joins(:application_pets)
    end
  end
end
