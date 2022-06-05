namespace :generate_mappings do
  desc "Generate Field Mappings"
  task :fields => :environment do


    # Mapper.constants.map {|klass| "Mapper::#{klass}".constantize}.filter {|mapper| !(mapper == Mapper::Base || mapper == Mapper::InputAttribute)}.map(&:testing )
    Dir[File.join(Rails.root,"app/services/mapper","*rb")].each {|a| require_relative a}

    namelists = Mapper::Base.testing

    field_mapping_template = File.read(File.join(Rails.root,"app","views","documentation","field_mappings.md.erb"))

    
    File.open(File.join(Rails.root,"FIELD_MAPPINGS.md"), 'w') do |file|
       file.write(ERB.new(field_mapping_template, nil).result(binding))
    end
  end
end
