class SuperCategoryModel {
  final Map<String, String> data;

  SuperCategoryModel({required this.data});

  factory SuperCategoryModel.fromJson(Map<String, dynamic> json) {
    // Convert dynamic values to String
    final Map<String, String> parsedData = {};
    (json['data'] as Map<String, dynamic>).forEach((key, value) {
      if (key.isNotEmpty && value != null) {
        parsedData[key] = value.toString();
      }
    });
    return SuperCategoryModel(data: parsedData);
  }
}
