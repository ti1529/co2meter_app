RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by(:selenium_chrome_headless)
  end

  config.before(:each, type: :system, selenium: true) do
    driven_by(:selenium_chrome)
  end
end
