require 'rubygems'; require 'nokogiri'; require 'cobravsmongoose'

class StandardNote

 def initialize file
   @doc = Nokogiri::XML.parse(File.open(file).read)
 end
 
 def rawtext
  rawtext = ""
  wordml_text_nodes = @doc.xpath('//w:t', {'w' => 'http://schemas.openxmlformats.org/wordprocessingml/2006/main'})
  wordml_text_node_array = []
   wordml_text_nodes.collect do |wordml_text_node|
   wordml_text_node_array << wordml_text_node.inner_html
   rawtext = wordml_text_node_array.join
  end
 rawtext
 end
 
 def pack
 xmlpackage_packages = @doc.xpath('//pkg:part', {'pkg' => 'http://schemas.microsoft.com/office/2006/xmlPackage'})
 
 packages = []
 xmlpackage_packages.collect do |xmlpackage_package|
   packages << [xmlpackage_package['contentType'],xmlpackage_package['padding'],xmlpackage_package['name']]
 end
 packages
 end
 
 def xx
   CobraVsMongoose.xml_to_hash(@doc)
 end
 
end
    
sn = StandardNote.new('snep-01942.xml')

p sn.xx
