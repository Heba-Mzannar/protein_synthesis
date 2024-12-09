import 'package:flutter/material.dart';
//this to import flutter material package to provide widgets and themes for designing

void main() {
  runApp(const DnaTranslatorApp());
}
//entry point of the project (application)

class DnaTranslatorApp extends StatelessWidget {
  const DnaTranslatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //hides the debug banner
      title: 'DNA Codon Translator',
      theme: ThemeData(
        primaryColor:  Color.fromARGB(255, 50, 75, 95),
      ),
      home: const TranslatorScreen(), //sets the default screen while opening
    );
  }
}

//there are comments in grey.. from android studio

class TranslatorScreen extends StatefulWidget {
  const TranslatorScreen({super.key});

  @override
  _TranslatorScreenState createState() => _TranslatorScreenState();
}

class _TranslatorScreenState extends State<TranslatorScreen> {
  final Map<String, String> codonTable = {
    'ATG': 'Methionine',
    'TTT': 'Phenylalanine',
    'TTC': 'Phenylalanine',
    'TTA': 'Leucine',
    'TTG': 'Leucine',
    'CTT': 'Leucine',
    'CTC': 'Leucine',
    'CTA': 'Leucine',
    'CTG': 'Leucine',
    'ATT': 'Isoleucine',
    'ATC': 'Isoleucine',
    'ATA': 'Isoleucine',
    'GTT': 'Valine',
    'GTC': 'Valine',
    'GTA': 'Valine',
    'GTG': 'Valine',
    'TCT': 'Serine',
    'TCC': 'Serine',
    'TCA': 'Serine',
    'TCG': 'Serine',
    'CCT': 'Proline',
    'CCC': 'Proline',
    'CCA': 'Proline',
    'CCG': 'Proline',
    'ACT': 'Threonine',
    'ACC': 'Threonine',
    'ACA': 'Threonine',
    'ACG': 'Threonine',
    'GCT': 'Alanine',
    'GCC': 'Alanine',
    'GCA': 'Alanine',
    'GCG': 'Alanine',
    'TAT': 'Tyrosine',
    'TAC': 'Tyrosine',
    'TAA': 'Stop',
    'TAG': 'Stop',
    'CAT': 'Histidine',
    'CAC': 'Histidine',
    'CAA': 'Glutamine',
    'CAG': 'Glutamine',
    'AAT': 'Asparagine',
    'AAC': 'Asparagine',
    'AAA': 'Lysine',
    'AAG': 'Lysine',
    'GAT': 'Aspartic acid',
    'GAC': 'Aspartic acid',
    'GAA': 'Glutamic acid',
    'GAG': 'Glutamic acid',
    'TGT': 'Cysteine',
    'TGC': 'Cysteine',
    'TGA': 'Stop',
    'TGG': 'Tryptophan',
    'CGT': 'Arginine',
    'CGC': 'Arginine',
    'CGA': 'Arginine',
    'CGG': 'Arginine',
    'AGT': 'Serine',
    'AGC': 'Serine',
    'AGA': 'Arginine',
    'AGG': 'Arginine',
    'GGT': 'Glycine',
    'GGC': 'Glycine',
    'GGA': 'Glycine',
    'GGG': 'Glycine',
  };
//defines all the codon table

  final TextEditingController _controller =
      TextEditingController(); //manages the input for the DNA sequence
  String result = ""; //to store the result
  bool isLoading = false;

  void translateDna() {
    setState(() {
      isLoading = true; // Show loading indicator
    });

    Future.delayed(const Duration(seconds: 2), () {
      final input = _controller.text.toUpperCase();

      if (input.isEmpty || input.length % 3 != 0) {
        setState(() {
          result = "Invalid DNA sequence. Ensure length is a multiple of 3.";
          isLoading = false;
        }); //to ensure that the sequence is a multiple of 3
        return;
      }

      List<String> codons = [];
      for (int i = 0; i < input.length; i += 3) {
        codons.add(input.substring(i, i + 3));
      } //to split the DNA codons

      List<String> aminoAcids =
          codons.map((codon) => codonTable[codon] ?? "Unknown").toList();
      //maps the codon to its corresponding amino acid

      setState(() {
        result = aminoAcids.join('-');
        isLoading = false;
      });
    });
  }

  void resetFields() {
    setState(() {
      _controller.clear(); // Clear the text field
      result = ""; // Clear the result display
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DNA Codon Translator'),
        backgroundColor: const Color.fromARGB(181, 37, 106, 128),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 92, 119, 143), Color.fromARGB(255, 78, 121, 81), Color.fromARGB(255, 184, 130, 50)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'About DNA Codons',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'DNA codons are sequences of three nucleotides that correspond to specific amino acids or a stop signal during protein synthesis. '
                'For example, the codon "ATG" codes for Methionine, which is also the start codon for translation.',
                style: TextStyle(fontSize: 16, color: Colors.white),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),
              const Text(
                'Enter a DNA Sequence:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  hintText: 'e.g., ATGCGT',
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: isLoading
                    ? const CircularProgressIndicator(color: Color.fromARGB(255, 128, 104, 68))
                    : ElevatedButton(
                        onPressed: translateDna,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 177, 138, 80),
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                        child: const Text('Translate'),
                      ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: resetFields,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 146, 114, 77),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  child: const Text('Reset'),
                ),
              ),
              const SizedBox(height: 20),
              const Divider(color: Colors.white),
              const SizedBox(height: 10),
              const Text(
                'Result:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                result,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
