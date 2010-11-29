
class SearchEngine

  def initialize
    @records = []
    @filters = []
  end

  def register(record)
    @filters.push(record.filter)
    @records.push(record)
  end

  def find(param)
    results = []
    @filters.each do |f|
      @records.each { |r| results.push(r) if f.filter(r, param) == true }
    end
    return results
  end

end
