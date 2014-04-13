# CliftonLib

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'clifton_lib'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install clifton_lib

## Usage

This is a collection of useful functionality that I require for various projects that I'm working on.

In version 0.0.1, I've implemented several XML helper classes, similar to .NET's XmlDocument, to facilitate the
creation and serialization of XML.  In this version, the support is bare bones but sufficient for what I need done.

For example usage, see the xml_document_tests.rb file.

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

Regarding point 4, while may be standard practice in Ruby, this one of the reasons I find Ruby development so much slower -- you're constantly referencing external documentation to know what you can and can't pass in to a function rather than have the IDE tell you what the allowable parameters are.  Maybe I'm missing some deeper understanding here.

Instead, I want to base XML document generation (and eventually parsing) on Microsoft's implementation of the XmlDocument class in .NET:

http://msdn.microsoft.com/en-us/library/system.xml.xmldocument.aspx

This:

1. Is a decent object-oriented solution for creating XML documents
2. Inherently supports dynamic XML generation
3. Isn't DSL-ish.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
