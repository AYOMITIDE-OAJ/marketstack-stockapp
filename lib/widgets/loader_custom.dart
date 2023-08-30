import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

CustomHeader customLoadingHeader(){
  return CustomHeader(builder: (context, refreshStatus) {
    return Container(
      width: 60,
      height: 60,
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Card(
            elevation: 8,
            shape: const CircleBorder(),
            color: Colors.white,
            child: Container(
              width: 45.0,
              height: 45.0,
              padding: const EdgeInsets.all(3.0),
              child:  const CircleAvatar(
                backgroundColor: Colors.blueAccent,
                child: Text(
                  "YA",
                  style: TextStyle(fontSize: 12.0, color: Colors.white),
                ),
              ),
            )),
      ),
    );
  });
}