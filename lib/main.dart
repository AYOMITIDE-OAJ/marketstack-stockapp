import 'package:flutter/material.dart';
import 'package:stock_app/stock/cubit/stock_observer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'App/appentry.dart';
import 'dependencyinjection/di.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  //init getit
  DiContainer();

  Bloc.observer = StockObserverBloc();
  runApp(const MyApp());
}




