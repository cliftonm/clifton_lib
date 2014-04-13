require "clifton_lib/version"
require "clifton_xml/xml_attribute"
require "clifton_xml/xml_node"

module CliftonXml
  class XmlDeclarationNode < XmlNode

    # XmlDeclarationNode.new() {... attribute initialization ... }
    def initialize(&block)
      super()
      instance_eval(&block) unless block.nil?

      self
    end
  end
end