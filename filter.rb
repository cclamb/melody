class TrueFilter
  def match(record, param)
    true
  end
end

class FalseFilter
  def match(record, param)
    false
  end
end
