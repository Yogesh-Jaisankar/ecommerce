import 'package:ecommerce/Screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class OtpPage extends StatefulWidget {
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  bool _isVerified = false;
  bool _isButtonDisabled = false;
  String? otpCode;
  final String verificationId = Get.arguments[0];
  FirebaseAuth auth = FirebaseAuth.instance;
  bool _isSnackbarVisible = false;

  Future<bool> _onWillPop() async {
    return false; //<-- SEE HERE
  }

  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _secondController = TextEditingController();
  final TextEditingController _thirdController = TextEditingController();
  final TextEditingController _fourthController = TextEditingController();
  final TextEditingController _fifthController = TextEditingController();
  final TextEditingController _sixthController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Listen for changes in the otpCode variable
    otpCode = "";
    _listenForOtpChanges();
  }

  void _listenForOtpChanges() {
    final otpControllers = [
      _firstController,
      _secondController,
      _thirdController,
      _fourthController,
      _fifthController,
      _sixthController,
    ];

    for (final controller in otpControllers) {
      controller.addListener(() {
        String newOtp = "";
        for (final c in otpControllers) {
          newOtp += c.text;
        }
        setState(() {
          otpCode = newOtp;
        });

        // Verify OTP automatically when all characters are entered
        if (newOtp.length == 6) {
          verifyOtp(verificationId, newOtp); // Trigger automatic verification
        }
      });
    }
  }

  void verifyOtp(String verificationId, String userOtp) async {
    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: userOtp); // Provide the SMS code here
      User? user = (await auth.signInWithCredential(creds)).user;
      if (user != null) {
        setState(() {
          _isVerified = true;
          _isButtonDisabled = false;
          _isSnackbarVisible = false;
        });
        await Future.delayed(Duration(seconds: 2));
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (C) => Home()),
          (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isButtonDisabled = false;
      });
      Get.snackbar(
        e.message.toString(),
        "Failed",
        colorText: Colors.black54,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void dispose() {
    _firstController.dispose();
    _secondController.dispose();
    _thirdController.dispose();
    _fourthController.dispose();
    _fifthController.dispose();
    _sixthController.dispose();
    super.dispose();
  }

  void _manualVerify() {
    if (otpCode != null && otpCode!.length == 6) {
      if (!_isButtonDisabled) {
        setState(() {
          _isButtonDisabled = true;
        });
        verifyOtp(verificationId, otpCode!);
      } else {
        if (!_isSnackbarVisible) {
          _showWaitSnackbar();
        }
      }
    } else {
      // Show an error message if OTP is not complete
      Get.snackbar("Enter 6-Digit code", "Failed to verify",
          colorText: Colors.black,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white);
    }
  }

  void _showWaitSnackbar() {
    if (mounted) {
      Get.snackbar("Please Wait", "You must wait before trying again.",
          colorText: Colors.black,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white);
      _isSnackbarVisible = true;
      // Set a timer to hide the snackbar after a certain time (e.g., 5 seconds)
      Future.delayed(Duration(seconds: 5)).then((_) {
        if (mounted) {
          setState(() {
            _isSnackbarVisible = false; // Reset _isSnackbarVisible
          });
        }
      });
    }
  }

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.blueAccent,
        // backgroundColor: Color(0xff215D5F),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 100),
                Text(
                  "Verification Code",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Montserrat",
                      fontSize: 30,
                      fontWeight: FontWeight.w900),
                ),
                SizedBox(height: 30),
                Text(
                  "We have sent the verification code to",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 30),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: " ",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      TextSpan(
                          text: 'Change Phone Number ?',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.orangeAccent)),
                    ],
                  ),
                ),
                SizedBox(height: screenSize.height * 0.05),
                Center(
                  child: _isVerified
                      ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white))
                      : Pinput(
                          keyboardType: TextInputType.number,
                          length: 6,
                          showCursor: true,
                          defaultPinTheme: PinTheme(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.white),
                            ),
                            textStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                color: Colors.black),
                          ),
                          onCompleted: (value) {
                            setState(() {
                              otpCode = value;
                            });
                          },
                        ),
                ),
                SizedBox(height: screenSize.height * 0.03),
                Row(
                  children: [
                    Container(
                      height: 45,
                      width: 160,
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/resend.png",
                              height: 20,
                              scale: 1,
                            ),
                            const Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                "Resend",
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
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        _manualVerify();
                      },
                      child: Container(
                        height: 45,
                        width: 160,
                        decoration: BoxDecoration(
                          color: _isButtonDisabled
                              ? Colors.grey[300]
                              : Colors.green[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  "Confirm",
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              Image.asset(
                                "assets/images/confirm.png",
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenSize.height * 0.08),
                const Text(
                  "Didn't receive any code?",
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Resend new code",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
