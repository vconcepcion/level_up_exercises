 require_relative '_helpers'
 
 Given /^a bomb booted with the default codes$/ do
   visit("/")
   click_on("Boot")
 end
 
 When /^I enter the (?:code|time) (\d+)$/ do |code|
   enter_code_on_keypad(code)
 end
 
 Then /^I should see the time prompt$/ do
   expect(find(".message")).to have_content("TIMER")
 end
 
 Then /^the bomb should be activated$/ do
   expect(find(".activation_status")).to have_content("ACTIVE")
 end
 
 #calling a step def in a step def
 Given /^the bomb is already activated$/ do
   step 'I enter the code 1234'
   step 'I enter the time 0400'
 end
 
 Then /^I should see the message "([^"]+)"$/ do |message|
   expect(find(".message")).to have_content(message)
 end
