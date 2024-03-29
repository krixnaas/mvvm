import 'package:flutter/material.dart';
import 'package:mvvm/res/components/round_button.dart';
import 'package:mvvm/res/image_strings.dart';
import 'package:mvvm/res/sizes.dart';
import 'package:mvvm/res/text_strings.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FocusNode nameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();

    nameFocusNode.dispose();
    emailFocusNode.dispose();
    phoneFocusNode.dispose();
    passwordFocusNode.dispose();

    _obsecurePassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(image:AssetImage(welcomeTop), height: size.height * 0.12,),
                Text(signUpTitle, style: Theme.of(context).textTheme.headlineLarge,),
                Text(signUpSubtitle, style: Theme.of(context).textTheme.titleMedium,),
                SizedBox(height: tFormHeightSize-20,),
                TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: nameHint,
                    labelText: nameHint,
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person_outline_rounded),
                  ),
                  onFieldSubmitted: (value) {
                    Utils.fieldFocusChange(
                        context, nameFocusNode, emailFocusNode);
                  },
                ),
                SizedBox(height: tFormHeightSize-20,),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: emailHint,
                    labelText: emailHint,
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.alternate_email),
                  ),
                  onFieldSubmitted: (value) {
                    Utils.fieldFocusChange(
                        context, emailFocusNode, phoneFocusNode);
                  },
                ),
                SizedBox(height: tFormHeightSize-20,),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    hintText: phoneHint,
                    labelText: phoneHint,
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.numbers),
                  ),
                  onFieldSubmitted: (value) {
                    Utils.fieldFocusChange(
                        context, emailFocusNode, phoneFocusNode);
                  },
                ),
                SizedBox(height: tFormHeightSize-20,),
                ValueListenableBuilder(
                    valueListenable: _obsecurePassword,
                    builder: (context , value, child){
                      return TextFormField(
                        controller: _passwordController,
                        obscureText: _obsecurePassword.value,
                        focusNode: passwordFocusNode,
                        obscuringCharacter: "*",
                        decoration: InputDecoration(
                          hintText: passwordHint,
                          labelText: passwordHint,
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.fingerprint),
                          suffixIcon: InkWell(
                              onTap: (){
                                _obsecurePassword.value = !_obsecurePassword.value ;
                              },
                              child: Icon(
                                  _obsecurePassword.value ?  Icons.visibility_off_outlined :
                                  Icons.visibility
                              )),
                        ),
                      );

                    }
                ),
                SizedBox(height: tFormHeightSize-20,),
                /*Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: (){
                        Navigator.pushNamed(context, RoutesName.signup);
                      },
                      child: Text(forgotPassword)
                  ),
                ),*/
                SizedBox(height: tFormHeightSize-20,),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: (){},
                    child: Text(signUp.toUpperCase()),
                  ),
                ),
                SizedBox(height: size.height*0.02,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(or),
                    SizedBox(height: size.height*0.02,),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        icon: Image(
                          image:AssetImage(googleLogoImage),
                          width: 20.0,
                        ),
                        onPressed: (){},
                        label: Text(googleAccount.toUpperCase()),
                      ),
                    ),
                    SizedBox(height: size.height*0.01,),
                    TextButton(onPressed: (){
                      Navigator.pushNamed(context, RoutesName.login);
                    },child: Text.rich(
                      TextSpan(
                          text: alreadyHaveAnAccount,
                          style: Theme.of(context).textTheme.bodyLarge,
                          children: [
                            TextSpan(text: login, style: TextStyle(color: Colors.blue)
                            )
                          ]
                      ),)
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
