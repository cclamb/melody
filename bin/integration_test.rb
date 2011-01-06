require 'test/unit'

require 'search_engine'
require 'negotiation_manager'
require 'record'

class IntegrationTest < Test::Unit::TestCase
  def setup
    @users = ['steve', 'frank', 'sue']
    @se = SearchEngine.new
    @users.each { |u| @se.register(TrueRecord.new, u) }
    @nm = NegotiationManager.new(nil)
  end
  
  def test_acquistion_consumer
    results = @se.find(nil)

    result_queue = []
    results.each do |r|
      user = @se.get_owner_from_id(r)
      ctx = {:other_party => user, :init_party => 'me', :record_id => r}
      @nm.initiate_negotiation(ctx) { |ctx| result_queue.push(ctx) }
    end

    # Now we need to get the actual record bundle to place in a package bundle
  end

end
