require 'spec_helper'

describe MoviesController do
  describe 'displaying a movie listing' do

  end

  describe 'finding movies with the same director' do
    before :each do
      @fake_results = [mock('Movie'), mock('Movie')]
    end
    it 'should call the model method that finds the movies with the same director' do
      Movie.should_receive(:find_others_with_same_director).with(1).and_return(@fake_results)
      get :same_director, { :id => '1' }
    end
    it 'should select the Similar Director template for rendering' do
      Movie.stub(:find_others_with_same_director).with(1).and_return(@fake_results)
      get :same_director, {:id => '1'}
      response.should render_template('same_director')
    end
    it 'should make the Resulting Movies available to that template' do
      Movie.stub(:find_others_with_same_director).with(1).and_return(@fake_results)
      get :same_director, {:id => '1'}
      assigns(:movies).should == @fake_results
    end
  end

  describe 'creating a new movie' do
    before :each do
    #  @fake_movie = FactoryGirl.build(:movie, :id => 1, :title => 'Star Wars', :rating => 'PG', :director => 'George Lucas')
	  @fake_movie = Movie.new(:id => 1, :title => 'Star Wars', :rating => 'PG', :director => 'George Lucas')
    end
    it 'should call the model method that creates a new movie' do
      Movie.should_receive(:create!).with("something").and_return(@fake_movie)
      post :create, { :movie => "something" }
    end
    it 'should set the flash notice with the title of the movie' do
      Movie.stub(:create!).with("something").and_return(@fake_movie)
      post :create, { :movie => "something" }
      flash[:notice].should == "#{@fake_movie.title} was successfully created."
    end
    it 'should select redirect to the root' do
      Movie.stub(:create!).with("something").and_return(@fake_movie)
      post :create, { :movie => "something" }
      response.should redirect_to movies_path
    end
  end
 
  describe 'updating a movie' do
    before :each do
	  @fake_movie = Movie.new(:id => 1, :title => 'Star Wars', :rating => 'PG', :director => 'George Lucas')
    end
    it 'should call a method that finds a movie with a given id' do
	
      Movie.should_receive(:find).with(1).and_return(@fake_movie)
	  
      put :update, :id => '1', :movie => {:title => 'Star Wars'}
    end
    # it 'should update the given movie with the entered details' do
      # Movie.stub(:find).with(1).and_return(@fake_movie)
      # @fake_movie.should_receive :update_attributes!
	  # put :update, :id => '1', :movie => {:title => 'Star Wars'}
    # end
    it 'should flash a message that the movie has been updated' do
      Movie.stub(:find).with(1).and_return(@fake_movie)
      put :update, :id => '1', :movie => {:title => 'Star Wars'}
      flash[:notice].should == "#{@fake_movie.title} was successfully updated."
    end
    it 'should redirect to the movies details page' do
      Movie.stub(:find).with(1).and_return(@fake_movie)
      put :update, :id => '1', :movie => {:title => 'Star Wars'}
      response.should redirect_to movie_path(@fake_movie)
    end
  end

  describe 'destroying a movie' do
    before :each do
	  @fake_movie = Movie.new(:id => 1, :title => 'Star Wars', :rating => 'PG', :director => 'George Lucas')
    end
    it 'should call a method that finds a movie with a given id' do
      Movie.should_receive(:find).with(1).and_return(@fake_movie)
      delete :destroy, :id => '1', :movie => {:title => 'Star Wars'}
    end
    it 'should update the given movie with the entered details' do
      Movie.stub(:find).with(1).and_return(@fake_movie)
      @fake_movie.should_receive :destroy
      delete :destroy, :id => '1', :movie => {:title => 'Star Wars'}
    end
    it 'should flash a message that the movie has been deleted' do
      Movie.stub(:find).with(1).and_return(@fake_movie)
      delete :destroy, :id => '1', :movie => {:title => 'Star Wars'}
      flash[:notice].should == "Movie '#{@fake_movie.title}' deleted."
    end
    it 'should redirect to the movies details page' do
      Movie.stub(:find).with(1).and_return(@fake_movie)
      delete :destroy, :id => '1', :movie => {:title => 'Star Wars'}
      response.should redirect_to movies_path
    end
  end
end