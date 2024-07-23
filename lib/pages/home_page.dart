import 'package:alerta_total/auth/auth_service.dart';
import 'package:alerta_total/widgets/button.dart';
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


  final _authService = AuthService();

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
          //  onPressed: _handleGoogleSignIn,
          onPressed: () async {
            await _authService.loginWithGoogle();
          },
           ), ),);
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
        const SizedBox(height: 20),
        CustomButton(
              label: "Cerrar Session",
              onPressed: () async {
                await _authService.signout();
                goToLogin(context);
              },
            ),
        const SizedBox(height: 20),

        MaterialButton(
           color: Colors.red,
           child: const Text("Cerrar session"), 
          onPressed: ()async{
            await _authService.signout();
          })
  
        ],
      ),
    );
  }


}

void signInWithGoogle() async {
  try {
    UserCredential userCredential;
      
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


  goToLogin(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
