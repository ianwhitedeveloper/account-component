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

      account.transaction_position = deposited.transaction_position
    end

    apply Withdrawn do |withdrawn|
      amount = withdrawn.amount

      account.withdraw(amount)

      # TODO Update transaction position of account entity
    end

    # TODO Apply withdrawal rejected event to update account's transaction position

    apply Closed do |closed|
      closed_time = Time.parse(closed.time)

      account.closed_time = closed_time
    end
  end
end
