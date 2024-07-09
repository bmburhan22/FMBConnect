import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fmb_connect/functions.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Auth {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static login(BuildContext context, String? its, String? password) async {
    if (its == null || password == null || its.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter ITS and password')));
      return;
    }
    showLoaderDialog(context, 'Logging in...');
    bool isAuth = await authenticate(its, password);
    Navigator.pop(context);

    if (isAuth) {
      // Navigator.pop(context);
      Navigator.of(context).pushReplacementNamed('/', arguments: its);
      saveLoginCred(its, password);
    } else {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid ITS or password')));
    }
  }

  static logout(BuildContext context) {
    clearLoginCred();
    Navigator.pop(context);
    Navigator.of(context).pushNamed('login');
  }

  static saveLoginCred(String its, String password) async {
    await _storage.write(key: 'its', value: its);
    await _storage.write(key: 'password', value: password);
  }

  static clearLoginCred() async {
    await _storage.delete(key: 'its');
    await _storage.delete(key: 'password');
  }

  static Future<bool> authenticate(String its, String password) async {
    String loginURL = '${dotenv.env['API_URL']!}/login';
    Map body = {'its': its, 'password': password};
    Map? data = await fetch(loginURL, body);
    return data?['auth'] ?? false;
  }

  static Future<String> authState() async {
    String? its = await _storage.read(key: 'its');
    String? password = await _storage.read(key: 'password');
    if (its != null && password != null) {
      bool isAuth = await authenticate(its, password);
      if (!isAuth) clearLoginCred();
      return isAuth? its:'';
    }
    return '';
  }
}
