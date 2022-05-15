class ModelReader
  attr_reader :file

  def initialize(file)
    @file = file
  end

  def call
    file.read
  end
end
