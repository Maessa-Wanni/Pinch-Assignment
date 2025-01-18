/// Empty response model
class EmptyResponse {
  List<Errors>? errors;

  EmptyResponse({this.errors});

  EmptyResponse.fromJson(List<Map<String, dynamic>> json) {
    errors = json.map((e) => Errors.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (errors != null) {
      data['errors'] = errors!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Errors {
  int? status;
  String? title;

  Errors({this.status, this.title});

  Errors.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['title'] = title;
    return data;
  }
}
