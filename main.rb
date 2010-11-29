require 'producer'
require 'consumer'
require 'search_engine'


def main

  se = SearchEngine.new
  p = Producer.new(se)
  c = Consumer.new(se)

  

end
