class Dino
  attr_accessor :name,   :period,  :continent, :diet,
                :weight, :walking, :description

  CARNIVORE_DIETS  = %w(Carnivore Insectivore Piscivore)
  PERIODS          = %w(Albian Cretaceous Jurassic Oxfordian Permian Triassic)
  WEIGHT_THRESHOLD = 2000

  def initialize(attrs = {})
    attrs.each do |key, value|
      self.send("#{key}=", value)
    end
  end

  def biped?
    walking == 'Biped'
  end

  def carnivore?
    CARNIVORE_DIETS.include?(diet)
  end

  def diet
    @diet || 'Unknown'
  end

  def periods
    PERIODS.select { |p| period.include?(p) }
  end

  def big?
    weight.to_i > WEIGHT_THRESHOLD
  end

  def small?
    !big?
  end

  private

  def carnivore=(value)
    diet = 'Carnivore' if value == 'Yes'
  end
end
