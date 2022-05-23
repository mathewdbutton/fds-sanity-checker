class ModelPipeline
  def self.call(file)
    CurrentValidation.validation_run = ValidationRun.generate

    input_records = ModelReader.new(file).each do |line|
      LineUnbundler.new(line).call
      .then { |cleaned_line| NamelistExtractor.call(cleaned_line) }
      .then { |namelist_tuple| NamelistFactory.call(namelist_tuple) }
      .then { |mapper, namelist_tuple| mapper.call(namelist_tuple, CurrentValidation.validation_run) }
    end

    # groups = input_records.compact.group_by(&:class)
    # groups.each do |clazz, input_records|
    #   clazz.insert_all(input_records.map(&:attributes))
    # end
    # binding.irb
    input_records.compact.each(&:save)
  end
end
