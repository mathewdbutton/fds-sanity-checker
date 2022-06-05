namespace :generate_mappings do
  desc "Generate Field Mappings"
  task :fields => :environment do
    Dir[File.join(Rails.root,"app/services/mapper","*rb")].each {|a| require_relative a}

    namelists = Mapper::Base.field_map_logging

    field_mapping_template = File.read(File.join(Rails.root,"app","views","documentation","field_mappings.md.erb"))

    File.open(File.join(Rails.root,"FIELD_MAPPINGS.md"), 'w') do |file|
      file.write(ERB.new(field_mapping_template, nil).result(binding))
    end
  end
end
