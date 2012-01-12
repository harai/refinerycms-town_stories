Given /^I have no town_stories$/ do
  TownStory.delete_all
end

Given /^I (only )?have town_stories titled "?([^\"]*)"?$/ do |only, titles|
  TownStory.delete_all if only
  titles.split(', ').each do |title|
    TownStory.create(:dummy => title)
  end
end

Then /^I should have ([0-9]+) town_stor[y|ies]+?$/ do |count|
  TownStory.count.should == count.to_i
end
