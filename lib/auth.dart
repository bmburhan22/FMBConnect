import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fmb_connect/constdata.dart';
import 'package:fmb_connect/functions.dart';
import 'package:fmb_connect/main.dart';

const FlutterSecureStorage _storage = FlutterSecureStorage();
clearLoginCred() async {
  await FirebaseMessaging.instance.deleteToken();
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
    final fcmtoken = await FirebaseMessaging.instance.getToken();
    print('FCM Token $fcmtoken');
    Map body = {'its': its, 'otp': otp, 'fcmtoken': fcmtoken};
    Map? data = await post('/verify_otp', body);
    state = (data?['auth'] ?? false)
        ? User(its, data?['name']??'')
        /*
         : User(its, constUserName);
        */
        : null;
  }

  logout() {
    clearLoginCred();
    state = null;
    navkey.currentState?.pop();
    navkey.currentState?.pushReplacementNamed( 'login');
  }

  Future<void> initAuth() async {
    if (state != null) return;
    String? its = await _storage.read(key: 'its');
    String? otp = await _storage.read(key: 'otp');
    if (its != null && otp != null) {
      await authenticate(its, otp);
      if (state == null) clearLoginCred();
    }
  }

  Future<void> login(String? its, String? otp) async {
    if (its == null || otp == null || its.isEmpty || otp.isEmpty) {
      showSnackBar('Enter ITS and OTP');
      return;
    }
    LoadingDialog('Logging in...').show();
    await authenticate(its, otp);
    navkey.currentState?.pop();

    if (state == null) {
      showSnackBar( 'Invalid OTP');
    } else {
      saveLoginCred(its, otp);
      navkey.currentState?.pushReplacementNamed('/');
    }
  }
}

final authProvider =
    StateNotifierProvider<AuthNotifier, User?>((ref) => AuthNotifier());
