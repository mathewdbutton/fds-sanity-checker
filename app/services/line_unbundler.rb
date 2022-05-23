class LineUnbundler
  def initialize(text_blob)
    @text_blob = text_blob
  end

  def call
    text_blob
      .then(&method(:clean_new_lines))
      .then(&method(:remove_double_spaces))
      .then(&:strip)
  end

  private

  def clean_new_lines(line)
    line.delete("\n")
  end

  def remove_double_spaces(line)
    line.gsub(/\s+/, " ")
  end

  attr_reader :text_blob
end
