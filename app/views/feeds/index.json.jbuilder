json.array!(@feeds) do |feed|

  json.extract! feed, *%i( id name url )

end
