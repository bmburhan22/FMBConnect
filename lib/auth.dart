import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fmb_connect/functions.dart';

const FlutterSecureStorage _storage = FlutterSecureStorage();
clearLoginCred() async {
  await _storage.delete(key: 'its');
  await _storage.delete(key: 'otp');
}

saveLoginCred(String its, String password) async {
  await _storage.write(key: 'its', value: its);
  await _storage.write(key: 'otp', value: password);
}

class AuthNotifier extends StateNotifier<User?> {
  AuthNotifier() : super(null);

  Future<void> authenticate(String its, String otp) async {
    Map body = {'its': its, 'otp': otp};
    Map? data = await fetch('/verify_otp', body);
    state = data?['auth'] ?? true
        ? User(its, 'Burhanuddin M. Bhinderwala')
        : User(its, 'Firstname Lastname');
  }

  logout(BuildContext context) {
    clearLoginCred();
    state = null;
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, 'login');
  }

  Future<void> initAuth() async {
    if (state != null) return;
    String? its = await _storage.read(key: 'its');
    String? otp = await _storage.read(key: 'otp');
    if (its != null && otp != null) {
      print('authenticating');
      await authenticate(its, otp);
      if (state == null) clearLoginCred();
    }
    state = User('111', 'NAME');
  }

  Future<void> login(BuildContext context, String? its, String? otp) async {
    if (its == null || otp == null || its.isEmpty || otp.isEmpty) {
      showSnackBar(context, 'Enter ITS and OTP');
      return;
    }
    LoadingDialog('Logging in...').show(context);
    await authenticate(its, otp);
    Navigator.pop(context);

    if (state == null) {
      showSnackBar(context, 'Invalid OTP');
    } else {
      saveLoginCred(its, otp);
      Navigator.pushReplacementNamed(context, '/');
    }
  }
}

final authProvider =
    StateNotifierProvider<AuthNotifier, User?>((ref) => AuthNotifier());
