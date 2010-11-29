
class Consumer
  def initialize
    @search_engine = se
    @record = nil
  end

  def start
  end

  def stop
  end

  def run
    manifest = transform(@record)
    se.register(manifest)
  end

  def transform(record)
    return nil
  end
end
