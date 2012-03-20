require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

Given /the following movies exist/ do |movies_table|

  movies_table.hashes.each do |movie|
  
    @movie_ins = Movie.create!(movie)
	# each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
  end
  
  assert @movie_ins != nil, "Unimplmemented"
end

Then /the director of "(.*)" should be "(.*)"/ do |film,director|
	
	assert page.body.match(/#{director}/)!= nil&&Movie.find_by_title(film).director.to_s == director,"Assertion failed"
end