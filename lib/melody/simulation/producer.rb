
class Producer
  def initialize(search_engine, record)
    search_engine.register(record, self)
  end

  def start
  end

  def stop
  end
end
