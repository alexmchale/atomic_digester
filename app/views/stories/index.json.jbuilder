json.array!(@stories) do |story|

  #binding.pry if story.content =~ /img/i

  json.extract! story, :title
  json.extract! story, :author
  json.extract! story, :published
  json.extract! story, :summary
  json.content story.content
  json.extract! story, :url

end
