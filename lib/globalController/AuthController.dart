import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grocery/globalController/CartController.dart';

class AuthController extends GetxController {
  final _user = Rx<User?>(null);
  final _isSending = false.obs;
  final _otpVerifying = false.obs;
  late String _verificationId;
  late int? resetToken;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _localStorage = GetStorage();

  User? get user => _user.value;
  bool get isSending => _isSending.value;
  bool get otpVerifying => _otpVerifying.value;

  @override
  void onReady() {
    _user.value = _auth.currentUser;
    _user.bindStream(_auth.userChanges());
    super.onReady();
  }

  phoneNumberAuth(String phoneNumber) async {
    _isSending.value = true;
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: "+91$phoneNumber",
          verificationCompleted: (PhoneAuthCredential credential) async {
            _otpVerifying.value = true;
            try {
              await _auth.signInWithCredential(credential);
              await Get.find<CartController>().addToCartFromDB();
              Get.close(3);
            } catch (e) {
              print("error otp verification $e");
            } finally {
              _otpVerifying.value = false;
            }
          },
          verificationFailed: (_) {},
          codeSent: _handleCodeSent,
          codeAutoRetrievalTimeout: (_) {});
    } catch (e) {
      print("phone number auth failed $e");
    }
  }

  _handleCodeSent(String verificationId, int? resentToken) {
    this._verificationId = verificationId;
    this.resetToken = resentToken;
    _isSending.value = false;
    Get.toNamed("/otp");
  }

  verifyOtp(String otp) async {
    _otpVerifying.value = true;
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: this._verificationId, smsCode: otp);

      await _auth.signInWithCredential(credential);
      await Get.find<CartController>().addToCartFromDB();
      Get.close(3);
    } catch (e) {
      print("error otp verification $e");
    } finally {
      _otpVerifying.value = false;
    }
  }

  signout() async {
    await _auth.signOut();
    Get.find<CartController>().removeAllItems();
    _localStorage.remove("cart_items");
  }
}
