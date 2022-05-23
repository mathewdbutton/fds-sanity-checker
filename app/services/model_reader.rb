class ModelReader
  include Enumerable

  LINE_SEPARATOR_REGEX = Regexp.new(/&.*?\//m)

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
        accu = accu + line
        if accu.match?(LINE_SEPARATOR_REGEX)
          yielder << accu
          accu = ""
        end
      end
    end

    return e unless block
    e.map(&block)
  end
end
