require 'rubygems'; require 'nokogiri'; require 'morph'

class StandardNote
include Morph  # allows class to morph

def initialize file
 doc = Nokogiri::XML.parse(File.open(file).read)
 
 ps = doc.xpath('//w:t', {'w' => 'http://schemas.openxmlformats.org/wordprocessingml/2006/main'})
 value = []
 ps.collect do |node|
   label = "rawtext"
   value << node.content

   morph(label, value.join(' '))  # morph magic happening here!
 end
end
end

def StandardNote file; StandardNote.new file; end

sn = StandardNote 'snep-01942.xml'

p StandardNote.morph_methods

p sn.rawtext