class TwitterController < ApplicationController
  before_action :set_twitter, only:[:index, :trends]


  def index
    @tweets = Tweet.all
    @first_tweet = @tweets.first
  end

  def trends

  end

  private

  def set_twitter
    @client = Twitter::REST::Client.new(:consumer_key => TWITTER_CONSUMER_KEY,
    :consumer_secret => TWITTER_CONSUMER_SECRET, :token => TWITTER_ACCESS_TOKEN,
    :secret => TWITTER_ACCESS_SECRET)
  end
end
