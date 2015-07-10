require 'csv'

class DinoCsvParser
  attr_reader :header_conversions

  DEFAULT_HEADER_CONVERSIONS = {
    'WEIGHT_IN_LBS' => 'WEIGHT',
    'Genus'         => 'NAME',
  }

  def initialize(dino_class, opts = {})
    @dino_class = dino_class
    @header_conversions = opts.fetch(:header_conversions, DEFAULT_HEADER_CONVERSIONS)
  end

  def parse_file(filename)
    CSV.table(filename, header_converters: lambda { |h| normalized_header(h) }).map do |row|
      @dino_class.new(row.to_hash)
    end
  end

  private

  def normalized_header(header)
    (header_conversions[header] || header).downcase.to_sym unless header.nil?
  end
end
