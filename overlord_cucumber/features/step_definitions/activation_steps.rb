 require_relative '_helpers'
 
 Given /^a bomb booted with the default codes$/ do
   visit("/")
   click_on("Boot")
 end
 
 When /^I enter the (?:code|time) (\d+)$/ do |code|
   pending  #lets do this together
 end
 
 Then /^I should see the time prompt$/ do
   pending  #lets do this together
 end
 
 Then /^the bomb should be activated$/ do
   pending  #lets do this together
 end
 
 #calling a step def in a step def
 Given /^the bomb is already activated$/ do
   pending  #lets do this together
 end
 
 Then /^I should see the message "([^"]+)"$/ do |message|
   pending  #lets do this together
 end
