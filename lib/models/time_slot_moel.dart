import 'dart:convert';

TimeslotModel timeslotModelFromJson(String str) =>
    TimeslotModel.fromJson(json.decode(str));

String timeslotModelToJson(TimeslotModel data) => json.encode(data.toJson());

class TimeslotModel {
  String? status;
  int? code;
  String? message;
  Map<String, String>? data;

  TimeslotModel({this.status, this.code, this.message, this.data});

  factory TimeslotModel.fromJson(Map<String, dynamic> json) => TimeslotModel(
    status: json["status"],
    code: json["code"],
    message: json["message"],
    data:
        json["data"] == null
            ? null
            : Map<String, String>.from(
              json["data"].map(
                (key, value) => MapEntry(key.toString(), value.toString()),
              ),
            ),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "data": data,
  };
}
