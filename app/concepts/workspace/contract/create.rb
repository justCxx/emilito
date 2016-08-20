require 'reform/form/dry'

class Workspace
  module Contract
    class Create < Base
      feature Reform::Form::Dry
      validation do
        required(:title).filled(:str?)
      end
    end
  end
end
