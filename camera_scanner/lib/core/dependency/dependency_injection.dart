import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DependencyInjection extends StatelessWidget {
  const DependencyInjection({
    required this.child,
    this.isNotRequired = false,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final bool? isNotRequired;

  @override
  Widget build(BuildContext context) {
    if (isNotRequired!) {
      return child;
    }

    return MultiRepositoryProvider(
      providers: const [],
      child: MultiBlocProvider(
        providers: const [],
        child: child,
      ),
    );
  }
}
