class TwitterController < ApplicationController
  before_action :set_twitter, only:[:index, :trends]
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
