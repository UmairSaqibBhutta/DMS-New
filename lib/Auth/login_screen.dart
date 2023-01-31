import 'package:dms_new_project/Screens/app_screens/dashboard_module/home_dashboard_screen.dart';
import 'package:dms_new_project/configs/colors.dart';
import 'package:dms_new_project/configs/text_styles.dart';
import 'package:dms_new_project/helper_services/custom_loader.dart';
import 'package:dms_new_project/helper_widgets/default_button.dart';
import 'package:dms_new_project/services/login_api_services.dart';
import 'package:flutter/material.dart';

import '../configs/constants.dart';
import '../helper_widgets/custom_textfield.dart';





class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isObscure=true;
  TextEditingController emailCont=TextEditingController(
    text: "l.lotfy@almajed4oud.com"
  );
  TextEditingController passwordCont=TextEditingController(
    text: "Almajed4oud@123"
  );

  loginHandler()async{
    CustomLoader.showLoader(context: context);
    bool res=await LoginApiService().getUser(context: context, userName: emailCont.text, password: passwordCont.text);
    CustomLoader.hideLoader(context);
    if(res){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeDashBoardScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: appColor,
      ),
      body: Stack(

        alignment: Alignment.topCenter,
        children: [
          //
          Container(
            alignment: Alignment.center,
            height: 260.0,
            width: double.infinity,
            color: appColor,
            child: Text("DMS Login",style: loginStyle,),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: double.infinity,

              height: 370.0,
              child: Card(
                margin: EdgeInsets.only(left: 18.0,right: 18.0),

                shape: circularBorder,
                elevation: 3.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(

                        backgroundImage: AssetImage("assets/images/doc_logo.jpg"),
                      maxRadius: 50.0,
                      ),
                      CustomTextField(
                        headerText: "Email",
                        hintText: "Email Address",
                        controller: emailCont,
                        inputType: TextInputType.emailAddress,
                        inputAction: TextInputAction.next,
                      ),
                      CustomTextField(
                        headerText: "Password",
                        hintText: "*****",
                        controller: passwordCont,
                        inputType: TextInputType.number,
                        obscureText: isObscure,
                        suffixIcon: isObscure?Icons.visibility:Icons.visibility_off,
                        suffixOnTap: () {
                          isObscure =! isObscure;
                          setState(() {

                          });
                        }
                      ),
                      DefaultButton(
                        text: "Sign in",

                        onTap: (){
                          loginHandler();
                        },

                      )

                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
