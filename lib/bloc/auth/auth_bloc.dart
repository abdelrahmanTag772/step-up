// lib/bloc/auth/auth_bloc.dart

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:digital_egypt_pioneers/bloc/auth/auth_event.dart';
import 'package:digital_egypt_pioneers/bloc/auth/auth_state.dart';
import 'package:digital_egypt_pioneers/services/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  late final StreamSubscription<User?> _userSubscription;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    _userSubscription = authRepository.user.listen((user) {
      add(AuthStateChanged(user));
    });

    on<AuthStateChanged>((event, emit) {
      if (event.user != null) {
        emit(Authenticated(event.user!));
      } else {
        emit(Unauthenticated());
      }
    });

    on<SignInRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        // The logic inside the try block is now simpler
        final userCredential = await authRepository.signInWithEmailAndPassword(
          event.email,
          event.password,
        );
        emit(Authenticated(userCredential.user!));
      } on FirebaseAuthException catch (e) {
        emit(AuthError(e.message ?? "An unknown sign-in error occurred."));
      }
    });

    on<SignUpRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final userCredential = await authRepository.signUpWithEmailAndPassword(
          event.email,
          event.password,
        );
        emit(Authenticated(userCredential.user!));
      } on FirebaseAuthException catch (e) {
        emit(AuthError(e.message ?? "An unknown sign-up error occurred."));
      }
    });

    on<SignOutRequested>((event, emit) async {
      emit(AuthLoading());
      await authRepository.signOut();
      emit(Unauthenticated());
    });
  } // <-- THE CONSTRUCTOR ENDS HERE

  @override
  Future<void> close() { // <-- THE CLOSE METHOD IS NOW OUTSIDE THE CONSTRUCTOR
    _userSubscription.cancel();
    return super.close();
  }
}