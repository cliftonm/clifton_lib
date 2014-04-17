require "clifton_lib/version"
require "clifton_lib/xml/xml_node"

module CliftonXml
  class XmlFragment < XmlNode
    attr_accessor :text

    # HtmlFragment.new() {@text = 'stuff'}
    def initialize(&block)
      super()
      @text = ''
      instance_eval(&block) unless block.nil?

      self
    end
  end
end
