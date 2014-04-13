require 'test/unit'
require 'clifton_xml/xml_document'
require 'clifton_xml/xml_declaration_node'
require 'clifton_xml/xml_text_writer'

include CliftonXml

class XmlDocumentTests < Test::Unit::TestCase
  # Create a document and verify that no child nodes and attributes exist.
  def test_create_node
    xdoc = XmlDocument.new()
    assert_equal xdoc.child_nodes.count, 0
    assert_equal xdoc.attributes.count, 0
  end

  # Create an XML declaration header and verify the attribute and node counts.
  def test_xml_declaration
    xdoc = XmlDocument.new()
    node = xdoc.create_xml_declaration('1.0', 'UTF-8')
    assert_equal node.attributes.count, 2
    xdoc.append_child(node)
    assert_equal xdoc.child_nodes.count, 1
    assert_equal xdoc.attributes.count, 0
  end

  # Create a document with one root and two children.
  def test_element_creation
    xdoc = XmlDocument.new()
    products = xdoc.create_element('Products')
    xdoc.append_child(products)

    product1 = xdoc.create_element('Product')
    product2 = xdoc.create_element('Product')

    products.append_child(product1)
    products.append_child(product2)

    assert_equal xdoc.child_nodes.count, 1
    assert_equal xdoc.child_nodes[0].child_nodes.count, 2
  end

  # Create a document with one root, two children, and two attributes for each child.
  def test_element_attributes
    xdoc = XmlDocument.new()
    products = xdoc.create_element('Products')
    xdoc.append_child(products)

    product1 = xdoc.create_element('Product')
    id_attr1 = xdoc.create_attribute('ID')
    name_attr1 = xdoc.create_attribute('Name')
    id_attr1.value = '1'
    name_attr1.value = 'Apples'
    product1.append_attribute(id_attr1)
    product1.append_attribute(name_attr1)

    product2 = xdoc.create_element('Product')
    id_attr2 = xdoc.create_attribute('ID')
    name_attr2 = xdoc.create_attribute('Name')
    id_attr2.value = '2'
    name_attr2.value = 'Oranges'
    product2.append_attribute(id_attr1)
    product2.append_attribute(name_attr1)

    products.append_child(product1)
    products.append_child(product2)

    assert_equal xdoc.child_nodes.count, 1
    assert_equal xdoc.child_nodes[0].child_nodes.count, 2
    assert_equal xdoc.child_nodes[0].child_nodes[0].attributes.count, 2
    assert_equal xdoc.child_nodes[0].child_nodes[1].attributes.count, 2
  end

  # test the serialization of a simple structure with an inner element having inner text.
  def test_serialization
    xdoc = XmlDocument.new()
    decl_node = xdoc.create_xml_declaration('1.0', 'UTF-8')
    xdoc.append_child(decl_node)

    products = xdoc.create_element('Products')
    xdoc.append_child(products)

    product1 = xdoc.create_element('Product')
    id_attr1 = xdoc.create_attribute('ID')
    name_attr1 = xdoc.create_attribute('Name')
    id_attr1.value = '1'
    name_attr1.value = 'Apples'
    product1.append_attribute(id_attr1)
    product1.append_attribute(name_attr1)
    product1.inner_text = 'foobar'

    product2 = xdoc.create_element('Product')
    id_attr2 = xdoc.create_attribute('ID')
    name_attr2 = xdoc.create_attribute('Name')
    id_attr2.value = '2'
    name_attr2.value = 'Oranges'
    product2.append_attribute(id_attr2)
    product2.append_attribute(name_attr2)

    products.append_child(product1)
    products.append_child(product2)

    tw = XmlTextWriter.new()
    tw.formatting = :indented
    xdoc.save(tw)
    output = tw.output
    assert_equal %Q|<?xml version="1.0" encoding="UTF-8"?>\r\n<Products>\r\n  <Product ID="1" Name="Apples">foobar</Product>\r\n  <Product ID="2" Name="Oranges"/>\r\n</Products>|, output
    end
  end

