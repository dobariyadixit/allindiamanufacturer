/*class UserProfilePhotoModel {
  bool? status;
  String? message;
  UserProfilePhotoModelData? data;

  UserProfilePhotoModel({this.status, this.message, this.data});

  UserProfilePhotoModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new UserProfilePhotoModelData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class UserProfilePhotoModelData {
  int? id;
  String? name;
  String? image;
  String? mobile;
  String? createdAt;
  String? updatedAt;

  UserProfilePhotoModelData(
      {this.id,
        this.name,
        this.image,
        this.mobile,
        this.createdAt,
        this.updatedAt});

  UserProfilePhotoModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    mobile = json['mobile'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['mobile'] = this.mobile;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}*/

class UserProfilePhotoModel {
  dynamic status;
  dynamic message;
  UserProfilePhotoModelData? data;

  UserProfilePhotoModel({this.status, this.message, this.data});

  UserProfilePhotoModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new UserProfilePhotoModelData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class UserProfilePhotoModelData {
  dynamic id;
  dynamic firstName;
  dynamic name;
  dynamic lastName;
  dynamic image;
  dynamic mobile;
  dynamic dateOfBirth;
  dynamic gender;
  dynamic createdAt;
  dynamic updatedAt;

  UserProfilePhotoModelData(
      {this.id,
        this.firstName,
        this.name,
        this.lastName,
        this.image,
        this.mobile,
        this.dateOfBirth,
        this.gender,
        this.createdAt,
        this.updatedAt});

  UserProfilePhotoModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    name = json['name'];
    lastName = json['last_name'];
    image = json['image'];
    mobile = json['mobile'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['name'] = this.name;
    data['last_name'] = this.lastName;
    data['image'] = this.image;
    data['mobile'] = this.mobile;
    data['date_of_birth'] = this.dateOfBirth;
    data['gender'] = this.gender;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
