module AccountComponent
  class Projection
    include EntityProjection
    include Messages::Events

    entity_name :account

    apply Opened do |opened|
      opened_time = Time.parse(opened.time)

      account.opened_time = opened_time
    end

    apply Deposited do |deposited|
      amount = deposited.amount

      account.deposit(amount)
    end

    apply Withdrawn do |withdrawn|
      amount = withdrawn.amount

      account.withdraw(amount)
    end

    apply Closed do |closed|
      # TODO Implement
    end
  end
end
