require 'sinatra'
require 'sinatra/reloader'
require 'httparty'
require 'pry'

#Home page
get '/' do 
	erb(:index)
end

get '/about/:titleSearch' do
# get '/about' do
	result = HTTParty.get("http://www.omdbapi.com/?t=#{params[:titleSearch]}")
	@movie_title = result["Title"]
	@movie_year = result["Year"]
	@movie_stars = result["Actors"].to_s
	@movie_posterURL = result["Poster"].to_s
	@movie_plot = result["Plot"]
	erb :about
end

 #for dynamic urls
get'/about' do
	search = params[:titleSearch]
	 if search.include? " "
    search.gsub!(" ","+")
  end
  if search.include? "'"
    search.gsub!("'","%27")
  end

	redirect to "/about/#{params[:titleSearch]}"
end 

## ====================for Browse functionality instead of search - use s not t
# get'/list/:titleBrowse' do
get'/list' do
		resultList = HTTParty.get("http://www.omdbapi.com/?s=#{params[:titleBrowse]}")

		@search = params[:titleBrowse]
		@resultArray = resultList["Search"]

		

	erb :list
end 
 #=====================
# get'/list' do
# 	redirect to "/list/#{ params[:titleBrowse]}"
# end 


=begin
puts 'Enter the title of a movie to search for'
#searching = gets.chomp - hardcoded for now
searching = "titanic"

result = HTTParty.get("http://www.omdbapi.com/?t=#{searching}")

puts "TITLE - #{result["Title"]} "
puts "YEAR - " + result["Year"]
puts "STARRING - " + result["Actors"] #HASH notation needed[], not object.

##################### make dynamic!
get '/about/:search_movie' do
​
  base_url = "http://www.omdbapi.com/?t="
  search = params[:search_movie]
  if search.include? " "
    search.gsub!(" ","+")
  end
  if search.include? "'"
    search.gsub!("'","%27")
  end
    @search_title = HTTParty.get(base_url + search)["Title"]
    @search_poster = HTTParty.get(base_url + search)["Poster"]
  erb :about
​
end
	
=end