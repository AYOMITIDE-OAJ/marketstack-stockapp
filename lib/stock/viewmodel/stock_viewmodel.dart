import 'package:flutter/cupertino.dart';
import '../../widgets/colors.dart';
import '../../widgets/typography.dart';
import 'package:marketstackapi/marketstackapi.dart';



class StockModel extends StatelessWidget {
  StockModel({Key? key, required this.stock}) : super(key: key);
  final Stock stock;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0, bottom: 20.0),
      margin: const EdgeInsets.only(bottom: 8.0),
      decoration: BoxDecoration(
        color: StockColors.white,
        borderRadius: BorderRadius.circular(12.5),
      ),

      child: Row(
        children: [
          textSemiBold(stock.symbol ?? '', StockColors.A181212),

          const Padding(padding: EdgeInsets.only(left: 8.0)),

          textMiniTextRegular(stock.name ?? '', StockColors.A181212),

          const Spacer(),

          textSemiBold(stock.open.toString() ?? '', StockColors.A181212),

          const Padding(padding: EdgeInsets.only(left: 8.0)),

          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: StockColors.green,
                borderRadius: BorderRadius.circular(8.0)
            ),

            child: textSmall("+ ${(stock.high! - stock.low!).toStringAsPrecision(2)}" ?? '', StockColors.white),
          )
        ],
      ),
    );
  }
}
