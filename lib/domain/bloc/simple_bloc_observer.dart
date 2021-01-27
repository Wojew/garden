import '../domain.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  onEvent(
    Bloc bloc,
    Object event,
  ) {
    super.onEvent(
      bloc,
      event,
    );
    print('onEvent $event');
  }

  @override
  onTransition(
    Bloc bloc,
    Transition transition,
  ) {
    super.onTransition(
      bloc,
      transition,
    );
    print('onTransition $transition');
  }

  @override
  onError(
    Cubit cubit,
    Object error,
    StackTrace stackTrace,
  ) {
    super.onError(
      cubit,
      error,
      stackTrace,
    );
    print('onError $error');
  }
}
