class GetFavoritePostModel {
  bool? status;
  String? message;
  List<GetFavoritePostModelData>? data;

  GetFavoritePostModel({this.status, this.message, this.data});

  GetFavoritePostModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetFavoritePostModelData>[];
      json['data'].forEach((v) {
        data!.add(new GetFavoritePostModelData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetFavoritePostModelData {
  int? id;
  int? userId;
  String? title;
  String? description;
  String? type;
  String? image;
  String? pdf;
  Null? createdAt;
  String? updatedAt;

  GetFavoritePostModelData(
      {this.id,
        this.userId,
        this.title,
        this.description,
        this.type,
        this.image,
        this.pdf,
        this.createdAt,
        this.updatedAt});

  GetFavoritePostModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    description = json['description'];
    type = json['type'];
    image = json['image'];
    pdf = json['pdf'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['type'] = this.type;
    data['image'] = this.image;
    data['pdf'] = this.pdf;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
