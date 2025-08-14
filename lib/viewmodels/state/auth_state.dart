import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthState{
  final bool isLogin;
  final String? user;

  AuthState({
    required this.isLogin,
    this.user
  });

  AuthState copyWith({bool? isLogin, String? user
  }) {
    return AuthState(
      isLogin: isLogin ?? this.isLogin,
      user: user ?? this.user
    );
  }
}

class AuthStateNotifier extends StateNotifier<AuthState>{
  AuthStateNotifier() : super(AuthState(isLogin: false));

  void login(String? username, String? password){
    state = state.copyWith(isLogin: false);
    if(username == null) {
      state = state.copyWith(isLogin: true);
    }else{
      state = state.copyWith(isLogin: true, user: username);
    }
  }

  void logout(){
    state = state.copyWith(isLogin: false, user: null);
  }
}

final authStateNotifierProvider = StateNotifierProvider<AuthStateNotifier,AuthState>((ref) {
  return AuthStateNotifier();
});