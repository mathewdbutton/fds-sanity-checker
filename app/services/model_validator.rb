class ModelValidator
  def self.call(file)
    CurrentValidation.validation_run = ValidationRun.generate

    cleaned_lines = ModelReader.new(file).call
      .then { |text_blob| LineUnbundler.new(text_blob).call }

    cleaned_lines.map do |cleaned_line|
      NamelistExtractor.call(cleaned_line)
        .then { |namelist_tuple| NamelistFactory.call(namelist_tuple) }
        .then { |mapper, namelist_tuple| mapper.call(namelist_tuple, CurrentValidation.validation_run) }
    end
  end
end
