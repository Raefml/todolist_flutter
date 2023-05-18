


import 'package:fa/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fa/screens/signin_screen.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';
class SO extends StatelessWidget {





 

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: <Widget>[dashBg, content, ],
      ),

    );
  }

  get dashBg => Column(
    children: <Widget>[
      Expanded(
        child: Container(color: Colors.blue),
        flex: 2,
      ),
      Expanded(
        child: Container(color: Colors.transparent),
        flex: 5,
      ),
    ],
  );

  get content => Container(
    child: Column(
      children: <Widget>[
        header,
        grid,
      ],
    ),
  );

  get header => ListTile(
    contentPadding: EdgeInsets.only(left: 20, right: 20, top: 180),
    title: Text(
      'welcome',
      style: TextStyle(color: Colors.white),
    ),
    subtitle: Text(
      '10 items',
      style: TextStyle(color: Colors.blue),
    ),
    trailing: CircleAvatar(),
  );

  get grid => Expanded(
    child: Container(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: GridView.count(
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        crossAxisCount: 2,
        childAspectRatio: .90,

        children: <Widget>[
          InkWell(
            onTap: () {


            },


            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.asset('assets/images/logo1.png'),
                    Text('Card 1')],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {

            },
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.asset('assets/images/logo1.png'),
                    Text('Card 2')],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {

            },
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.asset('assets/images/logo1.png'),
                    Text('Card 3')],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {

            },
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.asset('assets/images/logo1.png'),
                    Text('Card 4')],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );}