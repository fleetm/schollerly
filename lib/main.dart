import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:school_app/main_module.dart';
import 'package:school_app/screens/login.dart';// Import the providers from the first main file
import 'package:school_app/chat/providers/providers.dart';
import 'firebase_options.dart';

void main() async {
  FilePicker.platform;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  MainModule.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  get prefs => null;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider( // Wrap your MyApp widget with MultiProvider
      providers: [
        // Add the providers from the first main file here
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(
            firebaseAuth: FirebaseAuth.instance,
            googleSignIn: GoogleSignIn(),
            prefs: prefs, // You need to provide prefs or get it from somewhere
            firebaseFirestore: FirebaseFirestore.instance,
          ),
        ),
        Provider<SettingProvider>(
          create: (_) => SettingProvider(
            prefs: prefs, // You need to provide prefs or get it from somewhere
            firebaseFirestore: FirebaseFirestore.instance,
            firebaseStorage: FirebaseStorage.instance,
          ),
        ),
        Provider<HomeProvider>(
          create: (_) => HomeProvider(
            firebaseFirestore: FirebaseFirestore.instance,
          ),
        ),
        Provider<ChatProvider>(
          create: (_) => ChatProvider(
            prefs: prefs, // You need to provide prefs or get it from somewhere
            firebaseFirestore: FirebaseFirestore.instance,
            firebaseStorage: FirebaseStorage.instance,
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Dubai',
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(0, 146, 255, 100),
          ),
          useMaterial3: true,
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
