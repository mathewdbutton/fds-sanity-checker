class ModelValidator
  def self.call(file)
    ModelReader.new(file)
      .then { |text_blob| LineUnbundler.new(text_blob).call }
      .then { |cleaned_lines| }
  end
end
