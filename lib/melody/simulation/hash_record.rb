class HashRecord < Hash

  @@filter = nil

  class HashRecordFilter
    
    def match(record, param)
      match? = false
      record.each_value { |v| match? = true if param == value }
      return match?
    end

  end

  def filter
    @@filter = HashRecordFilter.new if @@filter == nil
    return @@filter
  end

end
