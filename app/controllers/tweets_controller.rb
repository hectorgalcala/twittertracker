class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]
  before_action :set_twitter, only: [:index, :show]

  api_key = {
  consumer_key: "TZnjmcMkWVwGmFESPNpLpYvhm",
  consumer_secret: "m7EJpSI9mDN6PIfxmc3WC4MRW4idNMojQ0SZkjlPjBg0gRxMHZ",
  access_token: "38503207-vNSvaBgpbVK4elAmB7UGGqvzyzZuRUunWdo272wEG",
  access_token_secret:"84bgcso2APKq2eyd49QIThrF6fFw34FBvbrEufRkxnk93"
  }
  TWITTER_CONSUMER_KEY = api_key[:consumer_key]
  TWITTER_CONSUMER_SECRET = api_key[:consumer_secret]
  TWITTER_ACCESS_TOKEN = api_key[:access_token]
  TWITTER_ACCESS_SECRET = api_key[:access_token_secret]



  # GET /tweets
  # GET /tweets.json
  def index
    @tweets = Tweet.all
  end

  # GET /tweets/1
  # GET /tweets/1.json
  def show
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets
  # POST /tweets.json
  def create
    @tweet = Tweet.new(tweet_params)

    respond_to do |format|
      if @tweet.save
        redirect_to @tweet, notice: 'Tweet was successfully created.'
      else
        render :new
      end
    end
  end

  # PATCH/PUT /tweets/1
  # PATCH/PUT /tweets/1.json
  def update
      if @tweet.update(tweet_params)
         redirect_to @tweet, notice: 'Tweet was successfully updated.'
      else
        render :edit
      end
  end

  # DELETE /tweets/1
  # DELETE /tweets/1.json
  def destroy
    @tweet.destroy
    redirect_to tweets_url, notice: 'Tweet was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tweet_params
      params.require(:tweet).permit(:keyword, :result_type, :limit)
    end

    def set_twitter
      @client = Twitter::REST::Client.new(:consumer_key => TWITTER_CONSUMER_KEY,
      :consumer_secret => TWITTER_CONSUMER_SECRET, :token => TWITTER_ACCESS_TOKEN,
      :secret => TWITTER_ACCESS_SECRET)
    end
end
