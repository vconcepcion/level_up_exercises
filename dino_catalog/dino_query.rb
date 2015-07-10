class DinoQuery
  attr_reader :catalog

  def initialize(catalog)
    @catalog = catalog
  end

  def results
    @results ||= catalog.dinos
  end

  [:biped, :carnivore, :big, :small].each do |criteria|
    define_method(criteria) do
      @results = results.select { |d| d.send("#{criteria}?") }
      self
    end
  end

  def in_period(period)
    @results = results.select { |d| d.periods.include?(period) }
    self
  end
end
