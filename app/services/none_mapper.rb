class NoneMapper
  def self.call(tuple, validation_run)
    UnmappedNameList.create(validation_run: validation_run, line: "&#{tuple.name} #{tuple.arguments}/")
  end
end
