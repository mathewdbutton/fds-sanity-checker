class NamelistExtractor
  NAMELIST_EXTRACTOR = Regexp.new(/^&(?<name>\w.*?)\s(?<arguments>.*)/)

  NamelistTuple = Struct.new(:name, :arguments, keyword_init: true)

  def self.call(line)
    new(line).call
  end

  attr_reader :line

  def initialize(line)
    @line = line
  end

  def call
    NamelistTuple.new(name: namelist_name, arguments: namelist_arguments)
  end

  private

  def namelist_name
    name_and_arguments[:name]
  end

  def namelist_arguments
    name_and_arguments[:arguments].gsub(/\s\//, "")
  end

  def name_and_arguments
    @name_and_arguments ||= line.match(NAMELIST_EXTRACTOR)
  end
end
