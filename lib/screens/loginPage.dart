import 'package:flutter/material.dart';
import 'package:hospital_dbms/screens/homeScreen.dart';
import 'package:hospital_dbms/utils/AlertDialogs.dart';
import 'package:hospital_dbms/utils/Navigators.dart';

class LoginPage extends StatefulWidget {
  static const routeName = 'loginPage';
  LoginPage({this.title});

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      // backgroundColor: Colors.deepOrangeAccent,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: height * .35,
            ),
            Container(
              child: Text(
                'Delight Hospital',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    fontFamily: 'Avenir'),
              ),
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Email',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          fontFamily: 'Avenir'),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      cursorColor: Colors.deepOrangeAccent,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            color: Colors.black.withOpacity(0.15),
                            fontFamily: 'Avenir',
                            fontSize: 14,
                          ),
                          border: InputBorder.none,
                          fillColor: Color(0xfff3f3f4),
                          filled: true),
                      validator: (value) {
                        if (value.isEmpty || !value.contains('@')) {
                          return 'invalid email!';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Password',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          fontFamily: 'Avenir'),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      cursorColor: Colors.deepOrangeAccent,
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: '********',
                          hintStyle: TextStyle(
                            color: Colors.black26,
                            fontFamily: 'Avenir',
                            fontSize: 14,
                          ),
                          border: InputBorder.none,
                          fillColor: Color(0xfff3f3f4),
                          filled: true),
                      validator: (value) {
                        if (value.isEmpty || value.length < 6) {
                          return 'Password is too short!';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                if(_passwordController.text.isEmpty && _emailController.text.isEmpty ){
                  showErrorAlert(context, 'Incorrect Login Details', 'Please input your details');
                }else{
                navigatePush(context, HomeScreen());
              }
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(20),
                height: height * .07,
                color: Colors.deepOrangeAccent,
                child: Center(
                    child: Text(
                  'Login',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      fontFamily: 'Avenir'),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
