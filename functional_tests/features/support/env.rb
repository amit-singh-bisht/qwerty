require 'selenium/webdriver'
require 'capybara/cucumber'
require 'browserstack-automate'

BrowserStack.for "cucumber"

CONFIG ||= YAML.load(File.read("#{File.dirname(__FILE__)}/constants.yml"))
url = "http://#{CONFIG['BS_USERNAME']}:#{CONFIG['BS_AUTHKEY']}@hub.browserstack.com/wd/hub"

Capybara.register_driver :browserstack do |app|

  capabilities = Selenium::WebDriver::Remote::Capabilities.new
	if ENV['BS_AUTOMATE_OS']
		capabilities['os'] = ENV['BS_AUTOMATE_OS']
		capabilities['os_version'] = ENV['BS_AUTOMATE_OS_VERSION']
	else
		capabilities['platform'] = ENV['SELENIUM_PLATFORM'] || 'ANY'
	end

	capabilities['browser'] = ENV['SELENIUM_BROWSER'] || 'chrome'
	capabilities['browser_version'] = ENV['SELENIUM_VERSION'] if ENV['SELENIUM_VERSION']
	capabilities['browserstack.debug'] = 'true'
	capabilities['project'] = ENV['BS_AUTOMATE_PROJECT'] if ENV['BS_AUTOMATE_PROJECT']
	capabilities['build'] = ENV['BS_AUTOMATE_BUILD']? ENV['BS_AUTOMATE_BUILD'] : 'browserstack-build-1'
  capabilities['browserstack.local'] = 'false'
  capabilities['browserstack.source'] = 'cucumber-ruby:sample-master:v1.0'

  Capybara::Selenium::Driver.new(app, :browser => :remote, :url => url, :desired_capabilities => capabilities)
end

Capybara.default_driver = :browserstack
Capybara.app_host = "http://www.google.com"
Capybara.run_server = false
