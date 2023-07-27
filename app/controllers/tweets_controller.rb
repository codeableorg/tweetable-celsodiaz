# tweets_controller.rb

class TweetsController < ApplicationController
  before_action :set_tweet, only: %i[show edit update destroy]

  # GET /tweets
  def index
    @tweets = Tweet.all
  end

  # GET /tweets/1
  def show
    @tweet ||= Tweet.find(params[:id]) # Establecer @tweet solo si no está definida
    @replies = Tweet.where(replied_to_id: @tweet.id) # Obtiene las respuestas relacionadas
  
    # O también podrías hacerlo utilizando la asociación si la tienes configurada:
    # @replies = @tweet.replies
  
    # Resto del código...
  end

  def like
    @tweet = Tweet.find(params[:id])
    @tweet.increment!(:likes_count)
    puts "Likes count after increment: #{@tweet.likes_count}"
    render json: { likes_count: @tweet.likes_count }
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets
  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.replied_to_id = params[:tweet][:replied_to_id] # Establecer el tweet al que se responde
  
    if @tweet.save
      if @tweet.replied_to_id.present?
        redirect_to tweet_path(@tweet.replied_to_id), notice: "Reply was successfully created."
      else
        redirect_to tweets_path, notice: "Tweet was successfully created."
      end
    else
      render :show
    end
  end
  

  # PATCH/PUT /tweets/1
  def update
    if @tweet.update(tweet_params)
      redirect_to @tweet, notice: "Tweet was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /tweets/1
  def destroy
    @tweet.destroy
    redirect_to tweets_url, notice: "Tweet was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tweet_params
      params.require(:tweet).permit(:body, :replies_count, :likes_count, :user_id, :replied_to_id)
    end
end
