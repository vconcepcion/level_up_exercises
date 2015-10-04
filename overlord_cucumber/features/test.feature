Feature: Test
  As a meetup attendee
  I want to verify that I can run Cucumber tests
  So that I don't waste time installing stuff at the meetup

  Scenario: Running a test
    Given I have followed the setup instructions
    When I run this test
    Then it should pass
