require 'rails_helper'

RSpec.feature "User Signs In", type: :feature do
  include Capybara::DSL

  before do
    Capybara.app = OauthWorkshop::Application
    stub_omniauth()
  end

  scenario "a user that visits the login page" do
    visit root_path
    expect(page).to have_content "Welcome to ChatterBox. Let out your inner Chatty Cathy."
    expect(page).to have_link "Sign in with Twitter"
  end

  scenario "a user logs in" do
    VCR.use_cassette('twitter user') do
      visit root_path
      click_link "Sign in with Twitter"
      expect(page).to have_content "@schatz_mc"
    end
  end

  def stub_omniauth
    # first, set OmniAuth to run in test mode
    OmniAuth.config.test_mode = true
    # then, provide a set of fake oauth data that
    # omniauth will use when a user tries to authenticate:
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
      provider: 'twitter',
      extra: {
        raw_info: {
          user_id: "1234",
          name: "Horace",
          nickname: "worace",
        }
      },
      credentials: {
        token: "pizza",
        secret: "secretpizza"
      }
    })
  end
end