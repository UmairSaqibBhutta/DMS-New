import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dms_new_project/models/doc_view_model.dart';
import 'package:dms_new_project/providers/doc_search_provider.dart';
import 'package:dms_new_project/providers/doc_view_provider.dart';
import 'package:dms_new_project/utils/handlers.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../../configs/colors.dart';
import '../../../configs/constants.dart';
import '../../../configs/text_styles.dart';
import '../../../helper_services/custom_loader.dart';
import '../../../helper_services/navigation_services.dart';
import '../../../models/doc_search_model.dart';
import '../../../services/doc_search_service.dart';
import '../../../utils/dialogs/status_pending_dialog.dart';
import '../doc_module/doc_view_screen.dart';

class DocSearchScreen extends StatefulWidget {
  final String searchText;
  final int catId;
  const DocSearchScreen({ required this.searchText, required this.catId});

  @override
  State<DocSearchScreen> createState() => _DocSearchScreenState();
}

class _DocSearchScreenState extends State<DocSearchScreen> {
  docSearchHandle()async{
    CustomLoader.showLoader(context: context);
   await DocSearchService().getSearch(context: context, searchText: widget.searchText, catId: widget.catId);
    CustomLoader.hideLoader(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      docSearchHandle();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: iconTheme,
        backgroundColor: whiteColor,
        title: Text("${widget.searchText}",style: dashStyle,),
      ),
      body:SafeArea(
        child: Padding(

          padding: EdgeInsets.symmetric(horizontal: 6.0,vertical: 12.0),
          child: Consumer<DocSearchProvider>(builder: (context,search,_){
            return ListView.builder(
                shrinkWrap: true,
                itemCount: search.searchList!.length,
                primary: false,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext,index){
              return SearchWidget(search: search.searchList![index]);
            });
          },),
        ),
      ),
    );
  }
}
class SearchWidget extends StatefulWidget {
  SearchList search;
   SearchWidget({required this.search});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  DocViewModel ? view;
  String filePath="";
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      shape: circularBorder,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          SizedBox(
            height: 50.0,
            child: ListView.builder(
                itemCount: widget.search.attribute!.length,
                shrinkWrap: true,
                primary: false,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext,index){
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 6.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${widget.search.attribute![index].name}",style: headerStyle,),
                        Text("${widget.search.attribute![index].value}",style: attStyle,),
                      ],
                    ),
                  );
                }),
          ),
          Card(
            shape: circularBorder,
            margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            elevation: 4.0,
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
              leading: Image.asset(
                  widget.search.documentType=="JPG"?jpg:
                  widget.search.documentType=="PDF"?pdf:
                  widget.search.documentType=="JPEG"?jpg:
                  widget.search.documentType=="XLS"?xls:
                  widget.search.documentType=="XLSX"?xls:
                  widget.search.documentType=="PPTX"?ppt:
                  png
              ),
              title: Text("${widget.search.uploadedBy}"),
              subtitle: Text("${widget.search.uploadedDate}"),
              trailing: InkWell(
                onTap: ()async{

                  if(widget.search.attachmentStatus=="Complete"){
                  await  docViewHandler(context: context, filePath: widget.search.noofVersions??"");
                    view=Provider.of<DocViewProvider>(context,listen: false).docView!;
                    await  _createFileFromBase64();
                    OpenFile.open(filePath);

                  }
                  else{
                  showPendingDialog(context);
                  }
                },
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                        border: Border.all(
                            color: widget.search.attachmentStatus == "Complete"
                                ? greenColor
                                : redColor,
                            width: 1.5)),
                    child: Text(
                      "${widget.search.attachmentStatus}",
                      style: compStyle,
                    )),
              ),
            ),),
        ],
      ),
    );
  }
  _createFileFromBase64() async {
    final encodedStr = "${view!.data}";

    Uint8List bytes = base64.decode(encodedStr);

    String dir = (await getApplicationDocumentsDirectory()).path;

    File file = File(
      // "$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + ".pdf");
        "$dir/" + widget.search.noofVersions!);

    await file.writeAsBytes(bytes);
    filePath = file.path;
    setState(() {});
    print("fILE 1 $filePath");
    return filePath;

    // return filePath;
  }
}


