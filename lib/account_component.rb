require 'eventide/postgres'

require 'account_component/messages/commands/deposit'
require 'account_component/messages/commands/withdraw'
require 'account_component/messages/events/deposited'
require 'account_component/messages/events/withdrawn'
require 'account_component/messages/events/withdrawal_rejected'

require 'account_component/account'
require 'account_component/projection'
require 'account_component/store'

require 'account_component/handlers/commands'
