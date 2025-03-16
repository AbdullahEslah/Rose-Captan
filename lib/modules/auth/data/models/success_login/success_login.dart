class SuccessLogin {
  bool? success;
  User? user;
  int? otp;
  String? message;

  SuccessLogin({this.success, this.user, this.otp, this.message});

  SuccessLogin.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    otp = json['otp'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['otp'] = this.otp;
    data['message'] = this.message;
    return data;
  }
}

class User {
  int? id;
  String? name;
  Null? email;
  Null? image;
  String? mobile;
  String? userType;
  Null? idImage;
  String? idNumber;
  Null? licenseImageUrl;
  String? status;
  Null? address;
  Null? country;
  int? otp;
  Null? drivingLicense;
  Null? bankAccount;
  Null? deviceToken;
  String? otpExpiresAt;
  Null? driverImage;
  Null? city;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
      this.name,
      this.email,
      this.image,
      this.mobile,
      this.userType,
      this.idImage,
      this.idNumber,
      this.licenseImageUrl,
      this.status,
      this.address,
      this.country,
      this.otp,
      this.drivingLicense,
      this.bankAccount,
      this.deviceToken,
      this.otpExpiresAt,
      this.driverImage,
      this.city,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
    mobile = json['mobile'];
    userType = json['user_type'];
    idImage = json['id_image'];
    idNumber = json['id_number'];
    licenseImageUrl = json['license_image_url'];
    status = json['status'];
    address = json['address'];
    country = json['country'];
    otp = json['otp'];
    drivingLicense = json['driving_license'];
    bankAccount = json['bank_account'];
    deviceToken = json['device_token'];
    otpExpiresAt = json['otp_expires_at'];
    driverImage = json['driver_image'];
    city = json['city'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['image'] = this.image;
    data['mobile'] = this.mobile;
    data['user_type'] = this.userType;
    data['id_image'] = this.idImage;
    data['id_number'] = this.idNumber;
    data['license_image_url'] = this.licenseImageUrl;
    data['status'] = this.status;
    data['address'] = this.address;
    data['country'] = this.country;
    data['otp'] = this.otp;
    data['driving_license'] = this.drivingLicense;
    data['bank_account'] = this.bankAccount;
    data['device_token'] = this.deviceToken;
    data['otp_expires_at'] = this.otpExpiresAt;
    data['driver_image'] = this.driverImage;
    data['city'] = this.city;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
