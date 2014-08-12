#rails pattern: trim spaces on input >> http://scottmoonen.com/2009/05/08/rails-pattern-trim-spaces-on-input/
module Trimmer
  # Make a class method available to define space-trimming behavior.
  def self.included base
    base.extend(ClassMethods)
  end
 
  module ClassMethods
    # Register a before-validation handler for the given fields to
    # trim leading and trailing spaces.
    def trimmed_fields *field_list
      before_validation do |model|
        field_list.each do |n|
          model[n] = model[n].strip if model[n].respond_to?('strip')
        end
      end
    end
  end
end