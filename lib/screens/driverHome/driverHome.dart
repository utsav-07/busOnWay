import 'package:bus_on_the_way/Constants/Constants.dart';
import 'package:bus_on_the_way/services/auth.dart';
import 'package:flutter/material.dart';
import '../../shared/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DriverHome extends StatefulWidget {
  @override
  State<DriverHome> createState() => _DriverHomeState();
}

class _DriverHomeState extends State<DriverHome> with TickerProviderStateMixin {

  late Animation<double> animation ,delayedAnimation , muchDelayedAnimation;
  late AnimationController animationController , animContrroller;
  final AuthService _auth = AuthService();


  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    animContrroller = AnimationController(vsync: this , duration: Duration(seconds: 2));

    delayedAnimation = Tween<double>(begin: 1 , end : 0).animate(CurvedAnimation(parent: animationController, curve: Interval(0.5 , 1, curve: Curves.fastOutSlowIn)));
    muchDelayedAnimation = Tween<double>(begin: 1.0, end : 0).animate(CurvedAnimation(parent: animContrroller, curve: Interval(0.7 , 1 , curve: Curves.fastOutSlowIn)));

    animation = Tween<double>(begin: 0, end: 600).animate(CurvedAnimation(parent: animContrroller, curve: Interval(0.5 ,1 , curve: Curves.fastOutSlowIn)))
      ..addListener(() {
        setState(() {});
      });

    animationController.forward();
    animContrroller.forward();
  }

  @override
  Widget build(BuildContext context) {
    print(animation.value);
    return Scaffold(


      bottomNavigationBar: BottomAppBar(
        child: Container(
          color: Colors.black12,
          child: Row(
            children: [
              Spacer(),
              IconButton(icon: Icon(FontAwesomeIcons.idBadge), onPressed: () {}),
              Spacer(),
              IconButton(icon: Icon(FontAwesomeIcons.rightFromBracket), onPressed: () async {
                await _auth.signOut();
              }),
              Spacer(),


            ],
          ),
        ),
      ),


      floatingActionButton:
      FloatingActionButton(child: Icon(FontAwesomeIcons.bus), onPressed: () {}),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      body: Stack(
        children: [


          Align(
            alignment: Alignment.topRight,
            child: AnimatedBuilder(
              animation: animationController,
              builder: (context , child) {
                return Transform(
                  transform: Matrix4.translationValues(delayedAnimation.value * MediaQuery.of(context).size.width, 0.0, 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20) , bottomRight: Radius.circular(20) ),
                      color: Colors.blue
                    ),

                    height: animation.value,
                    width: MediaQuery.of(context).size.width,
                    child: AnimatedBuilder(
                        animation: animContrroller,
                        builder: (context , child) {
                          return Transform(
                            transform: Matrix4.translationValues(muchDelayedAnimation.value * MediaQuery.of(context).size.width, 0.0, 0.0),
                            child: Container(
                              margin: EdgeInsets.only(top: 50),
                              child: Container(
                                margin: EdgeInsets.all(10),


                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Container(

                                        child: const Text(
                                          'Driver Page',
                                          style: TextStyle(
                                              fontSize: 40.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 0.5),
                                        ),
                                      ),
                                      KDivider,

                                      Card(

                                        child: Column(
                                          children: [

                                            Container(
                                              margin: EdgeInsets.all(20),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    color: Colors.black,
                                                    height: 40,
                                                    width: 40,
                                                  ),
                                                  Container(
                                                    child: Icon(FontAwesomeIcons.xmark),
                                                  )
                                                ],
                                              ),
                                            ),
                                            ButtonBar(
                                              alignment: MainAxisAlignment.start,
                                              children: [
                                                Text('Longitude'),
                                                Text('Latitude'),
                                                FlatButton(
                                                  textColor: const Color(0xFF6200EE),
                                                  onPressed: () {
                                                    // Perform some action
                                                  },
                                                  child: const Text('Enable Live Location'),
                                                ),
                                                FlatButton(
                                                  textColor: const Color(0xFF6200EE),
                                                  onPressed: () {
                                                    // Perform some action
                                                  },
                                                  child: const Text('Stop Live Location'),
                                                ),
                                              ],
                                            ),

                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                    ),
                  ),
                );

              }
            ),
          ),


        ],
      ),
      // appBar: AppBar(
      //   title: const Text('Welcome to Bus on the Way!'),
      //   backgroundColor: Colors.pink,
      //   elevation: 10.0,
      //   actions: <Widget>[
      //
      //
      //   ],
      // ),
    );
  }
  @override
  void dispose() {
    super.dispose();
    //_controller.dispose();
    animationController.dispose();
    animContrroller.dispose();

  }
}

class Button extends StatelessWidget {
  const Button({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                child: Text("driver  location",
                  style: TextStyle(color: Colors.black, fontSize: 32),
                ),
              ),
              Container(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.5),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,

                        ),
                      )
                    ],
                  )
              )
            ],
          ),
        )
    );
  }

}