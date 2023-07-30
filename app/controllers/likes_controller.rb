class LikesController < ApplicationController
  before_action :set_like, only: %i[destroy]
  before_action :authenticate_user!

  # POST /likes
  def create
    tweet = Tweet.find(params[:like][:tweet_id])
    current_user.likes.create(tweet:)
    redirect_back(fallback_location: root_path)
  end

  # DELETE /likes/1
  def destroy
    @like.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_like
    @like = Like.find(params[:id])
  end

  # No es necesario tener like_params para la acción create, ya que no se usa.
end
