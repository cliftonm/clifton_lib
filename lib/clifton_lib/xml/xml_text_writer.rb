require "clifton_lib/version"

module CliftonXml
  # For the moment, simply builds a string locally.
  # TODO: Implement streams, passing in an output stream to the constructor, like a StringWriter or FileWriter stream.
  class XmlTextWriter
    attr_accessor :formatting
    attr_accessor :allow_self_closing_tags
    attr_reader :output

    # XmlTextWriter.new()
    def initialize()
      @output = ''
      @indent = 0
      @formatting = :none
      @allow_self_closing_tags = true       # HTML5 compatibility, set to false.
    end

    # void write(string str)
    def write(str)
      @output << str

      nil
    end

    # void new_line()
    def new_line()
      if @formatting == :indented
        @output << "\r\n"
        @output << indentation(@indent)
      end

      nil
    end

    # void indent()
    def indent()
      @indent = @indent + 2

      nil
    end

    # void outdent()
    def outdent()
      @indent = @indent - 2

      nil
    end

    private

    # string indentation(int amt)
    def indentation(amt)
      ' ' * amt
    end
  end
end
