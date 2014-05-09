require 'celluloid'

module Letterbox
  class Address

    include Celluloid

    attr_reader :exchange, :unit_of_work

    def initialize(exchange, unit_of_work)
      @exchange     = exchange
      @unit_of_work = unit_of_work
    end

    def process(payload)
      unit_of_work.new(payload).perform

      exchange.async.completed_by(name)
    end

  end
end
