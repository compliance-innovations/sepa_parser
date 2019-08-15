module SepaParser
  CreditTransfer = Struct.new(
    :message_identification,
    :creation_date_time,
    :initiating_party_name,
    :payment_information_identification,
    :payment_method,
    :requested_execution_date,
    :debtor_name,
    :debtor_account_iban,
    :debtor_account_currency,
    :debtor_agent_bic,
    :payment_end_to_end_identification,
    :amount,
    :amount_currency,
    :creditor_agent_bic,
    :creditor_name,
    :creditor_account_iban,
    :creditor_account_currency,
    :remittance_information
  )
end
