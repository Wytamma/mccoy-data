from Bio import SeqIO

in_file = "data/influenza/InfluenzaAH3N2_HAgene_2009_California_heterochronous.nexus"

with open(in_file, "rU") as input_handle:
    with open(f"{in_file}.fasta", "w") as output_handle:
        sequences = SeqIO.parse(input_handle, "nexus")
        count = SeqIO.write(sequences, output_handle, "fasta")
