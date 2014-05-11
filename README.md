# CliftonLib

This is a collection of useful functionality that I require for various projects that I'm working on.

In version 0.0.1, I've implemented several XML helper classes, similar to .NET's XmlDocument, to facilitate the
creation and serialization of XML.  In this version, the support is bare bones but sufficient for what I need done.

Why do this?

All the implementations for XML support that I've seen in Ruby utilize the "method missing" feature, so that markup is written in a DSL manner.  For example:

doc.product = 'Apples'

will yield something like:

<product>Apples</product>

I have several issues with this:

1. It isn't object oriented.
2. It assumes you know the element and attribute names, which isn't convenient when generating XML dynamically from other data sources
3. It leverages "method missing", which affects performance and creates an internal DSL which isn't necessary.
4. Frequently, the parameters are passed as hashes, which I find particularly evil in Ruby as they don't document what the valid parameter-hashes are via function parameters.

Instead, I want to base XML document generation (and eventually parsing) on Microsoft's implementation of the XmlDocument class in .NET:

http://msdn.microsoft.com/en-us/library/system.xml.xmldocument.aspx

This implementation:

1. Is a decent object-oriented solution for creating XML documents
2. Inherently supports dynamic XML generation
3. Isn't DSL-ish.

## Revisions

Published 0.0.8 - Fixed indentation issues with XmlFragments
Published 0.0.7 - Added XmlFragment
0.0.6 -
Published 0.0.5 - Added support to disallow a closing tag for HTML5 compatibility.  For example, <img> is valid, <img></img> is seen as a stray ending tag.
0.0.4 - Added support to disallow self-closing tags for HTML5 compatibility.  For example, <div>...</div> is valid, </div> is not.
0.0.3 - Added support for valueless attributes.  Example: <nav class="top-bar" data-topbar/>
0.0.2 - Additional internal properties for associating the XmlDocument to elements and XmlElement to attributes.
Published 0.0.1 - Initial version.

## A note about the code

You'll find that I do certain things, like explicitly return nil when the function isn't intended to return anything.  This avoids accidental usage of a return from a function where
that is an unintended consequence of the last line executed in the function.

## Installation

Add this line to your application's Gemfile:

    gem 'clifton_lib'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install clifton_lib

## Usage

XML Serialization Example:

```ruby
require 'test/unit'
require 'clifton_lib/xml/xml_document'
require 'clifton_lib/xml/xml_declaration_node'
require 'clifton_lib/xml/xml_text_writer'

include CliftonXml

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
```

The result looks like:

```XML
<Products>
  <Product ID="1" Name="Apples">foobar</Product>
  <Product ID="2" Name="Oranges" />
</Products>
```

For further examples, see the xml_document_tests.rb file.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
