import "package:firebase_auth/firebase_auth.dart";
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  /* ============= Connexion avec Google============ */
  Future<UserCredential> signingWithGoogleByFirebase() async {
    // Déclencher le flux d'authentification
    final googleUser = await _googleSignIn.signIn();

    // Obtenir les détails d'autorisation de la demande
    final googleAuth = await googleUser!.authentication;

    // Créer un nouvel identifiant
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    // Une fois connecté, renvoyer l'identifiant de l'utilisateur
    return await _auth.signInWithCredential(credential);
  }

  // L'etat de l'utilisateur en temps réel
  Stream<User?> get user => _auth.authStateChanges();
}