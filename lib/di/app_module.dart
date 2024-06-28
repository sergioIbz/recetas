import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:recetas/di/firebase_services.dart';

@module
abstract class AppModule {
  @preResolve
  Future<FirebaseServices> firebaseServices() => FirebaseServices.init();
  
  @injectable
  FirebaseAuth firebaseAuth() => FirebaseAuth.instance;
}
