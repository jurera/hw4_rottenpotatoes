class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  def self.find_others_with_same_director (id)
    movie = Movie.find(id)
    #if !movie.nil?
      Movie.where('director = :director and id != :id', :director => movie.director, :id => movie.id)
    #else
    #  []
    #end
  end
end
