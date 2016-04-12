require 'selenium-webdriver'
require 'test/unit'

class BlogTests < Test::Unit::TestCase
    def setup
        # create selenium objects
        @driver = Selenium::WebDriver.for :firefox
        @wait = Selenium::WebDriver::Wait.new :timeout => 10
    end

    def test_team_server_reachable
        # navigate to the main page
        @driver.get 'http://192.168.99.100'
    end

    def test_summary_server_reachable
        # navigate to the main page
        @driver.get 'http://192.168.99.100:8080' 
    end

    def teardown
        @driver.quit
    end

end
