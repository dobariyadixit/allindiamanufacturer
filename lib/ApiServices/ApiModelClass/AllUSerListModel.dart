/*
class AllUSerListModel {
  bool? status;
  String? message;
  int? currentPage;
  int? count;
  int? perPage;
  List<AllUSerListModelData>? data;

  AllUSerListModel(
      {this.status,
        this.message,
        this.currentPage,
        this.count,
        this.perPage,
        this.data});

  AllUSerListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    currentPage = json['current_page'];
    count = json['count'];
    perPage = json['per_page'];
    if (json['data'] != null) {
      data = <AllUSerListModelData>[];
      json['data'].forEach((v) {
        data!.add(new AllUSerListModelData.fromJson(v));
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

class AllUSerListModelData {
  int? id;
  String? name;
  dynamic? description;
  String? image;
  String? mobile;

  AllUSerListModelData({this.id, this.name, this.description, this.image, this.mobile});

  AllUSerListModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    mobile = json['mobile '];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['mobile '] = this.mobile;
    return data;
  }
}
*/
class AllUSerListModel {
  bool? status;
  String? message;
  int? currentPage;
  int? count;
  int? perPage;
  List<AllUSerListModelData>? data;

  AllUSerListModel(
      {this.status,
        this.message,
        this.currentPage,
        this.count,
        this.perPage,
        this.data});

  AllUSerListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    currentPage = json['current_page'];
    count = json['count'];
    perPage = json['per_page'];
    if (json['data'] != null) {
      data = <AllUSerListModelData>[];
      json['data'].forEach((v) {
        data!.add(new AllUSerListModelData.fromJson(v));
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

class AllUSerListModelData {
  int? id;
  String? businessName;
  String? lastName;
  String? gender;
  String? dateOfBirth;
  String? description;
  String? image;
  String? mobile;

  AllUSerListModelData(
      {this.id,
        this.businessName,
        this.lastName,
        this.gender,
        this.dateOfBirth,
        this.description,
        this.image,
        this.mobile});

  AllUSerListModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    businessName = json['business_name'];
    lastName = json['last_name'];
    gender = json['gender'];
    dateOfBirth = json['date_of_birth'];
    description = json['description'];
    image = json['image'];
    mobile = json['mobile '];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['business_name'] = this.businessName;
    data['last_name'] = this.lastName;
    data['gender'] = this.gender;
    data['date_of_birth'] = this.dateOfBirth;
    data['description'] = this.description;
    data['image'] = this.image;
    data['mobile '] = this.mobile;
    return data;
  }
}
