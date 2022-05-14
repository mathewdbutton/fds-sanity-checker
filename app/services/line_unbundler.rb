class LineUnbundler
  LINE_SEPARATOR_REGEX = Regexp.new(/&.*?\//m)

  def initialize(text_blob)
    @text_blob = text_blob
  end

  def call
    text_blob
      .then(&method(:clean_new_lines))
      .then(&method(:parse_fds_lines))
  end

  private

  def clean_new_lines(lines)
    lines.delete("\n")
  end

  def parse_fds_lines(lines)
    lines.scan(LINE_SEPARATOR_REGEX)
  end

  attr_reader :text_blob
end
