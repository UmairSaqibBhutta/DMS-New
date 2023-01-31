class CategoriesModel {

  int? resultType;
  String? message;
  List<CategoriesList>? data;


  CategoriesModel(
      {

        this.resultType,
        this.message,
        this.data,

      });

  CategoriesModel.fromJson(Map<String, dynamic> json) {

    resultType = json['ResultType'];
    message = json['Message'];
    if (json['Data'] != null) {
      data = <CategoriesList>[];
      json['Data'].forEach((v) {
        data!.add(new CategoriesList.fromJson(v));
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

class CategoriesList {
  int? documentCategoryId;
  String? name;
  int? docuementFolderId;
  int? docSub3FolderId;
  int? docSub2FolderId;
  int? docSub1FolderId;
  String? documentFolder;
  String? docSub3Folder;
  String? docSub2Folder;
  String? docSub1Folder;
  String? createdBy;

  CategoriesList(
      {this.documentCategoryId,
        this.name,
        this.docuementFolderId,
        this.docSub3FolderId,
        this.docSub2FolderId,
        this.docSub1FolderId,
        this.documentFolder,
        this.docSub3Folder,
        this.docSub2Folder,
        this.docSub1Folder,
        this.createdBy});

  CategoriesList.fromJson(Map<String, dynamic> json) {
    documentCategoryId = json['DocumentCategoryId'];
    name = json['Name'];
    docuementFolderId = json['DocuementFolderId'];
    docSub3FolderId = json['DocSub3FolderId'];
    docSub2FolderId = json['DocSub2FolderId'];
    docSub1FolderId = json['DocSub1FolderId'];
    documentFolder = json['DocumentFolder'];
    docSub3Folder = json['DocSub3Folder'];
    docSub2Folder = json['DocSub2Folder'];
    docSub1Folder = json['DocSub1Folder'];
    createdBy = json['CreatedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DocumentCategoryId'] = this.documentCategoryId;
    data['Name'] = this.name;
    data['DocuementFolderId'] = this.docuementFolderId;
    data['DocSub3FolderId'] = this.docSub3FolderId;
    data['DocSub2FolderId'] = this.docSub2FolderId;
    data['DocSub1FolderId'] = this.docSub1FolderId;
    data['DocumentFolder'] = this.documentFolder;
    data['DocSub3Folder'] = this.docSub3Folder;
    data['DocSub2Folder'] = this.docSub2Folder;
    data['DocSub1Folder'] = this.docSub1Folder;
    data['CreatedBy'] = this.createdBy;
    return data;
  }
}
