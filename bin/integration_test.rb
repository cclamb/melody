
$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../lib')

require 'test/unit'
require 'melody/simulation/search_engine'
require 'melody/simulation/negotiation_manager'
require 'melody/simulation/record'

class IntegrationTest < Test::Unit::TestCase
  def setup
    @users = ['steve', 'frank', 'sue']
    @se = SearchEngine.new
    @users.each { |u| @se.register(TrueRecord.new, u) }
    @nm = NegotiationManager.new(SimpleNegotiationManager.new)
  end
  
  def test_acquistion_consumer
    results = @se.find

    result_queue = []
    results.each do |r|
      user = @se.get_owner_from_id(r)
      ctx = {:other_party => user, :init_party => 'me', :record_id => r}
      @nm.initiate_negotiation(ctx) { |ctx| result_queue.push(ctx) }
    end

puts '==> Result Queue: ', result_queue
    # Now we need to get the actual record bundle to place in a package bundle
  end

end

class SimpleNegotiationManager
  def initiate_negotiation(ctx)
    puts '==> ctx', ctx
  end
end
