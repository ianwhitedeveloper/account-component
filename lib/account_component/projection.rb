module AccountComponent
  class Projection
    include EntityProjection
    include Messages::Events

    entity_name :account

    apply Opened do |opened|
      account.id = opened.account_id
      account.customer_id = opened.customer_id

      opened_time = Time.parse(opened.time)
      account.opened_time = opened_time
    end

    apply Deposited do |deposited|
      account.id = deposited.account_id
      account.sequence = deposited.sequence

      amount = deposited.amount

      account.deposit(amount)
    end

    apply Withdrawn do |withdrawn|
      account.id = withdrawn.account_id
      account.sequence = withdrawn.sequence

      amount = withdrawn.amount

      account.withdraw(amount)
    end

    apply WithdrawalRejected do |withdrawal_rejected|
      account.id = withdrawal_rejected.account_id
      account.sequence = withdrawal_rejected.sequence
    end

    apply Closed do |closed|
      account.id = closed.account_id

      closed_time = Time.parse(closed.time)
      account.closed_time = closed_time
    end
  end
end
