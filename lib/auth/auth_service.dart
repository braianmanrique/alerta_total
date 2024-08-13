import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService{
  final _auth = FirebaseAuth.instance;
    final storage = new FlutterSecureStorage();


  Future<UserCredential?> loginWithGoogle() async{
    try{
      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser?.authentication;
      final cred = GoogleAuthProvider.credential(idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);
      
      return await _auth.signInWithCredential(cred);

    }
    catch(e){
         throw Exception('Error al iniciar sesión con Google: $e');
    }
  } 

  Future<void> signout() async {
    await storage.delete(key: 'token');
    
    try {
      await _auth.signOut();
    } catch (e) {
      print("Something went wrong");
    }
  }

  Future<User?> loginUserWithEmailAndPassword(String email, String password) async{
    try{
      final cred = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return cred.user;
    }catch(e){
      print("Something went wrong");
    }
    return null;
  }


  exceptionHandler(String code){
    switch(code){
      case "invalid-credential":
        print('message');
    }
  }

}

