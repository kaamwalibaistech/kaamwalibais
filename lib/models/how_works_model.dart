class HowItWorksModel {
  String? id;
  String? description;

  HowItWorksModel({this.id, this.description});

  factory HowItWorksModel.fromJson(List<dynamic> json) {
    return HowItWorksModel(
      id: json[0]['id']?.toString(),
      description: json[0]['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'description': description};
  }
}
