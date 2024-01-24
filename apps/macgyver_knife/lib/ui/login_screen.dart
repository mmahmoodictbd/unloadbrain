import 'package:flutter/material.dart';
import 'package:macgyver_knife/router.dart';

class LoginScreen extends StatefulWidget {
  final String title;

  LoginScreen({Key key, this.title}) : super(key: key);

  @override
  LoginScreenState createState() => new LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  String _username = "";
  String _password = "";

  TextStyle _style = TextStyle(fontFamily: 'Montserrat', fontSize: 15.0);
  Text _messageLabel = Text("");
  FocusNode _passwordFocusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    final logo = SizedBox(
      height: 130.0,
      child: Image.asset(
        "assets/img/chumbok_logo.png",
        fit: BoxFit.contain,
      ),
    );

    final emailField = TextField(
      keyboardType: TextInputType.emailAddress,
      obscureText: false,
      style: _style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email"),
      onChanged: (text) {
        _username = text;
      },
      onSubmitted: (String value) {
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      },
    );

    final passwordField = TextField(
      obscureText: true,
      style: _style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password"),
      onChanged: (text) {
        _password = text;
      },
      focusNode: _passwordFocusNode,
      onSubmitted: (String value) {
        login(context);
      },
    );

    final loginButton = Material(
      elevation: 2.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          login(context);
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: _style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
    );

    final widgetListWithLogo = <Widget>[
      logo,
      SizedBox(height: 20.0),
      emailField,
      SizedBox(height: 15.0),
      passwordField,
      SizedBox(
        height: 20.0,
      ),
      loginButton,
      forgotLabel,
      _messageLabel
    ];

    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(20.0),
              children: widgetListWithLogo,
            ),
          ),
        ),
      ),
    );
  }

  void login(BuildContext context) {
    if (_basicInputValidation()) {
      Navigator.pushNamed(context, Router.homeRoute);
    }
  }

  bool _basicInputValidation() {
    if (_username.trim().isEmpty || _password.trim().isEmpty) {
      setState(() {
        _messageLabel = Text(
          "Email and password can not be empty.",
          style: TextStyle(color: Colors.redAccent),
        );
      });
      return false;
    }
    return true;
  }
}
