import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

void main() {
  runApp(const JarvisApp());
}

class JarvisApp extends StatelessWidget {
  const JarvisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JARVIS',
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FlutterTts flutterTts = FlutterTts();
  final stt.SpeechToText speech = stt.SpeechToText();
  String texto = "Ola, eu sou o JARVIS";
  bool ouvindo = false;

  Future<void> falar(String frase) async {
    await flutterTts.setLanguage("pt-BR");
    await flutterTts.setPitch(0.8);
    await flutterTts.speak(frase);
  }

  void ouvir() async {
    bool disponivel = await speech.initialize();
    if (disponivel) {
      setState(() => ouvindo = true);
      speech.listen(
        onResult: (resultado) {
          setState(() {
            texto = resultado.recognizedWords;
          });
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("JARVIS")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            texto,
            style: const TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ouvir();
          falar("Ola Jarvis, estou ouvindo");
        },
        child: const Icon(Icons.mic),
      ),
    );
  }
}
```
  
