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
      rental_price: create(:rental_price),
      water_price: create(:water_price),
      energy_price: create(:energy_price),
      internet_price: create(:internet_price),
      marketplace_price: create(:marketplace_price),
      transport_price: create(:transport_price),
      leisure_price: create(:leisure_price),
      data: @@data,
    }
  end

  private

  def create(key)
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
end