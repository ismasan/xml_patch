module XmlPatch
  module Operations
    def self.registry
      @registry ||= {}
    end

    def self.instance(op_name, *args)
      constructor = registry[op_name.to_sym]
      constructor ? constructor.new(*args) : nil
    end
  end
end

# auto load all available operations
Dir[File.join(File.dirname(__FILE__), 'operations')].each do |f|
  require f
end
