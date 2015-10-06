Given /^(\d+) failed attempts have been made to disarm the bomb$/ do |attempts|
  attempts = attempts.to_i
  attempts.times do
    enter_code_on_keypad(5678)
  end
end

Then /^the bomb should explode$/ do
  expect(page).to have_selector(".explosion")
end
