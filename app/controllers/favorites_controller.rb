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
    # @applied_pets = []
    # @fav_pets.each do |pet|
    #   if pet.status == "Pending"
    #     @applied_pets << pet
    #   end
    # end
  end
  # <% if @applied_pets.count == 0 %>
  #   <h3>You haven't applied for the adoption of any pets</h3>
  # <% else %>
  #   <% @applied_pets.each do |pet| %>
  #       <section id="applied-<%=pet.id%>">
  #         <%= link_to "#{pet.name}", "/pets/#{pet.id}" %>
  #         <br/>
  #         <br/>
  # <% end %>

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
end
