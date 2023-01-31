class FoldersModel {

  int? resultType;
  String? message;
  List<FoldersList>? data;


  FoldersModel(
      {
        this.resultType,
        this.message,
        this.data,

      });

  FoldersModel.fromJson(Map<String, dynamic> json) {

    resultType = json['ResultType'];
    message = json['Message'];
    if (json['Data'] != null) {
      data = <FoldersList>[];
      json['Data'].forEach((v) {
        data!.add(new FoldersList.fromJson(v));
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

class FoldersList {
  int? documentFolderId;
  String? name;
  String? createdDate;
  String? createdBy;
  List<DocSubFolders>? docSubFolders;

 Null? documentCategory;


  FoldersList(
      {this.documentFolderId,
        this.name,
        this.createdDate,
        this.createdBy,
        this.docSubFolders,
        this.documentCategory
      });

  FoldersList.fromJson(Map<String, dynamic> json) {
    documentFolderId = json['DocumentFolderId'];
    name = json['Name'];
    createdDate = json['CreatedDate'];
    createdBy = json['CreatedBy'];
    if (json['DocSubFolders'] != null) {
      docSubFolders = <DocSubFolders>[];
      json['DocSubFolders'].forEach((v) {
        docSubFolders!.add(new DocSubFolders.fromJson(v));
      });
      if (json['DocumentCategory'] != null) {
        // documentCategory = <DocumentCategory>[];
        json['DocumentCategory'].forEach((v) {
          documentCategory!.add(new DocumentCategory.fromJson(v));
        });
      }
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DocumentFolderId'] = this.documentFolderId;
    data['Name'] = this.name;
    data['CreatedDate'] = this.createdDate;
    data['CreatedBy'] = this.createdBy;
    if (this.docSubFolders != null) {
      data['DocSubFolders'] =
          this.docSubFolders!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class DocSubFolders {
  int? id;
  String? name;
  int? docFolderId;
  List<DocSubFolders>? docSubFolders;
  List<DocumentCategory>? documentCategory;

  DocSubFolders(
      {this.id,
        this.name,
        this.docFolderId,
        this.docSubFolders,
        this.documentCategory});

  DocSubFolders.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    docFolderId = json['DocFolderId'];
    if (json['DocSubFolders'] != null) {
      docSubFolders = <DocSubFolders>[];
      json['DocSubFolders'].forEach((v) {
        docSubFolders!.add(new DocSubFolders.fromJson(v));
      });
    }
    if (json['DocumentCategory'] != null) {
      documentCategory = <DocumentCategory>[];
      json['DocumentCategory'].forEach((v) {
        documentCategory!.add(new DocumentCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['DocFolderId'] = this.docFolderId;
    if (this.docSubFolders != null) {
      data['DocSubFolders'] =
          this.docSubFolders!.map((v) => v.toJson()).toList();
    }
    if (this.documentCategory != null) {
      data['DocumentCategory'] =
          this.documentCategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



class DocumentCategory {
  int? documentCategoryId;
  String? name;
  int? docuementFolderId;
  int? docSub3FolderId;

  String? createdBy;

  DocumentCategory(
      {this.documentCategoryId,
        this.name,
        this.docuementFolderId,
        this.docSub3FolderId,

        this.createdBy});

  DocumentCategory.fromJson(Map<String, dynamic> json) {
    documentCategoryId = json['DocumentCategoryId'];
    name = json['Name'];
    docuementFolderId = json['DocuementFolderId'];
    docSub3FolderId = json['DocSub3FolderId'];

    createdBy = json['CreatedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DocumentCategoryId'] = this.documentCategoryId;
    data['Name'] = this.name;
    data['DocuementFolderId'] = this.docuementFolderId;
    data['DocSub3FolderId'] = this.docSub3FolderId;

    data['CreatedBy'] = this.createdBy;
    return data;
  }
}


