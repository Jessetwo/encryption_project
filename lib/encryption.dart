class Encryption {
  // Custom encryption algorithm
  static String encrypt(String plaintext, String key) {
    String encryptedText = '';
    for (int i = 0; i < plaintext.length; i++) {
      int charCode = plaintext.codeUnitAt(i) + key.codeUnitAt(i % key.length);
      encryptedText += String.fromCharCode(charCode);
    }
    return encryptedText;
  }

  // Custom decryption algorithm
  static String decrypt(String encryptedText, String key) {
    String decryptedText = '';
    for (int i = 0; i < encryptedText.length; i++) {
      int charCode =
          encryptedText.codeUnitAt(i) - key.codeUnitAt(i % key.length);
      decryptedText += String.fromCharCode(charCode);
    }
    return decryptedText;
  }
}
