
class SearchEngine

  def initialize
    @records = {}
    @filters = []
    @owners = {}
  end

  def register(record, consumer)
    exists = false
    @filters.each { |f| exists = true if f.instance_of?(record.filter.class) }

    @filters.push(record.filter) unless exists

    @records[record.get_id] = record
    @owners[record] = consumer
  end

  def find(param = nil)
    results = []
    @filters.each do |f|
      @records.each { |k,v| results.push(k) if f.match(v, param) == true }
    end
    return results
  end

  def get_owner(record)
    return @owners[record]
  end

  def get_owner_from_id(id)
    return @owners[@records[id]]
  end

end
