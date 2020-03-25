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
      flash.now[:notice] = "Please fill in title, rating, and content"
      render :new
    end
  end

  def edit
    @review = Review.find(params[:review_id])
  end

  def update
    @review = Review.find(params[:review_id])
    if @review.update(review_params)
      redirect_to "/shelters/#{@review.shelter.id}"
    else
      flash.now[:notice] = "Please fill in title, rating, and content"
      render :edit
    end
  end

  def destroy
    review = Review.find(params[:review_id])
    shelter = review.shelter
    review.destroy
    redirect_to "/shelters/#{shelter.id}"
  end

  private

  def review_params
    params.permit(:title, :rating, :content, :picture)
  end
end
