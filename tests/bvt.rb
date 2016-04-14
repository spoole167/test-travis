require 'selenium-webdriver'
require 'test/unit'

sleep 10 # crude but effective pause to allow docker containers to start
TeamServer="http://192.168.99.100:80"
SummaryServer="http://192.168.99.100:8080"

class BVTTests < Test::Unit::TestCase

    def setup

        # create selenium objects
        @driver = Selenium::WebDriver.for :firefox
        @wait = Selenium::WebDriver::Wait.new :timeout => 5

    end

    def test1_team_server_reachable
        @driver.get "#{SummaryServer}/api/v1/version"
        @wait.until { @driver.find_element(:tag_name,"body").text=="1.0" }
    end

    def test2_summary_server_reachable

        @driver.get "#{TeamServer}/api/v1/version"
        f=@driver.find_element(:tag_name,"body")
        @wait.until { @driver.find_element(:tag_name,"body").text=="1.0" }

    end

    def test3_team_server_default_page_is_summary
        @driver.get "#{SummaryServer}"
        puts "Team Summary==#{@driver.title.downcase}"
        @wait.until { @driver.title.downcase=="team summary" }
    end

    def test4_summary_server_default_page_is_team

        @driver.get "#{TeamServer}"
        puts "Team Products=#{@driver.title.downcase}"
        @wait.until { @driver.title.downcase=="team products" }

    end

    def test5_summary_editor_is_present

        @driver.get "#{TeamServer}/api/v1/edit/summary"
        puts "Summary Editor=#{@driver.title.downcase}"
        @wait.until { @driver.title.downcase=="summary editor" }

    end


    def teardown
        @driver.quit
    end

end
