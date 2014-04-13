require "clifton_lib/version"
require "clifton_lib/xml/xml_attribute"
require "clifton_lib/xml/xml_element"
require "clifton_lib/xml/xml_node"
require "clifton_lib/xml/xml_declaration_node"

module CliftonXml
  class XmlDocument < XmlNode

    # XmlDocument.new()
    def initialize
      super()
    end

    # XmlDeclarationNode create_xml_declaration(string version, string encoding)
    def create_xml_declaration(version, encoding)
      declNode = XmlDeclarationNode.new() {
        @attributes << XmlAttribute.new() {@name='version'; @value=version}
        @attributes << XmlAttribute.new() {@name='encoding'; @value=encoding}
      }

      declNode
    end

    # XmlAttribute create_attribute(string name)
    def create_attribute(name)
      attr = XmlAttribute.new() {@name = name}

      attr
    end

    # XmlElement create_element(string name)
    def create_element(name)
      elem = XmlElement.new() {@name = name}

      elem
    end

    def document_element()
      # TODO
    end

    def document_type()
      # TODO
    end

    # void save(XmlTextWriter writer)
    def save(writer)
      write_nodes(writer, @child_nodes)

      nil
    end

    private

    # void write_nodes(XmlTextWriter writer, XmlNodes[] nodes)
    def write_nodes(writer, nodes)
      nodes.each_with_index do |node, idx|
        # write xml declaration if it exists.
        # TODO: Should throw somewhere if this isn't the first node.
        if node.is_a?(XmlDeclarationNode)
          writer.write('<?xml')
          write_attributes(writer, node)
          writer.write('?>')
          writer.new_line()
        else
          # begin element tag and attributes
          writer.write('<' + node.name)
          write_attributes(writer, node)

          # if inner text, write it out now.
          if node.inner_text
            writer.write('>' + node.inner_text)
            writer.write('</' + node.name + '>')
            crlf_if_more_nodes(writer, nodes, idx)
          else
          # Children are allowed only if there is no inner text.
            if node.has_child_nodes()
              # close element tag, indent, and recurse.
              writer.write('>')
              writer.indent()
              writer.new_line()
              write_nodes(writer, node.child_nodes)
              writer.outdent()
              writer.new_line()
              # close the element
              writer.write('</' + node.name + '>')
              crlf_if_more_nodes(writer, nodes, idx)
            else
              # if no children and no inner text, use the abbreviated closing tag token.
              writer.write('/>')
              crlf_if_more_nodes(writer, nodes, idx)
            end
          end
        end
      end

      nil
    end

    # Write the attribute collection for a node.
    # void write_attributes(XmlTextWriter writer, XmlNode node)
    def write_attributes(writer, node)
      if node.attributes.count > 0
        # stuff them into an array of strings
        attrs = []

        node.attributes.each do |attr|
          attrs << attr.name + '="' + attr.value + '"'
        end

        # separate them with a space
        attr_str = attrs.join(' ')

        # requires a leading space as well to separate from the element name.
        writer.write(' ' + attr_str)
        end

      nil
    end

    # bool more_nodes(XmlNodes[] nodes, int idx)
    def more_nodes(nodes, idx)
      idx + 1 < nodes.count
    end

    # void crlf_if_more_nodes(XmlTextWriter writer, XmlNodes[] nodes, int idx)
    def crlf_if_more_nodes(writer, nodes, idx)
      if more_nodes(nodes, idx)
        writer.new_line()
      end

      nil
    end
  end
end
