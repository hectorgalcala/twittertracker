class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]
  before_action :set_twitter, only: [:index, :show]

  helper_method :word_filter


  TWITTER_CONSUMER_KEY = App.all.find(1).consumer_key
  TWITTER_CONSUMER_SECRET = App.all.find(1).consumer_secret
  TWITTER_ACCESS_TOKEN = App.all.find(1).access_token
  TWITTER_ACCESS_SECRET = App.all.find(1).access_token_secret
  word_list = %w(REVOLUCIONARIA REVOLUCIONARIO Revolucionario revolucionario Revolucionaria revolucionaria socialista Socialista SOCIALISTA chavista Chavista CHAVISTA Chávez chávez VENEZOLANA VENEZOLANO Venezolano Venezolana venezolana venezolano ACTIVISTA activista Activista comunista Comunista COMUNISTA radical Radical RADICAL MADURISTA madurista Madurista anti-imperialista comandante supremo intergalactico)
  word_list = ["REVOLUCIONARIA", "REVOLUCIONARIO", "Revolucionario", "revolucionario", "Revolucionaria", "revolucionaria", "socialista", "Socialista", "SOCIALISTA", "chavista", "Chavista", "CHAVISTA", "Chávez", "chávez", "VENEZOLANA", "VENEZOLANO", "Venezolano", "Venezolana", "venezolana", "venezolano", "ACTIVISTA", "activista", "Activista", "comunista", "Comunista", "COMUNISTA", "radical", "Radical", "RADICAL", "MADURISTA", "madurista", "Madurista", "anti-imperialista", "comandante", "supremo", "intergalactico"]
  # GET /tweets
  # GET /tweets.json
  def index
    @tweets = Tweet.all
  end

  # GET /tweets/1
  # GET /tweets/1.json
  def show
    @search = @client.search(@tweet.keyword, result_type: @tweet.result_type).take(@tweet.limit)
    word_list = %w(REVOLUCIONARIA REVOLUCIONARIO Revolucionario revolucionario Revolucionaria revolucionaria socialista Socialista SOCIALISTA chavista Chavista CHAVISTA Chávez chávez VENEZOLANA VENEZOLANO Venezolano Venezolana venezolana venezolano ACTIVISTA activista Activista comunista Comunista COMUNISTA radical Radical RADICAL MADURISTA madurista Madurista anti-imperialista comandante supremo intergalactico)

    @query = @search.select { |tweet| word_filter(tweet.user.description, word_list)  }
    # @query = @search.select { |tweet| tweet.user.description.include? word_list[3] }


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
      if @tweet.save
        redirect_to @tweet, notice: 'Tweet was successfully created.'
      else
        render :new
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

    def word_filter(text, words_array)

      words_array.each do |word|
        return true if text.include?(word)
      end

      false

    end


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
