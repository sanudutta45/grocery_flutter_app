mixin InputValidationMixin {
  bool isPhoneNumberValid(String phoneNumber) => phoneNumber.length == 10;
  bool isPinValid(int pinLength, String pinCode) => pinCode.length == pinLength;
  bool isPostalCodeValid(String code) => code.length == 5;
}
