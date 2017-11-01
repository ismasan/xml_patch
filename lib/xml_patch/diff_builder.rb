require 'oga'
require 'xml_patch/diff_document'
require 'xml_patch/operations'

module XmlPatch
  class DiffBuilder
    attr_reader :diff_document

    def initialize
      @diff_document = XmlPatch::DiffDocument.new
    end

    def add(op_name, xpath)
      op = XmlPatch::Operations.instance(op_name, sel: xpath)
      diff_document << op if op
      diff_document
    end

    def parse(xml)
      handler = SaxHandler.new(self)
      Oga.sax_parse_xml(handler, xml)
      self
    end

    class SaxHandler
      attr_reader :builder

      def initialize(builder)
        @builder = builder
      end

      def on_element(_namespace, name, attrs = {})
        builder.add name, attrs['sel']
      end
    end

    private_constant :SaxHandler
  end
end
