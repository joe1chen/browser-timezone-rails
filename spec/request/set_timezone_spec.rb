require 'spec_helper'


describe 'sets the timezone' do

  before do
    #Rails server timezone is UTC...
    Time.zone =  'UTC'
  end

  context 'Australia' do
    before do

      #pretend we're in australia, always wanted to go there
      page.driver.browser.set_cookie "browser.timezone=Australia/Sydney"

      #visit a page that displays the rails time zone for this request
      visit '/timezone'
    end

    it 'sets the timezone properly' do
      page.should have_content "Australia/Sydney"
    end

    it 'resets the time zone back to utc after each request' do
      Time.zone.name.should == 'UTC'
    end
  end

  context 'on the first request ever, there will be no cookie, and nothing happens' do

    before do
      #visit a page that displays the rails time zone for this request
      visit '/timezone'
    end

    it 'sets the timezone properly' do
      page.should have_content "(GMT+00:00) UTC"
    end

  end

end
