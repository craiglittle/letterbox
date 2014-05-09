require 'forwardable'

module Letterbox
  class DispatchedWork

    extend Forwardable

    delegate [:delete] => :@hash

    def initialize
      @hash = Hash.new(0)
    end

    def sent_to(mailbox)
      @hash[mailbox.to_sym] += 1
    end

    def completed_by(mailbox)
      @hash[mailbox.to_sym] -= 1
    end

    def empty?(mailbox)
      @hash[mailbox.to_sym] == 0
    end

    def total_outstanding
      @hash.values.reduce(:+)
    end

  end
end
