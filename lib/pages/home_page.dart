import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_button/sign_in_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((event){
      setState(() {
        _user = event;
        print(_user);

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Iniciar con Gmail !!"),
        backgroundColor: Colors.red,
      ),
      body: _user != null ?  _userInfo(): _googleSignInButton(),
    );
  }

  Widget _googleSignInButton(){
    return Center(
        child: SizedBox(
          height: 50,
           child: SignInButton(Buttons.google, 
           text: "Sign up with google",
           onPressed: _handleGoogleSignIn,),
           ),
           );
  }

  Widget _userInfo(){
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(_user!.photoURL!))),
        ),
        Text(_user!.email!),
        Text(_user!.displayName ?? ""),
        MaterialButton(
           color: Colors.red,
           child: const Text("Salir"), 
          onPressed: _auth.signOut)
  
        ],
      ),
    );
  }

  void _handleGoogleSignIn(){
    try{
      GoogleAuthProvider _googleAuthProvider =  GoogleAuthProvider();
      _auth.signInWithProvider(_googleAuthProvider);
    }catch(error){
      print(error);
    }
  }
}

void signInWithGoogle() async {
  try {
    UserCredential userCredential;
    // if (kIsWeb) {
    //   // Use signInWithPopup for web
    //   GoogleAuthProvider googleProvider = GoogleAuthProvider();
    //   userCredential = await FirebaseAuth.instance.signInWithPopup(googleProvider);
    // } else {
      // Use signInWithRedirect for mobile
      
      GoogleAuthProvider googleProvider = GoogleAuthProvider();
      await FirebaseAuth.instance.signInWithRedirect(googleProvider);
      userCredential = await FirebaseAuth.instance.getRedirectResult();
    // }
    User? user = userCredential.user;
    print('Successfully signed in with Google: ${user?.displayName}');
  } catch (e) {
    print('Error during sign in with Google: $e');
  }
}

  // Future<void> _handleGoogleSignIn() async {
  //   try {
  //     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  //     final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );

  //     UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
  //     User? user = userCredential.user;
  //     print('Successfully signed in with Google: ${user?.displayName}');
  //   } catch (e) {
  //     print('Error during sign in with Google: $e');
  //   }
  // }