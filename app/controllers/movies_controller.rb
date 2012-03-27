class MoviesController < ApplicationController
	
	# def same_director
	    # id = params[:id] # retrieve movie ID from URI route
		
			# @movie = Movie.find(id) # look up movie by unique ID	
			# @movies = Movie.find_all_by_director(@movie.director)
			# m = Movie.find_by_title("Aladdin")
			# m.make_adult
			# m.save!
		
	# end
	
 def same_director
    @movies = Movie.find_others_with_same_director params[:id].to_i
    if @movies.nil? || @movies.length == 0
      movie = Movie.find(params[:id])
      flash[:notice] = "'#{movie.title}' has no director info"
      redirect_to movies_path
    end
  end


  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
	# 
	if Movie.find_all_by_director(@movie.director).count >= 1 && @movie.director.to_s != ''
		@link = movie_path(@movie)+'/same_director'
	else
		@link = movies_path(:movie => @movie)
	end
  end

  def index
	@nomovie = params[:movie]
	if @nomovie !=nil
		@nomovietitle = "\'"+Movie.find(@nomovie).title+"\' has no director info"
	end
    sort = params[:sort] || session[:sort]
    case sort
    when 'title'
      ordering,@title_header = {:order => :title}, 'hilite'
    when 'release_date'
      ordering,@date_header = {:order => :release_date}, 'hilite'
    end
    @all_ratings = Movie.all_ratings
    @selected_ratings = params[:ratings] || session[:ratings] || {}

    if params[:sort] != session[:sort]
      session[:sort] = sort
      redirect_to :sort => sort, :ratings => @selected_ratings, :movie => @nomovie and return
    end

    if params[:ratings] != session[:ratings] and @selected_ratings != {}
      session[:sort] = sort
      session[:ratings] = @selected_ratings
      redirect_to :sort => sort, :ratings => @selected_ratings, :movie => @nomovie and return
    end
    @movies = Movie.find_all_by_rating(@selected_ratings.keys, ordering)
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
	@id = params[:id]
    @movie = Movie.find @id.to_i
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
  	@id = params[:id]

    @movie = Movie.find(@id.to_i)
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
