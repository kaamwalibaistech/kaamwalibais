class PackageModel {
  final Map<String, String> data;

  PackageModel({required this.data});

  factory PackageModel.fromJson(Map<String, dynamic> json) {
    final Map<String, String> parsedData = {};
    (json['data'] as Map<String, dynamic>).forEach((key, value) {
      if (key.isNotEmpty && value != null) {
        parsedData[key] = value.toString();
      }
    });
    return PackageModel(data: parsedData);
  }
}
