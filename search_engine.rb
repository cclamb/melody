
class SearchEngine

  def initialize
    @records = []
    @filters = []
    @owners = {}
  end

  def register(record, consumer)
    exists = false
    @filters.each { |f| exists = true if f.instance_of?(record.filter.class) }

    @filters.push(record.filter) unless exists

    @records.push(record)
    @owners[record] = consumer
  end

  def find(param)
    results = []
    @filters.each do |f|
      @records.each { |r| results.push(r) if f.match(r, param) == true }
    end
    return results
  end

  def get_owner(record)
    return @owners[record]
  end

end
