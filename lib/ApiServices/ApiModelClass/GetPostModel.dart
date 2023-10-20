
class GetPostModel {
  dynamic status;
  dynamic message;
  dynamic currentPage;
  dynamic count;
  dynamic perPage;
  List<GetPostModelData>? data;

  GetPostModel(
      {this.status,
        this.message,
        this.currentPage,
        this.count,
        this.perPage,
        this.data});

  GetPostModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    currentPage = json['current_page'];
    count = json['count'];
    perPage = json['per_page'];
    if (json['data'] != null) {
      data = <GetPostModelData>[];
      json['data'].forEach((v) {
        data!.add(new GetPostModelData.fromJson(v));
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

class GetPostModelData {
  dynamic id;
  dynamic userId;
  dynamic type;
  dynamic description;
  dynamic image;
  dynamic userName;
  dynamic userImage;
  dynamic time;
  dynamic isFavorite;
  dynamic businessName;

  GetPostModelData(
      {this.id,
        this.userId,
        this.type,
        this.description,
        this.image,
        this.userName,
        this.businessName,
        this.userImage,
        this.time,
        this.isFavorite,

      });

  GetPostModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    type = json['type'];
    description = json['description'];
    image = json['image'];
    userName = json['user_name'];
    userImage = json['user_image'];
    time = json['time'];
    isFavorite = json['is_favorite'];
    businessName = json['business_name'];
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
    data['is_favorite'] = this.isFavorite;
    data['business_name'] = this.businessName;
    return data;
  }
}
