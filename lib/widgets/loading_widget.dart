import 'package:stock_app/widgets/typography.dart';
import 'package:stock_app/widgets/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),

          const Padding(padding: EdgeInsets.only(top: 7.0)),

          textSmall("Loading Stocks", StockColors.A181212)
        ],
      ),
    );
  }
}