class ModelReader
  include Enumerable

  LINE_SEPARATOR_REGEX = Regexp.new(/(?<namelist_value>&.*?\/)/m)

  attr_reader :file

  def initialize(file)
    @file = file
  end

  def call
    file.read
  end

  def each(&block)
    e = Enumerator.new do |yielder|
      accu = ""
      file.each do |line|
        next if line == ""
        accu = accu + line
        if accu.match?(LINE_SEPARATOR_REGEX)
          yielder << accu.match(LINE_SEPARATOR_REGEX)[:namelist_value]
          accu = ""
        end
      end
    end

    return e unless block
    e.map(&block)
  end
end
