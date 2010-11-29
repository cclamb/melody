require 'filter'

class TrueRecord
  def filter
    return TrueFilter.new
  end
end

class FalseRecord
  def filter
    return FalseFilter.new
  end
end
