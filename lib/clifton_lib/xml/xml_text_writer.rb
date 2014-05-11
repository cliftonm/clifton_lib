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

    def write(str)
      @output << str
    end

    # void write(string str)
    def write_fragment(str)
      if @formatting == :indented
        # Take the fragment, split up the CRLF's, and write out in an indented manner.
        # Let the formatting of the fragment handle its indentation at our current indent level.
        lines = str.split("\r\n")
        lines.each_with_index do |line, idx|
          @output << line
          new_line() if idx < lines.count - 1       # No need for a new line on the last line.
        end
      else
        @output << str
      end

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
