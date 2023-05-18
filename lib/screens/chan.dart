import 'package:flutter/material.dart';

import 'home_screen.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Navigation Basics',
    home: FirstRoute(),
  ));
}

class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Image.asset('assets/images/logo1.png'),

      ),
      body: Center(

          child: Container(

            padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: GridView.count(
              crossAxisSpacing: 16,
              mainAxisSpacing: 36,
              crossAxisCount: 2,
              childAspectRatio: .90,

              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeScreen()
                        )
                    );

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
                          Image.asset('assets/images/ll.png'),
                          Text('lung cancer')],

                      ),
                    ),
                  ),

                ),
                InkWell(

                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeScreen()
                        )
                    );

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
                          Image.asset('assets/images/ss.png'),
                          Text('skin cancer')],
                      ),
                    ),





                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeScreen()
                        )
                    );

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
                          Image.asset('assets/images/cc.png'),
                          Text('colon cancer')],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeScreen()
                        )
                    );

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
                          Image.asset('assets/images/bb.png'),
                          Text('breast cancer')],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),


      ),

    );

  }



}

