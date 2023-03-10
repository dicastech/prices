class LocalData
  @@data = Array.new

  def self.call
    new.execute
  end

  def self.push(record)
    @@data.push(record)
    @@data
  end
  
  def execute
    {
      detailed_report: {
        rental_price:      detailed_report(:rental_price),
        water_price:       detailed_report(:water_price),
        energy_price:      detailed_report(:energy_price),
        internet_price:    detailed_report(:internet_price),
        marketplace_price: detailed_report(:marketplace_price),
        transport_price:   detailed_report(:transport_price),
        leisure_price:     detailed_report(:leisure_price),
      },
      total_average: total_average,
      data: @@data,
    }
  end

  private

  def detailed_report(key)
    prices = @@data.map { |row| row[key].to_f }
    avg = prices.sum / prices.count
    max = prices.max
    min = prices.min

    {
      avg: avg,
      max: max,
      min: min,
    }
  end

  def total_average
    total_value = @@data.select do |row|
      row.values.none? { |v| v.nil? }
    end.map do |row|
      row.values.map { |v| v.to_f }.sum
    end.sum

    total_reports = @@data.count
    total_value / total_reports
  end
end