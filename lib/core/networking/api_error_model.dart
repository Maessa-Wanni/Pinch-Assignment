/// Error model
class ApiErrorModel {
  String? title;
  int? code;

  ApiErrorModel({this.code, this.title});

  ApiErrorModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['code'] = code;
    return data;
  }
}
