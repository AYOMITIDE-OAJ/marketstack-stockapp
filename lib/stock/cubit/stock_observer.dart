import 'dart:developer';

import 'package:bloc/bloc.dart';


class StockObserverBloc extends BlocObserver {
  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
  }

  @override
  void onTransition(
      Bloc<dynamic, dynamic> bloc,
      Transition<dynamic, dynamic> transition,
      ) {
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
  }
}