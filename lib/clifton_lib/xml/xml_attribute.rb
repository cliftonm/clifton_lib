require "clifton_lib/version"

module CliftonXml
  class XmlAttribute
    attr_accessor :name
    attr_accessor :value
    attr_accessor :xml_document
    attr_accessor :xml_element

    # XmlAttribute.new() {@name = [name]; @value = [value]}
    def initialize(&block)
      # this can use the form {@<attr> = <value>}
      # allow for default constructor.
      @xml_document = nil
      instance_eval(&block) unless block.nil?
      # yield self if block_given?
      # this requires the form {|inst| inst.<attr> = <value>}

      self
    end
  end
end
