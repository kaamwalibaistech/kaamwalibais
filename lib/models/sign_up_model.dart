class SignupModel {
  int? response;
  String? msg;
  dynamic data;

  SignupModel({this.response, this.msg, this.data});

  factory SignupModel.fromJson(Map<String, dynamic> json) => SignupModel(
    response: json["response"],
    msg: json["msg"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "msg": msg,
    "data": data,
  };
}
