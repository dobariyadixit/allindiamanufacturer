class OtpModel {
  String? token;
  OtpModelData? data;
  bool? status;
  String? message;

  OtpModel({this.token, this.data, this.status, this.message});

  OtpModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    data = json['data'] != null ? new OtpModelData.fromJson(json['data']) : null;
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}

class OtpModelData {
  int? id;
  String? name;
  String? image;
  String? mobile;
  String? createdAt;
  String? updatedAt;

  OtpModelData(
      {
        this.id,
        this.name,
        this.image,
        this.mobile,
        this.createdAt,
        this.updatedAt});

  OtpModelData.fromJson(Map<String, dynamic> json) {
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
}