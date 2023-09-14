import 'package:ecommerce/Authentication/otp.dart';
import 'package:ecommerce/documentation/privacy.dart';
import 'package:ecommerce/documentation/terms.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final FocusNode _phoneNumberFocus = FocusNode();
  bool _isLoading = false;
  bool _isRefreshing = false;
  bool _isInternetConnected = true;

  Future<void> _handleRefresh() async {
    bool isInternetConnected = await InternetConnectionChecker().hasConnection;

    if (!isInternetConnected) {
      // Handle no internet connectivity, show a message or take action
      // For example, you can show a snackbar or a dialog
      return;
    }

    if (!_isRefreshing) {
      setState(() {
        _isRefreshing = true;
      });

      // Perform refreshing tasks here

      // Simulate a delay for demonstration purposes
      await Future.delayed(Duration(seconds: 2));

      setState(() {
        // Update any necessary state here
        _isRefreshing = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    // Listen for connectivity changes
    InternetConnectionChecker().onStatusChange.listen((status) {
      setState(() {
        _isInternetConnected = status == InternetConnectionStatus.connected;
      });

      // If connectivity is restored, enable the button if it was previously disabled
      if (_isInternetConnected && _isLoading) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

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

  Country selectedCountry = Country(
    phoneCode: "91",
    countryCode: "IN",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "India",
    example: "India",
    displayName: "India",
    displayNameNoCountryCode: "IN",
    e164Key: "",
  );

  Future<void> signInWithPhoneNumber(String phoneNumber) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
          // authentication successful, do something
          setState(() {
            _isLoading = false; // Hide progress indicator
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          setState(() {
            _isLoading = false; // Hide progress indicator
          });
          // authentication failed, do something
        },
        codeSent: (String verificationId, int? resendToken) async {
          // code sent to phone number, save verificationId for later use
          String smsCode = ''; // get sms code from user
          PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId,
            smsCode: smsCode,
          );
          Get.to(() => OtpPage(), arguments: [verificationId]);
          await auth.signInWithCredential(credential);
          // authentication successful, do something
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            _isLoading = false; // Hide progress indicator when timeout occurs
          });
        },
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        e.message.toString(),
        "Failed",
        colorText: Colors.black54,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void _userLogin() {
    String mobile = _phoneNumberController.text;
    if (mobile == "") {
      Get.snackbar(
        "Please enter the mobile number!",
        "Login Failed",
        duration: Duration(milliseconds: 500),
        colorText: Colors.black54,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      setState(() {
        _isLoading = true; // Show progress indicator
      });

      // Proceed with phone number authentication
      signInWithPhoneNumber("+${selectedCountry.phoneCode}$mobile");
    }
  }

  @override
  Widget build(BuildContext context) {
    _phoneNumberController.selection = TextSelection.fromPosition(
        TextPosition(offset: _phoneNumberController.text.length));

    return GestureDetector(
      onTap: () {
        _handleTap();
      },
      child: Scaffold(
        backgroundColor: Colors.blueAccent,
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
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
          child: CustomScrollView(slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
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
                            child: GestureDetector(
                              onTap: () {
                                showCountryPicker(
                                    showWorldWide: false,
                                    showPhoneCode: true,
                                    context: context,
                                    countryListTheme:
                                        const CountryListThemeData(
                                      bottomSheetHeight: 550,
                                    ),
                                    onSelect: (value) {
                                      setState(() {
                                        selectedCountry = value;
                                      });
                                    });
                              },
                              child: Container(
                                width: 50,
                                height: 50,
                                child: Center(
                                  child: Text(
                                    "+ ${selectedCountry.phoneCode}",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight:
                                          FontWeight.bold, //letterSpacing: 5
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 200,
                            child: TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  _phoneNumberController.text = value;
                                });
                              },
                              focusNode: _phoneNumberFocus,
                              controller: _phoneNumberController,
                              style: TextStyle(
                                fontWeight: FontWeight.bold, //letterSpacing: 5
                              ),
                              cursorColor: Colors.deepOrangeAccent,
                              maxLength: 10,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                counterText: "",
                                border: InputBorder.none,
                                hintText: "Phone Number",
                              ),
                            ),
                          ),
                          if (_phoneNumberController.text.length > 9)
                            Container(
                              height: 30,
                              width: 30,
                              margin: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green,
                              ),
                              child: Icon(
                                Icons.done,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
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
                                  MaterialPageRoute(
                                      builder: (context) => Terms()),
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
                  // ElevatedButton(
                  //   onPressed: _isLoading ||
                  //           !_isInternetConnected // Disable button if no internet
                  //       ? null
                  //       : _userLogin,
                  //   child: _isLoading
                  //       ? CircularProgressIndicator(
                  //           valueColor: AlwaysStoppedAnimation(Colors.teal),
                  //         )
                  //       : Text(
                  //           _isInternetConnected
                  //               ? 'GET OTP'
                  //               : 'Check your network connection',
                  //           style: TextStyle(
                  //             color: Colors.black,
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //         ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      child: MaterialButton(
                          elevation: 0,
                          highlightColor: Colors.transparent,
                          onPressed: () {
                            _userLogin();
                          },
                          color: Colors.orange,
                          child: Text(
                            "Continue",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
