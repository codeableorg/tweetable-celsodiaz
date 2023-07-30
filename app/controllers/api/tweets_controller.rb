module Api
  class TweetsController < ApiController
    def index
      @tweets = Tweet.all.includes(:replies)
      render json: @tweets, include: :replies, status: :ok
    end

    def show
      @tweet = Tweet.find(params[:id])
      render json: @tweet, include: :replies, status: :ok
    end
  end
end
