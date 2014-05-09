require 'celluloid'

require 'letterbox/dispatched_work'
require 'letterbox/address'

module Letterbox
  class Exchange

    extend Forwardable

    include Celluloid

    attr_reader :unit_of_work, :directory, :dispatched_work

    delegate [:total_outstanding] => :dispatched_work

    def initialize(unit_of_work)
      @unit_of_work = unit_of_work

      @directory       = Celluloid::Registry.new
      @dispatched_work = DispatchedWork.new
    end

    def dispatch(payload, address)
      unless directory.get(address)
        directory.set(address, Address.new_link(Actor.current, unit_of_work))
      end

      dispatched_work.sent_to(address)

      directory.get(address).async.process(payload)
    end

    def return(address)
      dispatched_work.completed_by(address)

      if dispatched_work.empty?(address)
        directory.get(address).terminate
        directory.delete(address)

        dispatched_work.delete(address)
      end
    end

  end
end
