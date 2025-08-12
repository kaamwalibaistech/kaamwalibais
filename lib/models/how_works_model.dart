class HowItWorksModel {
  String? id;
  String? description;

  HowItWorksModel({this.id, this.description});

  factory HowItWorksModel.fromJson(Map<String, dynamic> json) {
    return HowItWorksModel(
      id: json['id']?.toString(),
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'description': description};
  }
}
