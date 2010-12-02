require 'test/unit'

require 'search_engine'
require 'record'

class IntegrationTest < Test::Unit::TestCase

  def test_register_1
    users = ['steve', 'frank', 'sue']
    se = SearchEngine.new
    users.each { |u| se.register(TrueRecord.new, u) }
    filters = se.instance_variable_get("@filters")
    assert_equal(1, filters.count)
  end
  
  def test_register_2
    users = ['steve', 'frank', 'sue']
    se = SearchEngine.new
    users.each { |u| se.register(TrueRecord.new, u) }
    se.register(FalseRecord.new, 'lambone')
    filters = se.instance_variable_get("@filters")
    assert_equal(2, filters.count)  
  end
  
  def test_acquisition
    #results = @se.find(nil)
    #puts results
  end

end
