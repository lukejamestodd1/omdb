require 'sinatra'
require 'sinatra/reloader'
require 'httparty'
require 'pry'
require 'pg'

require './db_config'
require './models/movie'


#TO RUN SQL
def run_sql(sql)
  db = PG.connect(dbname: 'moviesdatabase')
  results = db.exec(sql)
  db.close
  return results
end 


#HOME
get '/' do 
	erb(:index)
end

#show list of movies stored locally
get '/stored' do
  sql = "SELECT * FROM movies;"
  @movies = run_sql(sql)
  erb :stored
end


#TITLE SEARCH - RETURN ONE RESULT (t)
get'/title' do

  #first check whether object with same name in the database. in not, search OMDB. If so use local DB info

  #fix the title search spaces etc are ok
  search = params[:titleSearch]
  if search.include? " "
    search.gsub!(" ","+")
  end
  if search.include? "'"
    search.gsub!("'","%27")
  end


  @result = HTTParty.get("http://www.omdbapi.com/?t=#{search}")
  @movie_title = @result["Title"]
  @movie_year = @result["Year"]
  @movie_stars = @result["Actors"].to_s
  @movie_posterURL = @result["Poster"].to_s
  @movie_plot = @result["Plot"]

  # generate sql send to the database

  @keyArray = []
    @valueArray = []

    @result.each do |key, value| 
      @keyArray.push(key.to_s)
      @valueArray.push(value.to_s)
    end

    #PLOT does't store - too long
  sql = "INSERT INTO movies(
  title, 
  year, 
  rated, 
  released, 
  runtime, 
  genre, 
  director, 
  writer, 
  actors, 
   
  language, 
  country, 
  awards, 
  poster, 
  metascore, 
  imdbRating, 
  imdbVotes, 
  imdbID, 
  type, 
  response) VALUES (
  '#{@valueArray[0]}',
  '#{@valueArray[1]}',
  '#{@valueArray[2]}',
  '#{@valueArray[3]}',
  '#{@valueArray[4]}',
  '#{@valueArray[5]}',
  '#{@valueArray[6]}',
  '#{@valueArray[7]}',
  '#{@valueArray[8]}',
 
  '#{@valueArray[10]}',
  '#{@valueArray[11]}',
  '#{@valueArray[12]}',
  '#{@valueArray[13]}',
  '#{@valueArray[14]}',
  '#{@valueArray[15]}',
  '#{@valueArray[16]}',
  '#{@valueArray[17]}',
  '#{@valueArray[18]}',
  '#{@valueArray[19]}'
   );"

  run_sql(sql)
  
  erb :title
end 


#BROWSE LIST OF RESULTS (s)
get'/list' do
  resultList = HTTParty.get("http://www.omdbapi.com/?s=#{params[:titleBrowse]}")
  @search = params[:titleBrowse]
  @resultArray = resultList["Search"]
  erb :list
end 


#AFTER SELECTING RESULT, search by imdbID (i)

#first check whether object with same name in the database. in not, search OMDB. If so use local DB info

get '/about/:titleSearch' do

  sql = "SELECT * FROM movies"
  @movies = run_sql(sql)
  @movies.each do |movie|
    if movie['imdbID'] == params[:titleSearch]
      @result = movie
      @movie_title = @result["title"]
      @movie_year = @result["year"]
      @movie_stars = @result["actors"].to_s
      @movie_posterURL = @result["poster"].to_s
  
      erb :about
    end
  end

	@result = HTTParty.get("http://www.omdbapi.com/?i=#{params[:titleSearch]}")
	@movie_title = @result["Title"]
	@movie_year = @result["Year"]
	@movie_stars = @result["Actors"].to_s
	@movie_posterURL = @result["Poster"].to_s
	@movie_plot = @result["Plot"]

  # generate sql send to the database
  @keyArray = []
    @valueArray = []

    @result.each do |key, value| 
      @keyArray.push(key.to_s)
      @valueArray.push(value.to_s)
    end

  #PLOT does't store - too long
  sql = "INSERT INTO movies(
  title, 
  year, 
  rated, 
  released, 
  runtime, 
  genre, 
  director, 
  writer, 
  actors, 
   
  language, 
  country, 
  awards, 
  poster, 
  metascore, 
  imdbRating, 
  imdbVotes, 
  imdbID, 
  type, 
  response) VALUES (
  '#{@valueArray[0]}',
  '#{@valueArray[1]}',
  '#{@valueArray[2]}',
  '#{@valueArray[3]}',
  '#{@valueArray[4]}',
  '#{@valueArray[5]}',
  '#{@valueArray[6]}',
  '#{@valueArray[7]}',
  '#{@valueArray[8]}',
 
  '#{@valueArray[10]}',
  '#{@valueArray[11]}',
  '#{@valueArray[12]}',
  '#{@valueArray[13]}',
  '#{@valueArray[14]}',
  '#{@valueArray[15]}',
  '#{@valueArray[16]}',
  '#{@valueArray[17]}',
  '#{@valueArray[18]}',
  '#{@valueArray[19]}'
   );"

  run_sql(sql)

	erb :about
end


# create a movie record in local DB
post '/title/save' do
    
    @result = HTTParty.get("http://www.omdbapi.com/?i=#{params[:titleSearch]}")

    #make arrays for properties and values for SQL
    @keyArray = []
    @valueArray = []

    @result.each do |key, value| 
      @keyArray.push(key.to_s)
      @valueArray.push(value.to_s)
    end

  sql = "INSERT INTO movies(
  title, 
  year, 
  rated, 
  released, 
  runtime, 
  genre, 
  director, 
  writer, 
  actors, 
  plot, 
  language, 
  country, 
  awards, 
  poster, 
  metascore, 
  imdbRating, 
  imdbVotes, 
  imdbID, 
  type, 
  response) VALUES (
  '#{@valueArray[0]}',
  '#{@valueArray[1]}',
  '#{@valueArray[2]}',
  '#{@valueArray[3]}',
  '#{@valueArray[4]}',
  '#{@valueArray[5]}',
  '#{@valueArray[6]}',
  '#{@valueArray[7]}',
  '#{@valueArray[8]}',
  '#{@valueArray[9]}',
  '#{@valueArray[10]}',
  '#{@valueArray[11]}',
  '#{@valueArray[12]}',
  '#{@valueArray[13]}',
  '#{@valueArray[14]}',
  '#{@valueArray[15]}',
  '#{@valueArray[16]}',
  '#{@valueArray[17]}',
  '#{@valueArray[18]}',
  '#{@valueArray[19]}'
   );"

  raise sql 

  run_sql(sql)
  redirect to '/'
end

delete '/movie/:id' do
  sql = "DELETE FROM movies WHERE imdbID = #{params[:imdbID] };"
  run_sql(sql)

  # redirect to home
  redirect to '/'
end


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