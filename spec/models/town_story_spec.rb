require 'spec_helper'

describe TownStory do

  def reset_town_story(options = {})
    @valid_attributes = {
      :id => 1,
      :dummy => "RSpec is great for testing too"
    }

    @town_story.destroy! if @town_story
    @town_story = TownStory.create!(@valid_attributes.update(options))
  end

  before(:each) do
    reset_town_story
  end

  context "validations" do
    
    it "rejects empty dummy" do
      TownStory.new(@valid_attributes.merge(:dummy => "")).should_not be_valid
    end

    it "rejects non unique dummy" do
      # as one gets created before each spec by reset_town_story
      TownStory.new(@valid_attributes).should_not be_valid
    end
    
  end

end