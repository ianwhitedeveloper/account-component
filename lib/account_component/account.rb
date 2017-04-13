module AccountComponent
  class Account
    include Schema::DataStructure

    attribute :id, String
    attribute :balance, Numeric, default: 0
    attribute :opened_time, Time
    attribute :closed_time, Time
    attribute :sequence, Integer

    def open?
      !opened_time.nil?
    end

    def closed?
      !closed_time.nil?
    end

    def deposit(amount)
      self.balance += amount
    end

    def withdraw(amount)
      self.balance -= amount
    end

    def current?(position)
      return false if sequence.nil?

      sequence >= position
    end

    def sufficient_funds?(amount)
      balance >= amount
    end
  end
end
