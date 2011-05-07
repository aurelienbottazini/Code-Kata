$:.unshift File.expand_path('./')
require 'rubygems'
require 'rspec'
require 'fileutils'
RSpec.configure do |config|

  TMP_DIR ||= File.expand_path('~/projects/Code-Kata/Google Code Jam/tmp/')
  DATA_DIR ||= File.expand_path('~/projects/Code-Kata/Google Code Jam/spec/data/')

  config.after :each do
    FileUtils.rm_rf("#{TMP_DIR}/.")
  end

end
