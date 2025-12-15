// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class GoogleService {
//   static final GoogleService _instance = GoogleService._internal();
//
//   factory GoogleService() {
//     return _instance;
//   }
//
//   GoogleService.protected();
//
//   GoogleService._internal();
//   static GoogleSignIn _googleSignIn = GoogleSignIn(
//     scopes: <String>[
//       'email',
//       'profile',
//     ],
//   );
//   static User? firebaseUser;
//   static GoogleSignInAccount? currentUser;
//   static Future<bool> handleSignIn() async {
//     bool result = false;
//     try {
//       if (_googleSignIn.currentUser != null) await _googleSignIn.signOut();
//       return _googleSignIn.signIn().then((onValue) async {
//         if (onValue != null) {
//           // Begin - Xác thực với Firebase
//           final googleAuth = await onValue.authentication;
//           final credential = GoogleAuthProvider.credential(
//             accessToken: googleAuth.accessToken,
//             idToken: googleAuth.idToken,
//           );
//           final authResult =
//               await FirebaseAuth.instance.signInWithCredential(credential);
//           firebaseUser = authResult.user;
//           // End - Xác thực với Firebase
//           await onValue.clearAuthCache();
//           currentUser = onValue;
//           result = true;
//         } else {
//           currentUser = null;
//         }
//         return result;
//       });
//     } catch (error) {
//       return result;
//     }
//   }
//
//   static Future<void> handleSignOut() async {
//     try {
//       if (currentUser != null) {
//         try {
//           if (FirebaseAuth.instance.currentUser != null) FirebaseAuth.instance.signOut();
//         } catch (ex) {
//           print(ex);
//         }
//         await currentUser!.clearAuthCache();
//         await _googleSignIn.signOut();
//         currentUser = null;
//       }
//     } catch (ex) {
//       print(ex);
//       currentUser = null;
//     }
//   }
// }
