#This is a step definition file.
##Step def files have the suffix _steps.rb, though the name doesnt matter at all except, all .rb files in features/step_definations folder are loaded when running the features.

#visit is a method from capybara that navigates to the given url
Given /^my bomb is not booted$/ do
  pending  #lets do this together
end

When /^I boot my bomb$/ do
  pending  #lets do this together
end

#fill_in uses API to type a value into the text_box. 
#The value is provided by what is captured by regex group. For example: if I say .....I set my activation code to "1234", it will fill in that value in the textbox
Given /^I set my activation code to (\d+)$/ do |code|
  pending #lets do this together
end

Given /^I set my deactivation code to (\d+)$/ do |code|
  #After we finishd  writing step def above, what do you think this should be?
  pending #Lets try
end