#Cucumber is a gem for ruby that executes plain-text functional descriptions as automated tests. 
#The language that Cucumber understands is called Gherkin. Cucumber itself is written in Ruby.

#This is a feature file covering scenarios for booting the bomb
#Feature files have the suffix .feature and live in a directory named features.

#Feature, Background, Scenario are defined in gherkin

#A feature can contain a description (which is unparsed text) 
#A background has a common step that is run if there are multiple scenarios
#A scenario is comprised of steps. Each step is a short sentence that falls into one of the three familiar BDD categories:

#Given (setting up a precondition for the scenario),
#When (execute an action in the application under test) and
#Then (assert the desired outcome)

Feature: Booting the bomb
  As a super-villain
  I do not want to activate the bomb when I first boot it with or without codes
  So that I activate it later

  Background:
    Given my bomb is not booted

  Scenario: Booting without codes
    When I boot my bomb
    Then the bomb should be "INACTIVE"

  Scenario: Booting with codes
    Given I set my activation code to 3490
    And I set my deactivation code to 1212
    When I boot my bomb
    Then the bomb should be "INACTIVE"
