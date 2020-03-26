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
    # favorites.contents["269"]["name"]
    # binding.pry
    # @favorites_list = favorites.contents.keys.to_i
  end 
end