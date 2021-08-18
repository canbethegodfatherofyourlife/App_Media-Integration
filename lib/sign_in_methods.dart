import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

late String name;
late String email;
late String imageUrl;
late String providerID;
Future<String?> signInWithGoogle() async {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  if (googleSignInAccount != null) {
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final UserCredential authResult =
    await _auth.signInWithCredential(credential);
    final User? user = authResult.user;
    if (user != null) {
      assert(user.email != null);
      assert(user.displayName != null);
      assert(user.photoURL != null);
      name = user.displayName!;
      email = user.email!;
      imageUrl = user.photoURL!;
      providerID="google";
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);
      final User? currentUser = _auth.currentUser;
      assert(user.uid == currentUser!.uid);
      return '$user';
    }
    return null;
  }
  return null;
}

Future<String?> signInWithFacebook() async {
  final LoginResult loginResult = await FacebookAuth.instance.login();
  if (loginResult != null&&loginResult.accessToken != null) {
    final OAuthCredential facebookAuthCredential =
    FacebookAuthProvider.credential(loginResult.accessToken!.token);
    final UserCredential authResult = await _auth
        .signInWithCredential(facebookAuthCredential);
    final User? user = authResult.user;
    if (user != null) {
      assert(user.email != null);
      assert(user.displayName != null);
      assert(user.photoURL != null);
      name = user.displayName!;
      email = user.email!;
      imageUrl = user.photoURL!;
      providerID="facebook";
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);
      final User? currentUser = _auth.currentUser;
      assert(user.uid == currentUser!.uid);
      return '$user';
    }
    return null;
  }
  return null;

}

Future<void> signOutGoogle() async {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  await googleSignIn.signOut();
  _auth.signOut();
}

Future<void> signOutFacebook() async {
  await FacebookAuth.instance.logOut();
  _auth.signOut();
}

