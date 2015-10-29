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
    VCR.use_cassette('user_sign_in') do
      visit root_path
      click_link "Sign in with Twitter"
      expect(page).to have_content "@schatz_mc"
      expect(current_path).to eq profile_path
    end
  end

  scenario "a user logs out" do
    VCR.use_cassette('user_logs_out') do
      visit root_path
      click_link "Sign in with Twitter"
      expect(page).to have_content "@schatz_mc"
      expect(current_path).to eq profile_path

      click_link "Logout"
      expect(current_path).to eq root_path
    end
  end

  scenario "a user tweets" do
    VCR.use_cassette('user_tweets') do
      visit root_path
      click_link "Sign in with Twitter"
      expect(page).to have_content "@schatz_mc"
      expect(current_path).to eq profile_path

      within "#tweet" do
        fill_in "tweet", with: "test tweet"
        click_button "Tweet!"
      end
    end
  end

  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
                      uid: "2359775539",
                      info: {
                        name: "Mimi Schatz",
                        screen_name: "schatz_mc"
                          },
                      credentials: {
                        token: "2359775539-t86oIVjlNDR4xi9fmS2j8LLW7oos7YeMAVmwCGV",
                        secret: "jJ4qgeuThEcoAqkurOSzES0JHaBTXgOI0QaXmc2VIbGe3"
                        }
                      })
  end
end