class UserResponseModel {
  int? resultType;
  String? message;
  UserModel? data;


  UserResponseModel(
      {
        this.resultType,
        this.message,
        this.data,
       });

  UserResponseModel.fromJson(Map<String, dynamic> json) {

    resultType = json['ResultType'];
    message = json['Message'];
    data = json['Data'] != null ? new UserModel.fromJson(json['Data']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['ResultType'] = this.resultType;
    data['Message'] = this.message;
    if (this.data != null) {
      data['Data'] = this.data!.toJson();
    }

    return data;
  }
}

class UserModel {
  String? name;
  String? userID;
  int? empId;
  String? token;
  int? roleID;
  String? roleName;

  UserModel(
      {this.name,
        this.userID,
        this.empId,
        this.token,
        this.roleID,
        this.roleName});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    userID = json['UserID'];
    empId = json['EmpId'];
    token = json['Token'];
    roleID = json['RoleID'];
    roleName = json['RoleName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['UserID'] = this.userID;
    data['EmpId'] = this.empId;
    data['Token'] = this.token;
    data['RoleID'] = this.roleID;
    data['RoleName'] = this.roleName;
    return data;
  }
}
