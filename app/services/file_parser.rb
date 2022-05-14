class FileParser
  attr_reader :file

  def initialize(file)
    @file = file
  end

  def call
    LineUnbundler.new(file.read).call
  end
end
