
class SearchEngine

  def initialize
    @records = []
    @filters = []
    @owners = {}
  end

  def register(record, consumer)
    @filters.push(record.filter)
    @records.push(record)
    @owners[record] = consumer
  end

  def find(param)
    results = []
    @filters.each do |f|
      @records.each { |r| results.push(r) if f.filter(r, param) == true }
    end
    return results
  end

  def get_owner(record)
    return @owners[record]
  end

end
