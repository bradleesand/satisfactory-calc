class FormattedBigDecimal < BigDecimal
  def to_s
    if self == self.to_i
      self.to_i.to_s
    else
      BigDecimal.new(self).truncate(2).to_s
    end
  end
end