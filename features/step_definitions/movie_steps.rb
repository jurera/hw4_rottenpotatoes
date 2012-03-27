Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  assert page.body =~ /(.|\n)*#{e1}(.|\n)*#{e2}/
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  ratings = rating_list.split ", "
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  ratings.each do |rating|
    rating_id = "ratings_" + rating
    if !uncheck.nil?
      uncheck(rating_id)
    else
      check(rating_id)
    end
  end
end

Then /^I should see all of the movies$/ do
  assert page.has_css?("table#movies tbody tr", :count => 10)
end

Then /^I should see none of the movies$/ do
  assert !page.has_css?("table#movies tbody tr")
end

Then /the director of "(.*)" should be "(.*)"/ do |title, director|
  movie = Movie.find_by_title title
  assert !movie.nil? && movie.director == director
end