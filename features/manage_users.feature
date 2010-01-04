Feature: Manage users
  In order to signup
  
  Scenario: Register new user
    Given I am on the new user page
    When I fill in "Login" with "Rain"
    And I fill in "Password" with "mypass"
    And I fill in "Password confirmation" with "mypass"
    And I press "Register"
    Then I should see "Account registered!"

  Scenario: Upload an image as avatar
    Given I am registered as "Rain/mypass"
    When I go to "/account/edit"
      And I attach the file "rails.png" to "avatar"
      And I press "Update"
    Then I should see "Account updated!"
      And the "avatar.file?" of the user which login is "Rain" should be "true"
      And the "avatar_file_size" of the user which login is "Rain" should not be blank