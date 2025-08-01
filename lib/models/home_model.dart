// HomeModel.dart

class HomeModel {
  final List<SliderItem>? getSliderList;
  final List<SuperCategory>? getSuperCategoryList;
  final List<Testimonial>? getTestimonialList;
  final Map<String, String?>? getSupercategoryDropdown;
  final Map<String, String?>? getRequirementDropdown;
  final String? getVideoUrl;
  final List<CompanyDetail>? companyDetails;

  HomeModel({
    this.getSliderList,
    this.getSuperCategoryList,
    this.getTestimonialList,
    this.getSupercategoryDropdown,
    this.getRequirementDropdown,
    this.getVideoUrl,
    this.companyDetails,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
    getSliderList:
        (json['get_slider_list'] as List<dynamic>?)
            ?.map((e) => SliderItem.fromJson(e as Map<String, dynamic>))
            .toList(),
    getSuperCategoryList:
        (json['get_super_category_list'] as List<dynamic>?)
            ?.map((e) => SuperCategory.fromJson(e as Map<String, dynamic>))
            .toList(),
    getTestimonialList:
        (json['get_testimonial_list'] as List<dynamic>?)
            ?.map((e) => Testimonial.fromJson(e as Map<String, dynamic>))
            .toList(),
    getSupercategoryDropdown: (json['get_supercategory_dropdown']
            as Map<String, dynamic>?)
        ?.map((k, v) => MapEntry(k, v == null ? null : v.toString())),
    getRequirementDropdown: (json['get_requirement_dropdown']
            as Map<String, dynamic>?)
        ?.map((k, v) => MapEntry(k, v == null ? null : v.toString())),
    getVideoUrl: json['get_video_url'] as String?,
    companyDetails:
        (json['company_details'] as List<dynamic>?)
            ?.map((e) => CompanyDetail.fromJson(e as Map<String, dynamic>))
            .toList(),
  );

  Map<String, dynamic> toJson() => {
    'get_slider_list': getSliderList?.map((e) => e.toJson()).toList(),
    'get_super_category_list':
        getSuperCategoryList?.map((e) => e.toJson()).toList(),
    'get_testimonial_list': getTestimonialList?.map((e) => e.toJson()).toList(),
    'get_supercategory_dropdown': getSupercategoryDropdown?.map(
      (k, v) => MapEntry(k, v),
    ),
    'get_requirement_dropdown': getRequirementDropdown?.map(
      (k, v) => MapEntry(k, v),
    ),
    'get_video_url': getVideoUrl,
    'company_details': companyDetails?.map((e) => e.toJson()).toList(),
  };
}

class SliderItem {
  final String? id;
  final String? title;
  final String? status;
  final String? photo;

  SliderItem({this.id, this.title, this.status, this.photo});

  factory SliderItem.fromJson(Map<String, dynamic> json) => SliderItem(
    id: json['id'] as String?,
    title: json['title'] as String?,
    status: json['status'] as String?,
    photo: json['photo'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'status': status,
    'photo': photo,
  };
}

class SuperCategory {
  final String? id;
  final String? name;
  final String? description;
  final String? status;
  final String? icon;

  SuperCategory({this.id, this.name, this.description, this.status, this.icon});

  factory SuperCategory.fromJson(Map<String, dynamic> json) => SuperCategory(
    id: json['id'] as String?,
    name: json['name'] as String?,
    description: json['description'] as String?,
    status: json['status'] as String?,
    icon: json['icon'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'status': status,
    'icon': icon,
  };
}

class Testimonial {
  final String? name;
  final String? rating;
  final String? description;

  Testimonial({this.name, this.rating, this.description});

  factory Testimonial.fromJson(Map<String, dynamic> json) => Testimonial(
    name: json['name'] as String?,
    rating: json['rating'] as String?,
    description: json['description'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'rating': rating,
    'description': description,
  };
}

class CompanyDetail {
  final String? id;
  final String? photo;
  final String? name;
  final String? description;
  final String? address;
  final String? contactno;
  final String? emailid;
  final String? workingHours;
  final String? closedDays;

  CompanyDetail({
    this.id,
    this.photo,
    this.name,
    this.description,
    this.address,
    this.contactno,
    this.emailid,
    this.workingHours,
    this.closedDays,
  });

  factory CompanyDetail.fromJson(Map<String, dynamic> json) => CompanyDetail(
    id: json['id'] as String?,
    photo: json['photo'] as String?,
    name: json['name'] as String?,
    description: json['description'] as String?,
    address: json['address'] as String?,
    contactno: json['contactno'] as String?,
    emailid: json['emailid'] as String?,
    workingHours: json['working_hours'] as String?,
    closedDays: json['closed_days'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'photo': photo,
    'name': name,
    'description': description,
    'address': address,
    'contactno': contactno,
    'emailid': emailid,
    'working_hours': workingHours,
    'closed_days': closedDays,
  };
}
