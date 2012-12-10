# javascript - Using Selenium to imitate dragging a file onto an upload element - Stack Overflow
# http://stackoverflow.com/questions/5188240/using-selenium-to-imitate-dragging-a-file-onto-an-upload-element
def drop_files(files, drop_area_id)
  js_script = "fileList = [];"
  files.count.times do |i|
  # Generate a fake input selector
    page.execute_script("if ($('#seleniumUpload#{i}').length == 0) { seleniumUpload#{i} = window.$('<input/>').attr({id: 'seleniumUpload#{i}', type:'file'}).appendTo('body'); }")
    # Attach file to the fake input selector through Capybara
    attach_file("seleniumUpload#{i}", files[i])
    # Build up the fake js event
    js_script = "#{js_script} fileList.push(seleniumUpload#{i}.get(0).files[0]);"
  end

  # Trigger the fake drop event
  page.execute_script("#{js_script} e = $.Event('drop'); e.originalEvent = {dataTransfer : { files : fileList } }; $('##{drop_area_id}').trigger(e);")
end

def screenshot
  page.driver.render "tmp/screenshot.png"
end