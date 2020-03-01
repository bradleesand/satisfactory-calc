class BigDecimalFormatter
  def initialize(value)
    @value = BigDecimal.new(value)
  end

  def to_s
    BigDecimalFormatter.to_s(@value)
  end

  def self.to_s(number, truncate = 2)
    if number == number.to_i
      number.to_i
    else
      number.truncate(truncate)
    end.to_s
  end
end