require 'melody/simulation/filter'

class TrueRecord
  def filter
    return TrueFilter.new
  end
  def get_id
    return hash
  end
end

class FalseRecord
  def filter
    return FalseFilter.new
  end
  def get_id
    return hash
  end
end
