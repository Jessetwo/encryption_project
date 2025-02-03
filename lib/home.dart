import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'encryption.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _plaintextController = TextEditingController();
  final TextEditingController _keyController = TextEditingController();
  final TextEditingController _encryptedTextController =
      TextEditingController();
  final TextEditingController _decryptionKeyController =
      TextEditingController();
  String _result = '';
  String _decryptedText = '';

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
      _encryptedTextController.text = encryptedText;
    });
  }

  void _decrypt() {
    String encryptedText = _encryptedTextController.text;
    String key = _decryptionKeyController.text;
    if (encryptedText.isEmpty || key.isEmpty) {
      setState(() {
        _result = 'Please enter both encrypted text and decryption key.';
      });
      return;
    }
    String decryptedText = Encryption.decrypt(encryptedText, key);
    setState(() {
      _result = 'Decrypted Text: $decryptedText';
      _decryptedText = decryptedText;
    });
  }

  void _copyDecryptedText() {
    Clipboard.setData(ClipboardData(text: _decryptedText));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Decrypted text copied to clipboard')),
    );
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
            TextField(
              controller: _decryptionKeyController,
              decoration: InputDecoration(labelText: 'Decryption Key'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _decrypt,
              child: Text('Decrypt'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    _decryptedText,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.copy),
                  onPressed:
                      _decryptedText.isNotEmpty ? _copyDecryptedText : null,
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              _result,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
