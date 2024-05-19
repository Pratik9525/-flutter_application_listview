import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'product_grid_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isInvalidUsername = false;
  bool _isInvalidPassword = false;

  void _validateUsername(String value) {
    setState(() {
      _isInvalidUsername = !RegExp(r'^[a-z0-9@.]*$').hasMatch(value);
    });
  }

  void _validatePassword(String value) {
    setState(() {
      _isInvalidPassword = !RegExp(
              r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+{}|:"<>?]).{8,}$')
          .hasMatch(value);
    });
  }

  void _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _login() {
    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Username and password are required."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    } else {
      // Implement your login logic here
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProductGridScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("CentraLogic"),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.4, // 40% width
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 0,
                blurRadius: 5,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 200,
                height: 100,
                child: Image.asset(
                  'assets/images/friendship.png', // Replace with your logo image
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: _usernameController,
                  onChanged: _validateUsername,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                    hintText: 'Enter valid email id as abc@gmail.com',
                    errorText: _isInvalidUsername ? 'Invalid input' : null,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextField(
                  controller: _passwordController,
                  onChanged: _validatePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password',
                    errorText: _isInvalidPassword ? 'Invalid input' : null,
                  ),
                ),
              ),
              SizedBox(
                height: 65,
                width: 360,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: ElevatedButton(
                      child: Text(
                        'Log in',
                        style: TextStyle(
                            color: Color.fromARGB(208, 4, 4, 4), fontSize: 20),
                      ),
                      onPressed: _login,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Or Sign Up using"),
                    SizedBox(width: 10),
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.facebook,
                          color: const Color.fromARGB(255, 6, 136, 241)),
                      onPressed: () {
                        _launchUrl('https://www.facebook.com/');
                      },
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.google,
                          color: const Color.fromARGB(255, 6, 136, 241)),
                      onPressed: () {
                        _launchUrl('https://www.google.com/');
                      },
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.twitter,
                          color: const Color.fromARGB(255, 6, 136, 241)),
                      onPressed: () {
                        _launchUrl('https://twitter.com/');
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Have not an account yet?"),
                    SizedBox(width: 5),
                    TextButton(
                      onPressed: () {
                        // Implement sign-up navigation logic here
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
