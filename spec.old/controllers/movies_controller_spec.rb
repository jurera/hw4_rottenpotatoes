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

 
end