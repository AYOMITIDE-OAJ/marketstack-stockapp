
import 'dart:io';
import 'package:stock_app/stock/cubit/stock_cubit.dart';
import 'package:stock_app/widgets/colors.dart';
import 'package:stock_app/widgets/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:marketstackapi/marketstackapi.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../widgets/no_network_widget.dart';
import '../../widgets/typography.dart';
import '../viewmodel/stock_viewmodel.dart';
import '../../widgets/loader_custom.dart';

class StockView extends StatefulWidget {
  const StockView({Key? key}) : super(key: key);

  @override
  State<StockView> createState() => _StockViewState();
}

class _StockViewState extends State<StockView> {
  bool _isSearchEnabled = false;
  bool _isConnected = false;
  final _searchQuery = TextEditingController();
  int _currentIndex = 0;
  bool isTyping = false;
  String period = 'Today';
  String date = '';
  List<Stock> stocks = [];

  @override
  void initState() {
    _getCurrentDate();

    Future.delayed(const Duration(), () async {
      if(await _checkForNetwork()){
        context.read<StockCubit>().getStockData();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !_isSearchEnabled ? Padding(
          padding: const EdgeInsets.all(16.0),
          child: textHeading5("MarketStack Top 10 Stocks", StockColors.white),
        ) : Container(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          decoration: BoxDecoration(
              color: StockColors.white,
              borderRadius: BorderRadius.circular(12.0)
          ),

          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(Icons.search, color: Colors.blue,),

              const Padding(padding: EdgeInsets.all(6.0)),

              Expanded(child: TextField(
                controller: _searchQuery,
                style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    decoration: TextDecoration.none,
                    color: StockColors.A181212
                ),
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter symbol"
                ),

                onChanged: (text){
                  if(stocks.isNotEmpty){
                    context.read<StockCubit>().searchStock(stocks, text);
                  }

                  setState(() {
                    if(text.isEmpty){
                      isTyping = false;
                    } else {
                      isTyping = true;
                    }
                  });
                },
              )
              ),

              isTyping ?  InkWell(
                onTap: (){
                  _searchQuery.text = '';
                  setState(() {
                    isTyping = false;
                  });
                },

                child: const Icon(
                  Icons.close,
                  color: Colors.blue,
                ),
              )
                  : Container(),
            ],
          ),
        ),
        centerTitle: false,
      ),
      body: SmartRefresher(
        enablePullUp: true,
        header: customLoadingHeader(),
        onRefresh: _onRefresh,
        controller: _refreshController,
        child: Container(
          color: StockColors.background,
          padding: const EdgeInsets.all(16),
          child: BlocConsumer<StockCubit, StockState>(
            listener: (context, state){
              if(state.status.isSuccess){
              }
            },

            builder: (context, state) {
              return _isConnected ? _viewController(state) : const NoNetworkWidget();
            },
          ),
        ),
      ),

      bottomNavigationBar: _buildBottomBar(),
    );
  }

  final _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async {
    if(await _checkForNetwork()){
      context.read<StockCubit>().getStockData();
    }
    _refreshController.refreshCompleted();
  }

  Widget _viewController(StockState state){
    switch(state.status){
      case StockStatus.initial:
        return const Center(child: Text("State Initial"));
      case StockStatus.loading:
        return const LoadingWidget();
      case StockStatus.success:
        return  _displayAllStocks(state.stock!);
      case StockStatus.failure:
        return Center(child: textSemiBold("Failed to fetch stocks", StockColors.A181212));
    }
  }

  Widget _displayAllStocks(List<Stock> stocks){
    this.stocks = stocks;
    return CustomScrollView(
      slivers: [
        _isSearchEnabled
            ?  SliverList(delegate: SliverChildListDelegate([]))
            : SliverList(delegate: SliverChildListDelegate([
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        textMiniTextRegular(date, StockColors.A181212),
                      ],
                    ),
                  )),
              const Padding(padding: EdgeInsets.only(right: 16.0)),
              Expanded(
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.white),
                    child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          hint: textMiniTextRegular(period, StockColors.A181212),
                          items: <String>[
                            'Today',
                            'Last 7 days',
                            'A month',
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              period = value!;
                              switch (value){
                                case 'Today':
                                  _getCurrentDate();
                                  break;
                                case 'Last 7 days':
                                  _getDateWithRange(7);
                                  break;
                                case 'A month':
                                  _getDateWithRange(30);
                                  break;
                              }
                            });
                          },
                        )
                    ),
                  )
              ),
            ],
          ),

          const Padding(padding: EdgeInsets.all(8.0))
        ])),
        SliverList(
            delegate: SliverChildBuilderDelegate(
                    (context, index) => StockModel(stock: stocks[index],),
                  childCount: stocks.length))
      ],
    );
  }

  Widget _buildBottomBar(){
    return  BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Stocks",
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: "Search",
        ),
      ],
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
          if(index == 1){
            _isSearchEnabled = true;
          } else {
            context.read<StockCubit>().getStockData();
            _isSearchEnabled = false;
          }
        });
      },
    );
  }

  List<DateTime> getDaysInBetween(DateTime startDate, DateTime endDate) {
    List<DateTime> days = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      days.add(startDate.add(Duration(days: i)));
    }
    return days;
  }

  _getCurrentDate() async {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    setState(() {
      date = formatter.format(now);
    });

    if(await _checkForNetwork()){
      context
          .read<StockCubit>()
          .getStockData(dateFrom: date, dateTo: date);
    }
  }

  _getDateWithRange(int day) async {
    var now = DateTime.now();
    var date = DateTime(now.year, now.month, -day);
    var formatter = DateFormat('yyyy-MM-dd');
    setState(() {
      this.date = formatter.format(date);
    });

    if(await _checkForNetwork()){
      context
          .read<StockCubit>()
          .getStockData(dateFrom: formatter.format(now), dateTo: this.date);
    }
  }

  Future<bool> _checkForNetwork() async{
    try {
      final result = await InternetAddress.lookup('www.github.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          _isConnected = true;
        });
        return true;
      }
    } on SocketException catch (e) {
      print(e.message);
      setState(() {
        _isConnected = false;
      });
    }

    return false;
  }
}
