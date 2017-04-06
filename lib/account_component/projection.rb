module AccountComponent
  class Projection
    include EntityProjection
    include Messages::Events

    entity_name :account

    apply Deposited do |deposited|
      amount = deposited.amount

      account.deposit amount
    end
  end
end
