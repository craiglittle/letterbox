require 'celluloid'

module Letterbox
  class Directory

    def initialize
      @registry        = Celluloid::Registry.new
      @number_of_units = Hash.new(0)
    end

    def send_to(address)
      unless @registry.get(address)
        @registry.set(
          address,
          Address.new_link(Celluloid::Actor.current, unit_of_work)
        )
      end

      track_unit(address)

      @registry.get(address)
    end

    def completed_by(address)
      untrack_unit(address)

      if empty?(address)
        @registry.get(address).terminate
        @registry.delete(address)

        untrack_address(address)
      end
    end

    def number_outstanding
      @number_of_units.values.reduce(:+)
    end

    private

    def track_unit
      @number_of_units[address.to_sym] += 1
    end

    def untrack_unit(address)
      @number_of_units[address.to_sym] -= 1
    end

    def untrack_address(address)
      @number_of_units.delete(address.to_sym)
    end

    def empty?(address)
      @number_of_units[address.to_sym] == 0
    end

  end
end
