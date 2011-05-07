$:.unshift File.expand_path('./')
require 'rubygems'
require 'rspec'
require 'fileutils'
RSpec.configure do |config|

  config.after :each do
    FileUtils.rm_rf('./tmp/.')
  end

end
