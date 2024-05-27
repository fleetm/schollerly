import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:school_app/chat/constants/firestore_constants.dart';
import 'package:school_app/chat/models/user_chat.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Status {
  uninitialized,
  authenticated,
  authenticating,
  authenticateError,
  authenticateException,
  authenticateCanceled,
}

class AuthProvider extends ChangeNotifier {
  final GoogleSignIn googleSignIn;
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final SharedPreferences prefs;

  Status _status = Status.uninitialized;

  Status get status => _status;

  AuthProvider({
    required this.firebaseAuth,
    required this.googleSignIn,
    required this.prefs,
    required this.firebaseFirestore,
  });

  bool get isAuth => _status == Status.authenticated;

  String? getUserFirebaseId() {
    return prefs.getString(FirestoreConstants.id);
  }

  Future<bool> isLoggedIn() async {
    bool isGoogleSignedIn = await googleSignIn.isSignedIn();
    bool isFirebaseSignedIn = firebaseAuth.currentUser != null;

    return isGoogleSignedIn && isFirebaseSignedIn;
  }

  Future<bool> handleSignIn() async {
    _status = Status.authenticating;
    notifyListeners();

    try {
      GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        GoogleSignInAuthentication? googleAuth = await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        UserCredential userCredential = await firebaseAuth.signInWithCredential(credential);
        User? firebaseUser = userCredential.user;

        if (firebaseUser != null) {
          final QuerySnapshot result = await firebaseFirestore
              .collection(FirestoreConstants.pathUserCollection)
              .where(FirestoreConstants.id, isEqualTo: firebaseUser.uid)
              .get();
          final List<DocumentSnapshot> documents = result.docs;

          if (documents.isEmpty) {
            // New user, write data to server
            await firebaseFirestore.collection(FirestoreConstants.pathUserCollection).doc(firebaseUser.uid).set({
              FirestoreConstants.nickname: firebaseUser.displayName,
              FirestoreConstants.photoUrl: firebaseUser.photoURL,
              FirestoreConstants.id: firebaseUser.uid,
              'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
              FirestoreConstants.chattingWith: null
            });

            // Write data to local storage
            await prefs.setString(FirestoreConstants.id, firebaseUser.uid);
            await prefs.setString(FirestoreConstants.nickname, firebaseUser.displayName ?? "");
            await prefs.setString(FirestoreConstants.photoUrl, firebaseUser.photoURL ?? "");
          } else {
            // Existing user, get data from firestore
            DocumentSnapshot documentSnapshot = documents[0];
            UserChat userChat = UserChat.fromDocument(documentSnapshot);

            // Write data to local storage
            await prefs.setString(FirestoreConstants.id, userChat.id);
            await prefs.setString(FirestoreConstants.nickname, userChat.nickname);
            await prefs.setString(FirestoreConstants.photoUrl, userChat.photoUrl);
            await prefs.setString(FirestoreConstants.aboutMe, userChat.aboutMe);
          }

          _status = Status.authenticated;
          notifyListeners();
          return true;
        } else {
          // Firebase sign-in failed
          _status = Status.authenticateError;
          notifyListeners();
          return false;
        }
      } else {
        // Google Sign-In canceled
        _status = Status.authenticateCanceled;
        notifyListeners();
        return false;
      }
    } catch (e) {
      // Exception during sign-in
      if (kDebugMode) {
        print("Exception during sign-in: $e");
      }
      _status = Status.authenticateException;
      notifyListeners();
      return false;
    }
  }

  Future<void> handleSignOut() async {
    _status = Status.uninitialized;
    await firebaseAuth.signOut();
    await googleSignIn.disconnect();
    await googleSignIn.signOut();
  }
}
