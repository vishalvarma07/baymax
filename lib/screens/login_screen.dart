import 'package:flutter/material.dart';
import 'package:telehealth/const.dart';
import 'package:telehealth/services/ui_services.dart';
import 'package:telehealth/widgets_composite/login_card_content.dart';
import 'package:telehealth/widgets_composite/signup_card_content.dart';
import '../enums.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  LoginCardPage _currentPage=LoginCardPage.login;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: LayoutBuilder(
        builder: (context,constraints) {
          return Center(
            child: AnimatedSize(
              duration: const Duration(milliseconds: 250),
              child: Card(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: isMobileDevice(constraints: constraints)?constraints.maxWidth*0.8:constraints.maxWidth*0.35
                  ),
                  child: Builder(
                    builder: (context) {
                      if(_currentPage==LoginCardPage.login){
                        return LoginCardContent(onSignupButtonPress: (){
                            setState(() {
                              _currentPage=LoginCardPage.signup;
                            });
                          },
                        );
                      }
                      return SignupCardContent(onBackButtonPress: (){
                        setState(() {
                          _currentPage=LoginCardPage.login;
                        });
                      },);
                    }
                  ),
                ),
              ),
            ),
          );
        }
      )
    );
  }
}
