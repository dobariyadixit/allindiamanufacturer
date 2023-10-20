class GetUserUploadPostModel {
  bool? status;
  String? message;
  int? currentPage;
  int? count;
  int? perPage;
  List<GetUserUploadPostModelData>? data;

  GetUserUploadPostModel(
      {this.status,
        this.message,
        this.currentPage,
        this.count,
        this.perPage,
        this.data});

  GetUserUploadPostModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    currentPage = json['current_page'];
    count = json['count'];
    perPage = json['per_page'];
    if (json['data'] != null) {
      data = <GetUserUploadPostModelData>[];
      json['data'].forEach((v) {
        data!.add(new GetUserUploadPostModelData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['current_page'] = this.currentPage;
    data['count'] = this.count;
    data['per_page'] = this.perPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetUserUploadPostModelData {
  int? id;
  int? userId;
  String? type;
  String? description;
  String? image;
  String? userName;
  String? userImage;
  String? time;

  GetUserUploadPostModelData(
      {this.id,
        this.userId,
        this.type,
        this.description,
        this.image,
        this.userName,
        this.userImage,
        this.time});

  GetUserUploadPostModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    type = json['type'];
    description = json['description'];
    image = json['image'];
    userName = json['user_name'];
    userImage = json['user_image'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['type'] = this.type;
    data['description'] = this.description;
    data['image'] = this.image;
    data['user_name'] = this.userName;
    data['user_image'] = this.userImage;
    data['time'] = this.time;
    return data;
  }
}
