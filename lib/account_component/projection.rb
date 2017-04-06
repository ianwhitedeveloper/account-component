module AccountComponent
  class Projection
    include EntityProjection
    include Messages::Events

    entity_name :account

    apply Deposited do |deposited|
      amount = deposited.amount

      account.deposit(amount)
    end

    apply Withdrawn do |withdrawn|
      amount = withdrawn.amount

      account.withdraw(amount)
    end
  end
end
