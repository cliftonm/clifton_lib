require "clifton_lib/version"
require "clifton_lib/xml/xml_node"

module CliftonXml
  class XmlElement < XmlNode

    # XmlElement.new()
    def initialize(&block)
      super()
      instance_eval(&block) unless block.nil?

      self
    end

    # void append_attributes(XmlAttribute attr)
    def append_attribute(attr)
      @attributes << attr
      attr.xml_element = self

      nil
    end

    # XmlElement previous_sibling()
    def previous_sibling()
      # TODO
    end

    # XmlElement next_sibling()
    def next_sibling()
      # TODO
    end
  end
end
