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

#I have the background written for you. And there are scenarios description as well. Lets think of how to write them
  Background: A bomb has been booted
    Given a bomb booted with the default codes

  @javascript @activating-bomb
  Scenario: Successful activating the bomb

  @javascript @reactivating-bomb
  Scenario: Entering activation code while bomb is active
