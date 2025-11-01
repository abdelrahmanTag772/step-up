import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

// The base class for all our auth states
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

// The initial state, before anything has happened
class AuthInitial extends AuthState {}

// State when authentication is in progress (e.g., loading spinner)
class AuthLoading extends AuthState {}

// State when the user is successfully authenticated
class Authenticated extends AuthState {
  final User user;

  const Authenticated(this.user);

  @override
  List<Object?> get props => [user];
}

// State when the user is not authenticated (logged out or failed login)
class Unauthenticated extends AuthState {}

// State for when an error occurs
class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}