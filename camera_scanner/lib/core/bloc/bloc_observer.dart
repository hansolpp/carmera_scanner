import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as developer;

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    developer.log(
      '\n'
          '┌─[onCreate][-][-][-]─────────────────────────────\n'
          'Bloc: ${bloc.runtimeType}\n'
          '└────────────────────────────────────────────────\n',
    );
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    developer.log(
      '\n'
          '┌─────[-][onEvent][-][-]──────────────────────────\n'
          'Bloc: ${bloc.runtimeType}\n'
          'Event: $event\n'
          '└────────────────────────────────────────────────\n',
    );
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    developer.log(
      '\n'
          '┌───────────────[-][-][onChange][-]───────────────\n'
          'Bloc: ${bloc.runtimeType}\n'
          'State: $change \n'
          '└────────────────────────────────────────────────\n',
    );
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    developer.log(
      '\n'
          '┌─────────────────────────[-][-][-][onTransition]─\n'
          'Bloc: ${bloc.runtimeType}\n'
          'Transition: $transition\n'
          '└────────────────────────────────────────────────\n',
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    developer.log(
      '\n'
          '┌─[onError]──────────────────────────────────────\n'
          'Bloc: ${bloc.runtimeType}\n'
          'Error: $error\n'
          '└────────────────────────────────────────────────\n',
      error: error,
      stackTrace: stackTrace,
    );
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    developer.log(
      '\n'
          '┌─[onClose]──────────────────────────────────────\n'
          'Bloc: ${bloc.runtimeType}\n'
          '└────────────────────────────────────────────────\n',
    );
  }
}
