#introduce tags
#run feature by line #

#cucumber --tags @activating-bomb           # Runs both scenarios
#cucumber --tags @deactivating-bomb         # Runs the first scenario
#cucumber --tags ~@deactivating-bomb        # Runs the second scenario (Scenarios without @important)
#cucumber features/activation.feature:17
Feature: Activation
  As a super-villain
  I want to activate a bomb
  So that I blow stuff up

  Background: A bomb has been booted
    Given a bomb booted with the default codes

  @javascript @activating-bomb
  Scenario: Entering activation code and receiving prompt
    When I enter the code 1234
      And I should see the time prompt
      And I enter the time 0400
    Then the bomb should be activated

  @javascript @reactivating-bomb
  Scenario: entering activation code while bomb is active
    Given the bomb is already activated
    When I enter the code 1234
    Then I should see the message "INVALID CODE"
