import 'package:dms_new_project/providers/doc_search_provider.dart';
import 'package:flutter/material.dart';
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
class SearchWidget extends StatelessWidget {
  SearchList search;
   SearchWidget({required this.search});

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
                itemCount: search.attribute!.length,
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
                        Text("${search.attribute![index].name}",style: headerStyle,),
                        Text("${search.attribute![index].value}",style: attStyle,),
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
                  search.documentType=="JPG"?jpg:
                  search.documentType=="PDF"?pdf:
                  search.documentType=="JPEG"?jpg:
                  search.documentType=="XLS"?xls:
                  search.documentType=="XLSX"?xls:
                  search.documentType=="PPTX"?ppt:
                  png
              ),
              title: Text("${search.uploadedBy}"),
              subtitle: Text("${search.uploadedDate}"),
              trailing: InkWell(
                onTap: (){
                  search.attachmentStatus=="Complete"?NavigationServices.goNextAndKeepHistory(context: context, widget: DocViewScreen(
                    filePath: "${search.noofVersions??""}",
                  )):
                  showPendingDialog(context);
                },
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                        border: Border.all(
                            color: search.attachmentStatus == "Complete"
                                ? greenColor
                                : redColor,
                            width: 1.5)),
                    child: Text(
                      "${search.attachmentStatus}",
                      style: compStyle,
                    )),
              ),
            ),),
        ],
      ),
    );
  }
}

