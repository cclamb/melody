class NegotiationManager
  
  def initialize(concrete_negotiator)
    @last_id = 0
    @callbacks = {}
    @concrete_negotiator = concrete_negotiator if concrete_negotiator
  end
  
  def initiate_negotiation(ctx, &callback)
    other_party = ctx[:other_party]
    init_party = ctx[:init_party]
    record = ctx[:record]

    if other_party == nil || init_party == nil || record == nil
      raise ArgumentError, 'Must define parties and record'
    end

    raise ArgumentError, 'Callback block must be defined' unless callback

    id = generate_negotiation_id

    @callbacks[id] = callback
  end
  
  def generate_negotiation_id
    return @last_id = @last_id + 1
  end

  def notify_producer(ctx, id)
    @callbacks[id].call(ctx)
  end
  
end
