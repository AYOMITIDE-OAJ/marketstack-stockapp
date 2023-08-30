import 'package:marketstackapi/marketstackapi.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/stock/cubit/stock_cubit.dart';
import 'package:stock_app/stock/views/stock_screen.dart';
import 'package:stock_app/dependencyinjection/di.dart';
import 'package:flutter/cupertino.dart';


class StockPage extends StatelessWidget {
  const StockPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => StockCubit(DiContainer.getIt.get<StockRepository>()), child: const StockView(),);
  }
}
