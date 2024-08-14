import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AutenticadorGoogle {
  void logout() {
    FirebaseAuth.instance.signOut();
  }

  Future<UserCredential> login() async {
    final GoogleSignInAccount? conta = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? autenticacao =
        await conta?.authentication;

    final credencial = GoogleAuthProvider.credential(
      accessToken: autenticacao?.accessToken,
      idToken: autenticacao?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credencial);
  }
}
