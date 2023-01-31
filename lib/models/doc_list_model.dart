class DocListModel {

  int? resultType;
  String? message;
  List<DocumentsList>? data;


  DocListModel(
      {
        this.resultType,
        this.message,
        this.data,
        });

  DocListModel.fromJson(Map<String, dynamic> json) {

    resultType = json['ResultType'];
    message = json['Message'];
    if (json['Data'] != null) {
      data = <DocumentsList>[];
      json['Data'].forEach((v) {
        data!.add(new DocumentsList.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['ResultType'] = this.resultType;
    data['Message'] = this.message;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class DocumentsList {
  int? documentId;
  List<Attribute>? attribute;
  String? uploadedBy;
  String? uploadedDate;
  String? documentType;
  String? attachmentStatus;
  String? noofVersions;
  String? action;

  DocumentsList(
      {this.documentId,
        this.attribute,
        this.uploadedBy,
        this.uploadedDate,
        this.documentType,
        this.attachmentStatus,
        this.noofVersions,
        this.action});

  DocumentsList.fromJson(Map<String, dynamic> json) {
    documentId = json['DocumentId'];
    if (json['Attribute'] != null) {
      attribute = <Attribute>[];
      json['Attribute'].forEach((v) {
        attribute!.add(new Attribute.fromJson(v));
      });
    }
    uploadedBy = json['UploadedBy'];
    uploadedDate = json['UploadedDate'];
    documentType = json['DocumentType'];
    attachmentStatus = json['AttachmentStatus'];
    noofVersions = json['NoofVersions'];
    action = json['Action'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DocumentId'] = this.documentId;
    if (this.attribute != null) {
      data['Attribute'] = this.attribute!.map((v) => v.toJson()).toList();
    }
    data['UploadedBy'] = this.uploadedBy;
    data['UploadedDate'] = this.uploadedDate;
    data['DocumentType'] = this.documentType;
    data['AttachmentStatus'] = this.attachmentStatus;
    data['NoofVersions'] = this.noofVersions;
    data['Action'] = this.action;
    return data;
  }
}

class Attribute {
  String? name;
  String? value;
  int? dataType;

  Attribute({this.name, this.value, this.dataType});

  Attribute.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    value = json['Value'];
    dataType = json['DataType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['Value'] = this.value;
    data['DataType'] = this.dataType;
    return data;
  }
}
