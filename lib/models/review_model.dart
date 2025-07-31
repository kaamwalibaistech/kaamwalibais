class ReviewModel {
  List<Details>? getTestimonialList;
  ReviewModel({this.getTestimonialList});

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      getTestimonialList: List<Details>.from(
        json['get_testimonial_list'].map((x) => Details.fromJson(x)),
      ),
    );
  }
}

class Details {
  String? name;
  String? rating;
  String? description;

  Details({this.name, this.rating, this.description});

  factory Details.fromJson(Map<String, dynamic> json) {
    return Details(
      name: json['name'],
      rating: json['rating'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toMap() => {
    'name': name ?? "",
    'rating': rating ?? "",
    'description': description ?? "",
  };
}
