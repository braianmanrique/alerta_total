import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier{
final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    String email = '';
    String password = '';

    bool isValidForm(){

      return formKey.currentState?.validate() ?? false;
    } 

}