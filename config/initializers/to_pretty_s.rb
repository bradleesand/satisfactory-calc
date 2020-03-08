class Object
  def to_pretty_s
    to_s
  end
end

class BigDecimal
  def to_pretty_s
    FormattedBigDecimal.new(self).to_s
  end
end
