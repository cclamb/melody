require 'test/unit'

require 'search_engine'
require 'record'

class IntegrationTest < Test::Unit::TestCase
  def setup
    @users = ['steve', 'frank', 'sue']
    @se = SearchEngine.new
    @users.each { |u| @se.register(TrueRecord.new, u) }
  end
  
  def test_acquisition
    results = @se.find(nil)
    puts results
  end
end