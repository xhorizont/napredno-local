import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  void _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = prefs.getInt('counter') ?? 0;
    });
  }

  void _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // Če želite pridobiti podatke iz lokalnega pomnilnika,
      //lahko uporabite get metodo. Ta metoda ima en parameter,
      //ključ podatkov, ki jih želite pridobiti

      _counter = (prefs.getInt('counter') ?? 0) + 1;

// lahko uporabite za shranjevanje podatkov z set metodo.
// Metoda setima dva parametra: ključ in vrednost. Ključ je niz,
// ki identificira podatke, ki jih shranjujete, vrednost pa je lahko
// katera koli primitivna vrsta podatkov (kot je int, bool, double ali String)

      prefs.setInt('counter', _counter);

//Posodabljanje podatkov v lokalni shrambi
//Če želite posodobiti podatke v lokalni shrambi, lahko preprosto z set
//znova pokličete metodo z istim ključem
    });
  }

  void _resetCounter() async {
    SharedPreferences prefs = await SharedPreferences
        .getInstance(); //Za lokalno shranjevanje podatkov boste morali ustvariti  razred SharedPreferences.
    setState(() {
      _counter = 0;

//Brisanje podatkov iz lokalnega pomnilnika
//Če želite izbrisati podatke iz lokalnega pomnilnika, lahko
//uporabite removemetodo. Ta metoda ima en parameter, ključ podatkov, ki jih želite odstraniti

      prefs.remove('counter');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lokalno Shranjevanje Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Lokalno Shranjevanje Demo'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Števec:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _incrementCounter,
                    child: const Text('Povečaj'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _resetCounter,
                    child: const Text('Ponastavi'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
