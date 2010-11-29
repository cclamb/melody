class Consumer

  def initialize(se, param)
    @search_engine = se
    @param = param
  end

  def start
    run
  end

  def stop
  end

  def run
    results = @search_engine.find(@param)
    results.each do |r|
      owner = @search_engine.get_owner(r)
    end
  end

end
