Feature: Wire-cutting
  As a person
  I want to cut wires
  In order to disarm the bomb

  Background: A bomb has been booted
    Given a bomb booted with the default codes

  @javascript
  Scenario: Cutting disarm wires
    When I cut all disarm wires
    Then the bomb should be disabled

  @javascript
  Scenario: Cutting an exploding wire
    Given the bomb is already activated
    When I cut an exploding wire
    Then the bomb should explode

  @javascript
  Scenario: Activating a bomb ready to explode
    When I cut an exploding wire
    And I enter the code 1234
    And I enter the time 0400
    Then the bomb should explode
