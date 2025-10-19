import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

// The base class for all our auth events
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

// Event for when the user wants to sign in
class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  const SignInRequested(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

// Event for when the user wants to sign up
class SignUpRequested extends AuthEvent {
  final String email;
  final String password;

  const SignUpRequested(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

// Event for when the user wants to sign out
class SignOutRequested extends AuthEvent {}

// Event for when Firebase's own auth state changes
class AuthStateChanged extends AuthEvent {
  final User? user;

  const AuthStateChanged(this.user);

  @override
  List<Object?> get props => [user];
}