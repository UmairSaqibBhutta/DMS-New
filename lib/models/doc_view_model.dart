class DocViewModel {
  int? resultType;
  String? message;
  String? data;

  DocViewModel({
    this.resultType,
    this.message,
    this.data,
  });

  DocViewModel.fromJson(Map<String, dynamic> json) {
    resultType = json['ResultType'];
    message = json['Message'];
    data = json['Data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['ResultType'] = this.resultType;
    data['Message'] = this.message;
    data['Data'] = this.data;

    return data;
  }
}
