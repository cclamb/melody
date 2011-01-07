class NegotiationManager
  
  def initialize(concrete_negotiator = nil)
    @last_id = 0
    @callbacks = {}
    @concrete_negotiator = concrete_negotiator
  end
  
  def initiate_negotiation(ctx, &callback)
    other_party = ctx[:other_party]
    init_party = ctx[:init_party]
    record_id = ctx[:record_id]

    if other_party == nil || init_party == nil || record_id == nil
      raise ArgumentError, 'Must define parties and record'
    end

    raise ArgumentError, 'Callback block must be defined' unless callback

    id = generate_negotiation_id
    ctx[:id] = id

    @callbacks[id] = callback

    if @concrete_negotiator
      @concrete_negotiator.initiate_negotiation(ctx) do |result_ctx|
        return_ctx = {:result => result_ctx[:result],
          :record_id => result_ctx[:record_id],
          :other_party => result_ctx[:other_party]}
         @callbacks[result_ctx[:id]].call(return_ctx)
      end
    end

  end
  
  def generate_negotiation_id
    return @last_id = @last_id + 1
  end

  def notify_producer(ctx, id)
    @callbacks[id].call(ctx)
  end
  
end
