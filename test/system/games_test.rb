require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "visiting the home page" do
    visit '/new'

    assert_selector "h1", text: "Game"
  end
end
