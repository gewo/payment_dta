require 'date'
class Payment

  def initialize(data = {})
    @data = data
  end
  
  def segment1
    @segment ||= build_segment1 
  end
  
  def header
    @header ||= build_header
  end
  
  def record
    @record ||= segment1
  end

  protected
  
  def build_segment1
    '01'+ header
  end
  
  def build_header
    execution_date + bank_clearing_number + sequence_number + creation_date + payers_clearing_number + file_identification + record_sequence_number + transaction_type + payment_type + transaction_flag    
  end
    
  def execution_date
    @data[:execution_date] || '000000'
  end
  
  def bank_clearing_number
    ''.ljust(12,' ')
  end
  
  def sequence_number
    "00000"
  end
  
  def creation_date
    Date.today.strftime("%y%m%d")
  end
  
  def payers_clearing_number
    @data[:payers_clearing_number].ljust(7,"0") rescue raise "Invalid payers_clearing_number"
  end
  
  def file_identification
    if @data[:file_identification].nil?
      raise "No file identification"
    else
      @data[:file_identification]
    end
  end
  
  def record_sequence_number
    @data[:record_sequence_number].to_s.rjust(5,"0") rescue raise "No record sequence_number"
  end
  
  def transaction_type
    "826"
  end
  
  def payment_type
    "1"
  end
  
  def transaction_flag
    "0"
  end  
end