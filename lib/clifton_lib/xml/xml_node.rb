require "clifton_lib/version"

module CliftonXml
  class XmlNode
    attr_accessor :name
    attr_accessor :inner_text
    attr_accessor :parent_node    # Annoying rubyism -- if in the class itself, property must be read/writeable.
    attr_accessor :xml_document
    attr_reader :attributes
    attr_reader :child_nodes

    # XmlNode.new()
    def initialize()
      @attributes = []
      @child_nodes = []
      @parent_node = nil
      @name = nil
      @inner_text = nil
      @xml_document = nil

      self
    end

    # bool has_child_nodes()
    def has_child_nodes()
      @child_nodes.count > 0
    end

    # void append_child(XmlNode node)
    def append_child(node)
      @child_nodes << node
      node.parent_node = self

      nil
    end
  end
end
