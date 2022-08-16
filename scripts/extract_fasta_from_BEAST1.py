import xml.etree.ElementTree as ET

xml_file = "Full-EbolaTest-2015-42.xml"

tree = ET.parse(xml_file)

with open(f'{xml_file}.fasta', 'w') as f:
    for i in tree.iter():
        if i.tag == 'taxon' and 'idref' in i.keys():
            f.write(f">{i.get('idref')}\n")
            f.write(f"{i.tail}".replace('-', '').replace('\n', '').strip() + "\n")