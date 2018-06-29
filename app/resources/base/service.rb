module Base
  class Service
    attr_reader :params, :options
    attr_accessor :result

    def initialize(params, options={})
      @params = params
      @options = options
      self.result = {}
    end

    def self.call(params, options={})
      instance = self.new(params, options)
      instance.process
      instance.result
    end

  private
    def serialize_model(model, options)
      ActiveModelSerializers::SerializableResource.new(model, options).as_json
    end
  end
end