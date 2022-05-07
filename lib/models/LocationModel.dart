class LocationModel {
  String? locationId;
  String location;
  double latitude;
  double longitude;
  String? postalCode;
  String? title;
  String? receipentName;
  bool savedAddress;
  String? houseNo;
  String? street;
  String? receipentNumber;
  int addressType;
  String? addressTypeName;

  LocationModel(
      {required this.latitude,
      this.savedAddress = false,
      this.houseNo,
      this.receipentName,
      this.receipentNumber,
      this.street,
      this.title,
      this.postalCode,
      this.addressType = 0,
      this.addressTypeName = "home",
      this.locationId,
      required this.location,
      required this.longitude});

  LocationModel.fromJson(json)
      : this(
            locationId: json.id as String,
            postalCode: json["postalCode"] as String,
            title: json["title"] as String,
            location: json["location"] as String,
            latitude: json["latitude"] as double,
            longitude: json["longitude"] as double,
            savedAddress: json["savedAddress"] as bool,
            houseNo: json["houseNo"] as String,
            receipentName: json["receipentName"] as String,
            receipentNumber: json["receipentNumber"] as String,
            street: json["street"] as String,
            addressTypeName: json["addressTypeName"] as String,
            addressType: json["addressType"] as int);

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'location': location,
      'longitude': longitude,
      'postalCode': postalCode,
      'title': title,
      'savedAddress': savedAddress,
      'houseNo': houseNo,
      'receipentName': receipentName,
      'receipentNumber': receipentNumber,
      'street': street,
      'addressType': addressType,
      'addressTypeName': addressTypeName
    };
  }
}
