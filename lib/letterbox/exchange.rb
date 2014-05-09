require 'celluloid'

require 'letterbox/directory'
require 'letterbox/address'

module Letterbox
  class Exchange

    extend Forwardable

    include Celluloid

    attr_reader :unit_of_work, :directory, :dispatched_work

    def initialize(unit_of_work)
      @unit_of_work = unit_of_work
      @directory    = Directory.new
    end

    def dispatch(payload, address)
      directory.send_to(address).async.process(payload)
    end

    delegate [:completed_by, :number_outstanding] => :directory

  end
end
