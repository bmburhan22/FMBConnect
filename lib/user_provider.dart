import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fmb_connect/auth.dart';
import 'package:fmb_connect/functions.dart';

class UserNotifier extends StateNotifier<User?> {
  UserNotifier() : super(null) {
    _init();
  }
  Future<void> _init() async {
    setUser( await Auth.authState());
    print('432r $state');
  }

  void setUser(User? user) {
    state = user;
  }
}

final userProvider =
    StateNotifierProvider<UserNotifier, User?>((ref) => UserNotifier());
