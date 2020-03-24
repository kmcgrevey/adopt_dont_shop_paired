class ReviewsController < ApplicationController

  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    @shelter = Shelter.find(params[:shelter_id])
    review = @shelter.reviews.new(review_params)
    if review.save
      redirect_to "/shelters/#{@shelter.id}"
    else
      flash[:notice] = "Please fill in title, rating, and content"
      render :new
    end

  def edit
    @shelter = Shelter.find(params[:shelter_id])
  end
end

  private

  def review_params
    params.permit(:title, :rating, :content, :picture)
  end
end
