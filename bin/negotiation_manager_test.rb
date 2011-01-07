
$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../lib')

require 'test/unit'
require 'melody/simulation/negotiation_manager'
require 'melody/simulation/record'

class NegotiationManagerTest < Test::Unit::TestCase

  def setup
    @mgr = NegotiationManager.new(nil)
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
    h = {:other_party => 'foo', :record_id => 'bar'}
    begin
      @mgr.initiate_negotiation(h)
    rescue
      is_failed = true
    end
    assert(is_failed)
  end

  def test_initiate_negitiation_5
    is_failed = false
    h = {:init_party => 'foo', :record_id => 'bar'}
    begin
      @mgr.initiate_negotiation(h)
    rescue
      is_failed = true
    end
    assert(is_failed)
  end

  def test_initiate_negitiation_6
    is_failed = false
    h = {:init_party => 'foo', :other_party => 'bar', :record_id => 0}
    begin
      @mgr.initiate_negotiation(h)
    rescue
      is_failed = true
    end
    assert(is_failed)
  end

  def test_initiate_negitiation_7
    is_failed = false
    h = {:init_party => 'foo', :other_party => 'bar', :record_id => 1}
    @mgr.initiate_negotiation(h) { |h| puts 'x' }
    callbacks = @mgr.instance_variable_get('@callbacks')
    assert_equal(1, callbacks.count)
    @mgr.initiate_negotiation(h) { |h| puts 'y' }
    assert_equal(2, callbacks.count)
    callbacks.each { |k,v| assert(v.is_a?(Proc)) } 
  end

  def test_notify_producer
    is_called = false
    h = {:init_party => 'foo', :other_party => 'bar', :record_id => 2}
    @mgr.initiate_negotiation(h) { |h| is_called = true if h }
    id = @mgr.instance_variable_get('@last_id')
    @mgr.notify_producer({}, id)
    assert(is_called)
  end

end
