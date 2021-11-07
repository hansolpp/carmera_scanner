import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DependencyInjection extends StatelessWidget {
  const DependencyInjection({
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: const [],
      child: MultiBlocProvider(
        providers: const [],
        child: Builder(builder: (context) {
          return child;
        }),
      ),
    );
  }
}
