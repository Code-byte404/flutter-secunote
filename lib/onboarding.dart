import 'package:flutter/material.dart';
import 'package:flutter_todolist/services/service_locator.dart';
import 'package:local_auth/local_auth.dart';

import 'home.dart';
import 'services/local_authentication_service.dart';
import 'util.dart';
import 'package:flutter_todolist/empty.dart';
import 'package:flutter/services.dart';

class Onboarding extends StatefulWidget {
  Onboarding({Key key}) : super(key: key);

  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final LocalAuthenticationService _localAuth = locator<LocalAuthenticationService>();
  final _auth = LocalAuthentication();
  bool isAuthenticated = false;

  Future<void> authenticate() async {
    try {
      isAuthenticated = await _auth.authenticateWithBiometrics(
        localizedReason: 'authenticate to access',
        stickyAuth: true,
      );
      if(isAuthenticated){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }
  @override
  void initState() {
    super.initState();

//    Navigator.pushReplacement(
//                      context,
//                      MaterialPageRoute(builder: (context) => Empty()),
//                    );

    authenticate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width / 1.2,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 8,
                child: Hero(
                  tag: 'Clipboard',
                  child: Image.asset('assets/images/Clipboard.png'),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: <Widget>[
                    Text(
                      'SecuNote',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: CustomColors.TextHeader),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Keep your note safe.',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: CustomColors.TextBody,
                          fontFamily: 'opensans'),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: RaisedButton(
                  onPressed: () {
                    // HERO-ANIMATION: https://github.com/flutter/flutter/issues/28041
                    // Navigator.of(context).pushReplacement(
                    //   PageRouteBuilder(
                    //     transitionDuration: Duration(seconds: 1),
                    //     pageBuilder: (_, __, ___) => Empty(),
                    //   ),
                    // );

                //    authenticate();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  },
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(0.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.4,
                    height: 60,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          CustomColors.GreenLight,
                          CustomColors.GreenDark,
                        ],
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: CustomColors.GreenShadow,
                          blurRadius: 15.0,
                          spreadRadius: 7.0,
                          offset: Offset(0.0, 0.0),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Center(
                      child: const Text(
                        '开始体验',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
