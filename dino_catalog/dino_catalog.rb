class DinoCatalog
  attr_reader :csv_folder_path, :parser

  def initialize(options = {})
    @csv_folder_path = options.fetch(:csv_folder_path, ".")
    @parser          = options.fetch(:parser_class, DinoCsvParser).new(Dino)
  end

  def dinos
    @dinos ||= Dir["#{csv_folder_path}/*.csv"].map do |filename|
      parser.parse_file(filename)
    end.flatten
  end

  def query
    DinoQuery.new(self)
  end
end
