import 'package:bus_on_the_way/Constants/Constants.dart';
import 'package:bus_on_the_way/CustomComponents/ButtonContainer.dart';
import 'package:bus_on_the_way/screens/authenticate/sign_in.dart';
import 'package:bus_on_the_way/screens/driverHome/driverWrapper.dart';
import 'package:bus_on_the_way/screens/home/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//import 'package:get/get.dart';

class StartScreen extends StatefulWidget {
  StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen>
    with TickerProviderStateMixin {
  bool showSignIn = true;
  void toogleView() {
    setState(() => showSignIn = showSignIn);
  }

  late Animation<double> animation, delayedAnimation;
  late AnimationController animationController;
  late AnimationController animationControllerT;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )
      ..forward()
      ..repeat(reverse: true);

    animationControllerT =
        AnimationController(vsync: this, duration: Duration(seconds: 4));

    animation = Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationControllerT,
        curve: Interval(0.8, 1.0, curve: Curves.fastOutSlowIn)));
    delayedAnimation = Tween<double>(begin: -1.0, end: 0.0).animate(
        CurvedAnimation(
            parent: animationControllerT,
            curve: Interval(0.8, 1.0, curve: Curves.fastOutSlowIn)));
    animationControllerT.forward();
  }

  @override
  Widget build(BuildContext context) {
    double Height = MediaQuery.of(context).size.height;
    double Width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/bg4.png"), fit: BoxFit.cover),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: Height * 0.08,
                  ),
                  child: const Text(
                    'BUS ON THE WAY',
                    style: TextStyle(
                        fontSize: 40.0,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5),
                  ),
                ),

                // child: Container(
                //   margin: EdgeInsets.only(
                //     top: Height * 0.08,
                //   ),
                //   child: const Text(
                //     'BOWAY',
                //     style: TextStyle(
                //         fontSize: 40.0,
                //         color: Colors.black54,
                //         fontWeight: FontWeight.bold,
                //         letterSpacing: 0.5),
                //   ),
                // ),

                KDivider,

                Container(
                  height: Height * 0.3,
                  child: Center(
                    child: AnimatedBuilder(
                      animation: animationController,
                      builder: (context, child) {
                        return Container(
                          decoration: ShapeDecoration(
                            color: Colors.lightBlueAccent.withOpacity(0.5),
                            shape: CircleBorder(),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(
                                50.0 * animationController.value),
                            child: child,
                          ),
                        );
                      },
                      child: Container(
                        height: Height * 5,
                        width: Width * 0.3,
                        decoration: ShapeDecoration(
                          color: Colors.blueAccent,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          color: Colors.white,
                          icon: Icon(FontAwesomeIcons.locationDot, size: 40),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: Height * 0.09,
                ),
                // ButtonContainer(btnName: 'Student'),
                AnimatedBuilder(
                    animation: animationControllerT,
                    builder: (context, child) {
                      return Transform(
                        transform: Matrix4.translationValues(
                            delayedAnimation.value * Width, 0.0, 0.0),
                        child: (ButtonContainer(
                          btnName: 'DRIVER',
                          onpressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DriverWrapper(text : 'driver'))),
                        )),
                      );
                    }),
                AnimatedBuilder(
                    animation: animationControllerT,
                    builder: (context, child) {
                      return Transform(
                        transform: Matrix4.translationValues(
                            animation.value * Width, 0.0, 0.0),
                        child: (ButtonContainer(
                          btnName: 'STUDENT',
                          onpressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Wrapper())),
                        )),
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {

    animationController.dispose();
    animationControllerT.dispose();
    super.dispose();
  }
}
