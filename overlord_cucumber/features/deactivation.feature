#@javascript: Uses a javascript-aware system to process web requests (e.g., Selenium) instead of the default (non-javascript-aware) webrat browser.

Feature: Deactivation
  As a super-villain, hero, officer, bystander, or interested party
  I want to deactivate the bomb
  So that I survive & dont die

  Background:
    Given a bomb booted with the default codes
      And the bomb is already activated

  @javascript @deactivating-with-valid-code
  Scenario: Deactivating a bomb with a valid code
    When I enter the code 0000
    Then the bomb should be "INACTIVE"

  @javascript @deactivating-with-invalid-code
  Scenario: Deactivating the bomb with an invalid code
    When I enter the code 5678
    Then I should see the message "INVALID CODE"

  @javascript @bomb-explosion
  Scenario: Deactivating the bomb with an invalid code and 1 remaining attempt
    Given 2 failed attempts have been made to disarm the bomb
    When I enter the code 5678
    Then the bomb should explode
