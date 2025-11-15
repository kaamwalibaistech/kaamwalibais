class MaidlistModel {
  final bool? status;
  final String? message;
  final int? currentPage;
  final int? perPage;
  final int? totalRecords;
  final int? totalPages;
  final List<MaidData>? data;

  MaidlistModel({
    this.status,
    this.message,
    this.currentPage,
    this.perPage,
    this.totalRecords,
    this.totalPages,
    this.data,
  });

  factory MaidlistModel.fromJson(Map<String, dynamic> json) {
    return MaidlistModel(
      status: json['status'],
      message: json['message'],
      currentPage: json['current_page'],
      perPage: json['per_page'],
      totalRecords: json['total_records'],
      totalPages: json['total_pages'],
      data:
          json['data'] != null
              ? (json['data'] as List).map((e) => MaidData.fromJson(e)).toList()
              : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "message": message,
      "current_page": currentPage,
      "per_page": perPage,
      "total_records": totalRecords,
      "total_pages": totalPages,
      "data": data?.map((e) => e.toJson()).toList(),
    };
  }
}

class MaidData {
  final String? id;
  final String? name;
  final String? country;
  final String? area;
  final String? city;
  final String? language;
  final String? cityName;
  final String? age;
  final String? maritalStatus;
  final String? address;
  final String? religionId;
  final String? religionName;
  final String? workExperience;
  final String? yearSince;
  final String? adharCard;
  final String? panCard;
  final String? interviewUrl;
  final String? availableTimeslot;
  final String? packageId;
  final String? superCatId;
  final String? gender;
  final String? status;
  final String? photo;

  MaidData({
    this.id,
    this.name,
    this.country,
    this.area,
    this.city,
    this.language,
    this.cityName,
    this.age,
    this.maritalStatus,
    this.address,
    this.religionId,
    this.religionName,
    this.workExperience,
    this.yearSince,
    this.adharCard,
    this.panCard,
    this.interviewUrl,
    this.availableTimeslot,
    this.packageId,
    this.superCatId,
    this.gender,
    this.status,
    this.photo,
  });

  factory MaidData.fromJson(Map<String, dynamic> json) {
    return MaidData(
      id: json['id'],
      name: json['name'],
      country: json['country'],
      area: json['area'],
      city: json['city'],
      language: json['language'],
      cityName: json['city_name'],
      age: json['age'],
      maritalStatus: json['marital_status'],
      address: json['address'],
      religionId: json['religion_id'],
      religionName: json['religion_name'],
      workExperience: json['work_experience'],
      yearSince: json['year_since'],
      adharCard: json['adhar_card'],
      panCard: json['pan_card'],
      interviewUrl: json['interview_url'],
      availableTimeslot: json['available_timeslot'],
      packageId: json['package_id'],
      superCatId: json['super_cat_id'],
      gender: json['gender'],
      status: json['status'],
      photo: json['photo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "country": country,
      "area": area,
      "city": city,
      "language": language,
      "city_name": cityName,
      "age": age,
      "marital_status": maritalStatus,
      "address": address,
      "religion_id": religionId,
      "religion_name": religionName,
      "work_experience": workExperience,
      "year_since": yearSince,
      "adhar_card": adharCard,
      "pan_card": panCard,
      "interview_url": interviewUrl,
      "available_timeslot": availableTimeslot,
      "package_id": packageId,
      "super_cat_id": superCatId,
      "gender": gender,
      "status": status,
      "photo": photo,
    };
  }
}
