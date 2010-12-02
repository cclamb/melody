require 'test/unit'

require 'search_engine'
require 'record'

class IntegrationTest < Test::Unit::TestCase

  def initialize_true_search_engine
    se = SearchEngine.new
    users = ['steve', 'frank', 'sue']
    users.each { |u| se.register(TrueRecord.new, u) }
    return { :engine => se, :users => users }
  end

  def initialize_false_search_engine
    se = SearchEngine.new
    users = ['steve', 'frank', 'sue']
    users.each { |u| se.register(FalseRecord.new, u) }
    return { :engine => se, :users => users }
  end

  def initialize_mix_search_engine
    se = SearchEngine.new
    users = ['steve', 'frank', 'sue']
    users.each { |u| se.register(TrueRecord.new, u) }
    se.register(FalseRecord.new, 'nyet')
    return { :engine => se, :users => users }
  end

  def initialize_true_traced_search_engine
    se = SearchEngine.new
    users = ['steve', 'frank', 'sue']
    links = {}
    users.each do |u| 
      record = TrueRecord.new
      se.register(record, u)
      links[record] = u
    end
    return { :engine => se, :users => users, :links => links }
  end

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

  def test_find_1
    ctx = initialize_true_search_engine
    results = ctx[:engine].find(nil)
    assert_equal(3, results.count)
    results.each { |r| assert(r.instance_of?(TrueRecord)) }
  end

  def test_find_2
    ctx = initialize_false_search_engine
    results = ctx[:engine].find(nil)
    assert_equal(0, results.count)
  end

  def test_find_3
    ctx = initialize_mix_search_engine
    results = ctx[:engine].find(nil)
    assert_equal(4, results.count)
    results.each do |r| 
      assert(r.instance_of?(TrueRecord) || r.instance_of?(FalseRecord))
    end
  end

  def test_lookup_producer
    ctx = initialize_true_traced_search_engine
    results = ctx[:engine].find(nil)
    results.each do |r|
      user = ctx[:links][r]
      retrieved_user = ctx[:engine].get_owner(r)
      assert_equal(user, retrieved_user)
    end
  end

end
