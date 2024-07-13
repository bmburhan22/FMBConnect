import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fmb_connect/functions.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Auth {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static login(BuildContext context, String? its, String? otp) async {
    if (its == null || otp == null || its.isEmpty || otp.isEmpty) {
      showSnackBar(context, 'Enter ITS and OTP');
      return;
    }
    showLoaderDialog(context, 'Logging in...');
    bool isAuth = await authenticate(its, otp);
    Navigator.pop(context);

    if (isAuth) {
      // Navigator.pop(context);
      Navigator.of(context).pushReplacementNamed('/', arguments: its);
      saveLoginCred(its, otp);
    } else {
      showSnackBar(context, 'Invalid OTP');
    }
  }

  static logout(BuildContext context) {
    clearLoginCred();
    Navigator.pop(context);
    Navigator.of(context).pushNamed('login');
  }

  static saveLoginCred(String its, String password) async {
    await _storage.write(key: 'its', value: its);
    await _storage.write(key: 'otp', value: password);
  }

  static clearLoginCred() async {
    await _storage.delete(key: 'its');
    await _storage.delete(key: 'otp');
  }

  static Future<bool> authenticate(String its, String otp) async {
    String loginURL = '${dotenv.env['API_URL']!}/verify_otp';
    Map body = {'its': its, 'otp': otp};
    Map? data = await fetch(loginURL, body);
    return data?['auth'] ?? false;
  }

  static Future<String> authState() async {
    String? its = await _storage.read(key: 'its');
    String? otp = await _storage.read(key: 'otp');
    if (its != null && otp != null) {
      bool isAuth = await authenticate(its, otp);
      if (!isAuth) clearLoginCred();
      return isAuth ? its : '';
    }
    return '';
  }
}
