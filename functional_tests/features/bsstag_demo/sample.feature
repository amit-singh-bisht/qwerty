@bstackdemo
Feature: Test Cases for bstackdemo website

  @todo
  Scenario: Can add the product in cart1
    Given I visit bstackdemo website
#    When I add a product to the cart
#    Then I should see same product in cart section

  Scenario: Can add the product in cart2
    Given I visit bstackdemo website
    When I add a product to the cart
    Then I should see same product in cart section
