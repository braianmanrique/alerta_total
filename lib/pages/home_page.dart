// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:sign_in_button/sign_in_button.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   User? _user;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _auth.authStateChanges().listen((event){
//       setState(() {
//         _user = event;
//       });
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       appBar: AppBar(
//         title: const Text("Iniciar con Gmail !!"),
//         backgroundColor: Colors.red,
//       ),
//       body: _user != null ?  _userInfo(): _googleSignInButton(),
//     );
//   }

//   Widget _googleSignInButton(){
//     return Center(
//         child: SizedBox(
//           height: 50,
//            child: SignInButton(Buttons.google, 
//            text: "Sign up with google",
//            onPressed: _handleGoogleSignIn,),
//            ),
//            );
//   }

//   Widget _userInfo(){
//     return SizedBox();
//   }

//   void _handleGoogleSignIn(){
//     try{
//       GoogleAuthProvider _googleAuthProvider =  GoogleAuthProvider();
//       _auth.signInWithProvider(_googleAuthProvider);
//     }catch(error){
//       print(error);
//     }
//   }
// }