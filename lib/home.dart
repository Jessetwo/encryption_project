// lib/main.dart

import 'package:flutter/material.dart';
import 'encryption.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Encryption & Decryption',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _plaintextController = TextEditingController();
  final TextEditingController _keyController = TextEditingController();
  final TextEditingController _encryptedTextController =
      TextEditingController();
  String _result = '';

  void _encrypt() {
    String plaintext = _plaintextController.text;
    String key = _keyController.text;
    if (plaintext.isEmpty || key.isEmpty) {
      setState(() {
        _result = 'Please enter both plaintext and key.';
      });
      return;
    }
    String encryptedText = Encryption.encrypt(plaintext, key);
    setState(() {
      _result = 'Encrypted Text: $encryptedText';
    });
  }

  void _decrypt() {
    String encryptedText = _encryptedTextController.text;
    String key = _keyController.text;
    if (encryptedText.isEmpty || key.isEmpty) {
      setState(() {
        _result = 'Please enter both encrypted text and key.';
      });
      return;
    }
    String decryptedText = Encryption.decrypt(encryptedText, key);
    setState(() {
      _result = 'Decrypted Text: $decryptedText';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Encryption & Decryption')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _plaintextController,
              decoration: InputDecoration(labelText: 'Plaintext'),
            ),
            TextField(
              controller: _keyController,
              decoration: InputDecoration(labelText: 'Secret Key'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _encrypt,
              child: Text('Encrypt'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _encryptedTextController,
              decoration: InputDecoration(labelText: 'Encrypted Text'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _decrypt,
              child: Text('Decrypt'),
            ),
            SizedBox(height: 20),
            Text(
              _result,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Copy and paste the Encrypted text in to the field and tap Decrypt',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Copy and paste the Encrypted text in to the field and tap Decrypt',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
