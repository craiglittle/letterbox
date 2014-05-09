require 'celluloid'

module Letterbox
  class Address

    include Celluloid

    attr_reader :directory, :unit_of_work

    def initialize(directory, unit_of_work)
      @directory    = directory
      @unit_of_work = unit_of_work
    end

    def process(payload)
      unit_of_work.new(payload).perform

      directory.async.return(name)
    end

  end
end
