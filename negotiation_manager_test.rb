require 'test/unit'

require 'negotiation_manager'
require 'record'

class NegotiationManagerTest < Test::Unit::TestCase

  def setup
    @mgr = NegotiationManager.new
  end
  
  def test_generate_negotiation_id
    id = []
    10.times { id.push(@mgr.generate_negotiation_id) }
    assert_equal(10, id.count)
    cnt = 11
    10.times { assert_equal(id.pop, cnt = cnt - 1) }
  end

  def test_initiate_negitiation_1
    is_failed = false
    begin
      @mgr.initiate_negotiation(nil)
    rescue
      is_failed = true
    end
    assert(is_failed)
  end

  def test_initiate_negitiation_2
    is_failed = false
    h = {}
    begin
      @mgr.initiate_negotiation(h)
    rescue
      is_failed = true
    end
    assert(is_failed)
  end
 
  def test_initiate_negitiation_3
    is_failed = false
    h = {:other_party => 'foo', :init_party => 'bar'}
    begin
      @mgr.initiate_negotiation(h)
    rescue
      is_failed = true
    end
    assert(is_failed)
  end

  def test_initiate_negitiation_4
    is_failed = false
    h = {:other_party => 'foo', :record => 'bar'}
    begin
      @mgr.initiate_negotiation(h)
    rescue
      is_failed = true
    end
    assert(is_failed)
  end

  def test_initiate_negitiation_5
    is_failed = false
    h = {:init_party => 'foo', :record => 'bar'}
    begin
      @mgr.initiate_negotiation(h)
    rescue
      is_failed = true
    end
    assert(is_failed)
  end

  def test_initiate_negitiation_6
    is_failed = false
    h = {:init_party => 'foo', :other_party => 'bar', :record => TrueRecord.new}
    begin
      @mgr.initiate_negotiation(h)
    rescue
      is_failed = true
    end
    assert(is_failed)
  end

  def test_initiate_negitiation_7
    is_failed = false
    h = {:init_party => 'foo', :other_party => 'bar', :record => TrueRecord.new}
    @mgr.initiate_negotiation(h) { puts 'x' }
    callbacks = @mgr.instance_variable_get('@callbacks')
    assert_equal(1, callbacks.count)
    @mgr.initiate_negotiation(h) { puts 'y' }
    assert_equal(2, callbacks.count)
    callbacks.each { |k,v| assert(v.is_a?(Proc)) } 
  end

end
