# frozen_string_literal: true

require 'sepa_parser/version'
require 'sepa_parser/credit_transfer'
require 'rexml/document'

module SepaParser
  class MalformedSEPAError < RuntimeError
  end

  class SEPA
    include REXML

    def self.parse(data) # rubocop:disable MethodLength, AbcSize
      document = Document.new data
      credit_transfers = []

      document.elements.each('Document/CstmrCdtTrfInitn/PmtInf/CdtTrfTxInf') do |transfer|
        credit_transfers.push(SepaParser::CreditTransfer.new(
                                get_element_text(document, 'Document/CstmrCdtTrfInitn/GrpHdr/MsgId'),
                                get_element_text(document, 'Document/CstmrCdtTrfInitn/GrpHdr/CreDtTm'),
                                get_element_text(document, 'Document/CstmrCdtTrfInitn/GrpHdr/InitgPty/Nm'),
                                get_element_text(document, 'Document/CstmrCdtTrfInitn/PmtInf/PmtInfId'),
                                get_element_text(document, 'Document/CstmrCdtTrfInitn/PmtInf/PmtMtd'),
                                get_element_text(document, 'Document/CstmrCdtTrfInitn/PmtInf/ReqdExctnDt'),
                                get_element_text(document, 'Document/CstmrCdtTrfInitn/PmtInf/Dbtr/Nm'),
                                get_element_text(document, 'Document/CstmrCdtTrfInitn/PmtInf/DbtrAcct/Id/IBAN'),
                                get_element_text_if_exists(document, 'Document/CstmrCdtTrfInitn/PmtInf/DbtrAcct/Ccy'),
                                get_element_text_if_exists(document, 'Document/CstmrCdtTrfInitn/PmtInf/DbtrAgt/FinInstnId/BIC'),
                                get_element_text(transfer, 'PmtId/EndToEndId'),
                                get_element_text(transfer, 'Amt/InstdAmt'),
                                get_element_attribute(transfer, 'Amt/InstdAmt', 'Ccy'),
                                get_element_text_if_exists(transfer, 'CdtrAgt/FinInstnId/BIC'),
                                get_element_text(transfer, 'Cdtr/Nm'),
                                get_element_text(transfer, 'CdtrAcct/Id/IBAN'),
                                get_element_text_if_exists(transfer, 'CdtrAcct/Ccy'),
                                get_element_text(transfer, 'RmtInf/Ustrd')
                              ))
      end

      credit_transfers
    end

    def self.get_element_text_if_exists(element, path)
      XPath.first(element, path) ? element.elements[path].get_text.to_s : nil
    end

    def self.get_element_text(element, path)
      element.elements[path].get_text.to_s
    rescue StandardError
      raise MalformedSEPAError, "Invalid SEPA file: required field missing at path #{element.xpath}/#{path}"
    end

    def self.get_element_attribute(element, path, attribute)
      if element.elements[path].attributes[attribute].nil?
        raise MalformedSEPAError,
              "Invalid SEPA file: required attribute `#{attribute}` missing at path #{element.xpath}/#{path}"
      end

      element.elements[path].attributes[attribute]
    end
  end
end
