json.array!(@tweets) do |tweet|
  json.extract! tweet, :id, :keyword, :result_type, :limit
  json.url tweet_url(tweet, format: :json)
end
