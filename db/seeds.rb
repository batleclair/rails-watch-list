require 'open-uri'
require 'json'

puts "Cleaning the DB"
Bookmark.destroy_all
Movie.destroy_all
puts "DB cleaned"

url = 'https://tmdb.lewagon.com/movie/top_rated'
movies_serialized = URI.open(url).read
movies = JSON.parse(movies_serialized)['results']
movies.each do |movie|
  Movie.create(
    title: movie['title'],
    overview: movie['overview'],
    poster_url: "https://image.tmdb.org/t/p/original#{movie['poster_path']}",
    rating: movie['vote_average']
  )
end
puts "Movies created"
