import 'package:ecommerce/Authentication/otp.dart';
import 'package:ecommerce/documentation/privacy.dart';
import 'package:ecommerce/documentation/terms.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final FocusNode _phoneNumberFocus = FocusNode();

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _phoneNumberFocus.dispose();
    super.dispose();
  }

  void _handleTap() {
    // Unfocus the text field to dismiss the keyboard
    _phoneNumberFocus.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _handleTap();
      },
      child: Scaffold(
        backgroundColor: Colors.blueAccent,
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/flipkart-icon.png",
                height: 20,
                scale: 1,
              ),
              const Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  "Flipkart",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Login For The Best Expirience",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Montserrat",
                    fontSize: 30,
                    fontWeight: FontWeight.w900),
              ),
              SizedBox(height: 20),
              Text(
                "Enter Your Phone Number To Continue",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Montserrat",
                    fontSize: 15,
                    fontWeight: FontWeight.w900),
              ),
              SizedBox(height: 20),
              Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 50,
                          height: 50,
                          child: Center(
                            child: Text("+91"),
                          ),
                        ),
                      ),
                      Container(
                          width: 280,
                          child: TextFormField(
                            focusNode: _phoneNumberFocus,
                            controller: _phoneNumberController,
                            style: TextStyle(
                              fontWeight: FontWeight.bold, //letterSpacing: 5
                            ),
                            cursorColor: Colors.deepOrangeAccent,
                            maxLength: 10,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              counterText: "",
                              border: InputBorder.none,
                              hintText: "Phone Number",
                            ),
                          )),
                    ],
                  )),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.topRight,
                child: Text("Use Email-ID",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.orangeAccent)),
              ),
              SizedBox(height: 30),
              SizedBox(height: 30),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: "By Continuing, you agree to Flipkart's ",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Terms()),
                            );
                          },
                        text: 'Terms of Use ',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.orangeAccent)),
                    TextSpan(
                        text: 'and ',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Privacy()),
                            );
                          },
                        text: 'Privacy and Policy.',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.orangeAccent)),
                  ],
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  child: MaterialButton(
                      elevation: 0,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Otp(
                                  phoneNumber: _phoneNumberController.text)),
                        );
                      },
                      color: Colors.orange,
                      child: Text(
                        "Continue",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
