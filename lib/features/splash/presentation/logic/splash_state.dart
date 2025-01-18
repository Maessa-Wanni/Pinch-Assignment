part of 'splash_cubit.dart';

/// splash state
abstract class SplashState extends Equatable {
  const SplashState();
}

/// initial state
class SplashInitial extends SplashState {
  @override
  List<Object> get props => [];
}
