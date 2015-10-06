Then /^the bomb should be "(.*?)"$/ do |status|
  page.find(".activation_status").should have_content(status)
end
