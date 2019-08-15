# frozen_string_literal: true

require 'test_helper'
class SepaParserTest < Minitest::Test
  def setup
    @file = File.new('test/fixtures/pain.001.001.03.xml')
    @result = SepaParser::SEPA.parse(@file)
    @credit_transfer = @result.first
  end

  def test_that_it_has_a_version_number
    refute_nil ::SepaParser::VERSION
  end

  def test_that_it_parses_a_file
    assert_equal 2, @result.size
  end

  def test_that_message_identification_matches
    assert_equal 'Message-ID-4711', @credit_transfer.message_identification
  end

  def test_that_creation_date_time_matches
    assert_equal '2010-11-11T09:30:47.000Z', @credit_transfer.creation_date_time
  end

  def test_that_initiating_party_name_matches
    assert_equal 'Initiator Name', @credit_transfer.initiating_party_name
  end

  def test_that_payment_information_identification_matches
    assert_equal 'Payment-Information-ID-4711', @credit_transfer.payment_information_identification
  end

  def test_that_payment_method_matches
    assert_equal 'TRF', @credit_transfer.payment_method
  end

  def test_that_requested_execution_date_matches
    assert_equal '2010-11-25', @credit_transfer.requested_execution_date
  end

  def test_that_debtor_name_matches
    assert_equal 'Debtor Name', @credit_transfer.debtor_name
  end

  def test_that_debtor_account_iban_matches
    assert_equal 'DE87200500001234567890', @credit_transfer.debtor_account_iban
  end

  def test_that_debtor_account_currency_matches
    assert_nil @credit_transfer.debtor_account_currency
  end

  def test_that_debtor_agent_bic_matches
    assert_equal 'BANKDEFFXXX', @credit_transfer.debtor_agent_bic
  end

  def test_that_payment_end_to_end_identification_matches
    assert_equal 'OriginatorID1234', @credit_transfer.payment_end_to_end_identification
  end

  def test_that_amount_matches
    assert_equal '6543.14', @credit_transfer.amount
  end

  def test_that_amount_currency_matches
    assert_equal 'EUR', @credit_transfer.amount_currency
  end

  def test_that_creditor_agent_bic_matches
    assert_equal 'SPUEDE2UXXX', @credit_transfer.creditor_agent_bic
  end

  def test_that_creditor_name_matches
    assert_equal 'Creditor Name', @credit_transfer.creditor_name
  end

  def test_that_creditor_account_iban_matches
    assert_equal 'DE21500500009876543210', @credit_transfer.creditor_account_iban
  end

  def test_that_creditor_account_currency_matches
    assert_nil @credit_transfer.creditor_account_currency
  end

  def test_that_remittance_information_matches
    assert_equal 'Unstructured Remittance Information', @credit_transfer.remittance_information
  end
end
