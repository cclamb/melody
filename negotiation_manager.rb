class NegotiationManager
  
  def initialize
    @last_id = 0
  end
  
  def initiate_negotiation(ctx)
    other_party = ctx[:other_party]
    init_party = ctx[:init_party]
    record = ctx[:record]
    
  end
  
  def generate_negotiation_id
    return i = i + 1
  end
  
end