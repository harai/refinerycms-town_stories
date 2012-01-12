if defined?(User)
  User.all.each do |user|
    if user.plugins.where(:name => 'town_stories').blank?
      user.plugins.create(:name => 'town_stories',
                          :position => (user.plugins.maximum(:position) || -1) +1)
    end
  end
end

if defined?(Page)
  page = Page.create(
    :title => 'Town Stories',
    :link_url => '/town_stories',
    :deletable => false,
    :position => ((Page.maximum(:position, :conditions => {:parent_id => nil}) || -1)+1),
    :menu_match => '^/town_stories(\/|\/.+?|)$'
  )
  Page.default_parts.each do |default_page_part|
    page.parts.create(:title => default_page_part, :body => nil)
  end
end