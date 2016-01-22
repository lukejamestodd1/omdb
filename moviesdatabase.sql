CREATE DATABASE moviesdatabase;

CREATE TABLE movies(
	title text NOT NULL,
	year text,
	rated text,
	released text,
	runtime text,
	genre text,
	director text,
	writer text,
	actors text,
	plot text,
	language text,
	country text,
	awards text,
	poster text,
	metascore text,
	imdbRating text,
	imdbVotes text,
	imdbID text,
	type text,
	response  text);

sql = "INSERT INTO movies (
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
	response
	)
VALUES (
	'#{params[:title]}',
	'#{params[:year] }', 
	'#{params[:rated]}', 
	'#{params[:released]}', 
	'#{params[:runtime] }', 
	'#{params[:genre]}', 
	'#{params[:director]}', 
	'#{params[:writer]}', 
	'#{params[:actors]}', 
	'#{params[:plot]}', 
	'#{params[:language]}', 
	'#{params[:country]}', 
	'#{params[:awards]}', 
	'#{params[:poster]}', 
	'#{params[:metascore]}', 
	'#{params[:imdbRating]}', 
	'#{params[:imdbVotes]}', 
	'#{params[:imdbID]}', 
	'#{params[:type]}', 
	'#{params[:response]}'
	);"

attr_accessor 
		:title, 
		:year, 
		:rated, 
		:released, 
		:runtime, 
		:genre, 
		:director, 
		:writer, 
		:actors, 
		:plot, 
		:language, 
		:country, 
		:awards, 
		:poster, 
		:metascore, 
		:imdbRating, 
		:imdbVotes, 
		:imdbID, 
		:type, 
		:response

	def initialize(
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
		response
		)
		@title = title
		@year = year
		@rated = rated
		@released = released 
		@runtime = runtime
		@genre = genre
		@director = director 
		@writer = writer
		@actors = actors
		@plot = plot
		@language = language
		@country = country 
		@awards = awards
		@poster = poster
		@metascore = metascore
		@imdbRating = imdbRating
		@imdbVotes = imdbVotes
		@imdbID = imdbID
		@type = type
		@response = response
	end

	def run_sql(sql)
	  db = PG.connect(dbname: 'moviesdatabase')
	  results = db.exec(sql)
	  db.close
	  return results  
	end

	def generate_sql()
	end
	
{"Title"=>"Hello", "Year"=>"2008", "Rated"=>"N/A", "Released"=>"10 Oct 2008", "Runtime"=>"129 min", "Genre"=>"Drama, Romance", "Director"=>"Atul Agnihotri", "Writer"=>"Atul Agnihotri (screenplay), Chetan Bhagat (additional dialogue), Chetan Bhagat (book), Jalees Sherwani (lyrics), Alok Upadhyay (additional dialogue)", "Actors"=>"Bharati Achrekar, Amrita Arora, Sharman Joshi, Katrina Kaif", "Plot"=>"Hello... is a tale about the events that happen one night at a call center. Told through the views of the protagonist, Shyam, it is a story of almost lost love, thwarted ambitions, absence ...", "Language"=>"Hindi", "Country"=>"India", "Awards"=>"N/A", "Poster"=>"http://ia.media-imdb.com/images/M/MV5BZGM5NjliODgtODVlOS00OWZmLWIzYzMtMTI2OWIzMTM1ZGRhXkEyXkFqcGdeQXVyNDUzOTQ5MjY@._V1_SX300.jpg", "Metascore"=>"N/A", "imdbRating"=>"3.4", "imdbVotes"=>"1,401", "imdbID"=>"tt1087856", "Type"=>"movie", "Response"=>"True"}


<a href="/about/=?<%= movie["imdbID"] %>">
		<li name="titleSearch"> <%= movie["Title"] %> </li>
	</a>

<form action="/movie/<%= movie["imdbID"] %>" method="post">
  <input type="hidden" name="_method" value="delete">
  <button>delete</button>
  </form>

  illegal character function in ruby - URI
  google "did you mean" thing

  USE $$ to emit bad characters in psql string
