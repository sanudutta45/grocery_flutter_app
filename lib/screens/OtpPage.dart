import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery/constants/Dimensions.dart';
import 'package:grocery/constants/colors.dart';
import 'package:grocery/globalController/AuthController.dart';
import 'package:grocery/mixins/validationMixins.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({Key? key}) : super(key: key);

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> with InputValidationMixin {
  final _formKey = GlobalKey<FormState>();

  bool showSubmitButton = false;
  String pinCode = "";
  late Timer _timer;
  int _start = 60;
  final AuthController _authController = Get.find();

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _start = 60;
    _timer = new Timer.periodic(oneSec, (timer) {
      if (_start == 0)
        setState(() => timer.cancel());
      else
        setState(() => _start--);
    });
  }

  void _toggleSubmitButton(bool flag) {
    setState(() {
      showSubmitButton = flag;
    });
  }

  Future<void> listenForCode() async {
    await SmsAutoFill().listenForCode();
  }

  @override
  void initState() {
    super.initState();
    startTimer();
    listenForCode();
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/ranbow_bg.png"),
                fit: BoxFit.cover)),
      ),
      Scaffold(
        backgroundColor: Color(0xffFCFCFC).withOpacity(0),
        resizeToAvoidBottomInset: true,
        floatingActionButton: Visibility(
          visible: showSubmitButton,
          child: Container(
            width: Dimensions.height67,
            height: Dimensions.height67,
            child: Obx(() => RawMaterialButton(
                  fillColor:
                      _authController.otpVerifying ? Colors.grey : greenColor,
                  onPressed: () => _authController.otpVerifying
                      ? null
                      : _authController.verifyOtp(pinCode),
                  shape: CircleBorder(),
                  elevation: 0.0,
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                  ),
                )),
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xffFCFCFC).withOpacity(0),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded),
            color: darkBlackColor,
            iconSize: Dimensions.size20,
            onPressed: () => Get.back(),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(Dimensions.height20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Enter your 6-digit code",
                  style: TextStyle(
                      color: darkBlackColor,
                      fontSize: Dimensions.size26,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: Dimensions.height40,
                ),
                Text(
                  "Code",
                  style: TextStyle(
                      color: Color(0xff7C7C7C),
                      fontSize: Dimensions.size20,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                Form(
                    key: _formKey,
                    child: PinFieldAutoFill(
                      codeLength: 6,
                      autoFocus: true,
                      currentCode: pinCode,
                      decoration: UnderlineDecoration(
                        colorBuilder: FixedColorBuilder(darkBlackColor),
                        lineStrokeCap: StrokeCap.butt,
                        textStyle: TextStyle(
                            color: darkBlackColor, fontSize: Dimensions.size18),
                      ),
                      onCodeChanged: (value) {
                        setState(() {
                          pinCode = value!;
                        });
                        if (isPinValid(6, value!))
                          _toggleSubmitButton(true);
                        else
                          _toggleSubmitButton(false);
                      },
                    )),
                SizedBox(
                  height: Dimensions.height14,
                ),
                Row(
                  children: [
                    SizedBox(
                        width: Dimensions.height16,
                        height: Dimensions.height16,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.grey.withOpacity(0.3),
                          color: Colors.grey,
                          strokeWidth: Dimensions.height2,
                        )),
                    SizedBox(
                      width: Dimensions.width5,
                    ),
                    Text(
                      "Waiting for ... OTP",
                      style: TextStyle(
                          color: darkBlackColor.withOpacity(0.6),
                          fontSize: Dimensions.size16,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic),
                    ),
                    Expanded(child: Container()),
                    _start > 0
                        ? Text(
                            _start > 9 ? '00:$_start' : '00:0$_start',
                            style: TextStyle(
                                color: darkBlackColor,
                                fontSize: Dimensions.size16,
                                fontWeight: FontWeight.w600),
                          )
                        : InkWell(
                            child: Text(
                              "Resend",
                              style: TextStyle(
                                  color: greenColor,
                                  fontSize: Dimensions.size16,
                                  fontWeight: FontWeight.w600),
                            ),
                            onTap: () => startTimer(),
                          ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
