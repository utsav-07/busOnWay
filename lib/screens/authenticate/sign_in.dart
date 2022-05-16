import 'package:bus_on_the_way/Constants/Constants.dart';
import 'package:bus_on_the_way/CustomComponents/InputFields.dart';
import 'package:bus_on_the_way/main.dart';
import 'package:bus_on_the_way/screens/driverHome/driverWrapper.dart';
import 'package:bus_on_the_way/screens/home/wrapper.dart';
import 'package:bus_on_the_way/screens/startScreen/startScreen.dart';
import 'package:bus_on_the_way/services/auth.dart';
import 'package:bus_on_the_way/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../shared/loading.dart';

class SignIn extends StatefulWidget {
  _SignInState createState() => _SignInState();

  final Function toogleView;
  final String? text;
  SignIn({ required this.toogleView , this.text });
}

class _SignInState extends State<SignIn> with TickerProviderStateMixin {
  late Animation<double> animation ,delayedAnimation;
  late AnimationController animationController , animContrroller;

  final _controller ={
    'email' : TextEditingController(),
    'password' : TextEditingController()
  };

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 750));

    animContrroller = AnimationController(vsync: this , duration: Duration(seconds: 2));

    delayedAnimation = Tween<double>(begin: 1.0 , end : 0.0).animate(CurvedAnimation(parent: animContrroller, curve: Interval(0.5 , 1.0 , curve: Curves.fastOutSlowIn)));

    animation = Tween<double>(begin: 0, end: 600).animate(animationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animationController.reverse();
        }
      });

    animationController.forward();
    animContrroller.forward();
  }

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  //text field state
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        floatingActionButton: animationController.isDismissed ?  FloatingActionButton(
          child: Icon(FontAwesomeIcons.backwardStep),
          backgroundColor: Colors.blue,
          onPressed: () {
            Navigator.pop(context);
          },
        ) : Container(),
        // appBar: AppBar(
        //   backgroundColor: Colors.purple,
        //   elevation: 0.0,
        //   title: Text('Sign in to Bus on the Way'),
        //   actions: <Widget>[
        //     TextButton.icon(
        //       style: TextButton.styleFrom(
        //         textStyle: TextStyle(color: Colors.brown[500]),
        //         backgroundColor: Colors.purple,
        //       ),
        //       onPressed: () => {widget.toogleView()},
        //       icon: Icon(
        //         Icons.person,
        //       ),
        //       label: Text(
        //         'Register',
        //       ),
        //     ),
        //   ],
        // ),
        body: Stack(

          children: [

            AnimatedBuilder(
              animation: animContrroller,
              builder: (context , child) {
                return Transform(
                  transform: Matrix4.translationValues(delayedAnimation.value * MediaQuery.of(context).size.width, 0.0, 0.0),
                  child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 50.0),
                      /*child: ElevatedButton(
                    child: Text('Sign in Anon'),
                    onPressed: () async {
                      dynamic result = await _auth.signInAnon();
                      if (result == null) {
                        print('Error while Signing in!');
                      } else {
                        print('Signed in!');
                        print('Anon User id: ' + result.uid);
                      }
                    })),
    );
    */
                      key: _formKey, //state of our form for form validation
                      child: Form(
                        child: Column(
                          children: <Widget>[
                            const SizedBox(
                              height: 20.0,
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.08,
                              ),
                              child: const Text(
                                'Log In',
                                style: TextStyle(
                                    fontSize: 40.0,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5),
                              ),
                            ),
                            KDivider,
                            InputFields(
                              icon: Icon(FontAwesomeIcons.user, color: Color(
                                  0xffC7C7C7)),
                              text: 'user id',
                              hintText: 'Enter user id',
                              controller: _controller['email'],
                            ),
                            // TextFormField(
                            //     decoration: textInputDecoration.copyWith(
                            //         hintText: 'Email or Username'),
                            //     onChanged: (val) {
                            //       setState(() {
                            //         email = val;
                            //       });
                            //     }
                            //     ), //TextFormField
                            const SizedBox(
                              height: 20.0,
                            ),

                            InputFields(
                              icon: Icon(FontAwesomeIcons.lock, color: Color(
                                  0xffC7C7C7)),
                              text: 'Password',
                              hintText: 'Password',
                              isobscure: true,
                              controller: _controller['password'],
                            ),
                            // TextFormField(
                            //     decoration:
                            //         textInputDecoration.copyWith(hintText: 'Password'),
                            //     obscureText: true,
                            //     onChanged: (val) {
                            //       setState(() {
                            //         password = val;
                            //       });
                            //     }),
                            const SizedBox(height: 20.0),
                            ElevatedButton(
                                child: const Text('Sign in'),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.teal,
                                  onPrimary: Colors.white,
                                  shadowColor: Colors.blueAccent,
                                  elevation: 5,
                                ),
                                onPressed: () async {
                                  if ((_formKey.currentState?.validate()) ==
                                      null) {
                                    setState(() {
                                      loading = true;
                                    });
                                    print(this._controller['email']!.text);
                                    print(this._controller['password']!.text);
                                    dynamic result = await _auth
                                        .signInWithEmailAndPassword(
                                        this._controller['email']!.text,
                                        this._controller['password']!.text);
                                    if (result == null) {
                                      setState(() {
                                        error =
                                        'Could not sign in with those credentials! ';
                                        loading = false;
                                      });
                                    }
                                    // else if(result != null && widget.text == 'driver'){
                                    //   Navigator.push(
                                    //       context,
                                    //       MaterialPageRoute(
                                    //           builder: (context) => DriverWrapper()));
                                    // }
                                  }
                                }),


                              Container(

                                child: widget.text != 'driver' ?  Column(
                                  children: [
                                    const Text('Does not have account?'),
                                    TextButton(
                                      child: const Text(
                                        'Register',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      onPressed: () {
                                        {widget.toogleView();}
                                      },
                                    ),
                                  ],
                                ) : Container(),
                              ),




                            SizedBox(height: 20.0),
                            Text(error,
                                style: TextStyle(color: Colors.red[500],
                                    fontSize: 15.0)),
                          ],
                        ),
                      )),
                );

              }
            ),

            Positioned(
              bottom: 0,
              child: Container(
                color: Colors.blue,
                width : MediaQuery.of(context).size.width,
                height: animation.value,
              ),
            ),

          ]
        ));
  }

  @override
  void dispose() {

    //_controller.dispose();
    animationController.dispose();
    animContrroller.dispose(); super.dispose();

  }
}
