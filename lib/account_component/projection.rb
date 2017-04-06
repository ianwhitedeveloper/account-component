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
      # TODO Apply Withdrawn event to account
    end
  end
end
