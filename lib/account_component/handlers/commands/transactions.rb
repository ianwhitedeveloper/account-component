module AccountComponent
  module Handlers
    class Commands
      class Transactions
        include Messaging::Handle
        include Messaging::Postgres::StreamName
        include Messages::Commands
        include Messages::Events

        dependency :write, Messaging::Postgres::Write
        dependency :clock, Clock::UTC
        dependency :store, Store

        def configure
          Messaging::Postgres::Write.configure(self)
          Clock::UTC.configure(self)
          Store.configure(self)
        end

        category :account

        handle Deposit do |deposit|
          account_id = deposit.account_id

          account, version = store.fetch(account_id, include: :version)

          position = deposit.metadata.global_position

          if account.current?(position)
            logger.debug { "Command ignored (Command: #{deposit.message_type}, Account ID: #{account_id}, Account Position: #{account.position}, Deposit Position: #{position})" }
            return
          end

          time = clock.iso8601

          deposited = Deposited.follow(deposit)
          deposited.processed_time = time
          deposited.sequence = position

          stream_name = stream_name(account_id)

          write.(deposited, stream_name, expected_version: version)
        end

        handle Withdraw do |withdraw|
          account_id = withdraw.account_id

          account, version = store.fetch(account_id, include: :version)

          position = withdraw.metadata.global_position

          if account.current?(position)
            logger.debug { "Command ignored (Command: #{withdraw.message_type}, Account ID: #{account_id}, Account Position: #{withdraw.position}, Deposit Position: #{position})" }
            return
          end

          time = clock.iso8601

          stream_name = stream_name(account_id)

          unless account.sufficient_funds?(withdraw.amount)
            withdrawal_rejected = WithdrawalRejected.follow(withdraw)
            withdrawal_rejected.time = time
            withdrawal_rejected.sequence = position

            write.(withdrawal_rejected, stream_name)

            return
          end

          withdrawn = Withdrawn.follow(withdraw)
          withdrawn.processed_time = time
          withdrawn.sequence = position

          write.(withdrawn, stream_name, expected_version: version)
        end
      end
    end
  end
end
