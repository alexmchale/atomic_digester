json.array!(@feeds) do |feed|

  json.extract! feed, :id
  json.extract! feed, :name

  json.url feed_url(feed, format: :json)

end
