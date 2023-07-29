class TweetsController < ApplicationController
  before_action :set_tweet, only: %i[show edit update destroy]

  # GET /tweets
  def index
    @tweets = Tweet.all.sort_by { |tweet| tweet.created_at }.reverse
    @user = current_user
  end

  # GET /tweets/1
  def show
    @tweet ||= Tweet.find(params[:id]) # Establecer @tweet solo si no está definida
    @replies = Tweet.where(replied_to_id: @tweet.id).order(created_at: :desc) # Obtiene las respuestas relacionadas
    @user = @tweet.user
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
    @user = current_user 
  end

  # GET /tweets/1/edit
  def edit
    @tweet = Tweet.find(params[:id])
    session[:return_to] = request.referer
  end

  # POST /tweets
  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.replied_to_id = params[:tweet][:replied_to_id] # Establecer el tweet al que se responde
    @tweet = current_user.tweets.build(tweet_params)
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
    @tweet = Tweet.find(params[:id])
    if @tweet.update(tweet_params)
      redirect_to session.delete(:return_to), notice: "Tweet was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /tweets/1
  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Tweet deleted successfully!" }
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@tweet) }
    end
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
