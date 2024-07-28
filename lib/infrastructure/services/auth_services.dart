import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:growit/constants/constants.dart';
import 'package:growit/infrastructure/navigation/routes.dart';

class AuthService extends GetxService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Rx<User?> currentUser = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    init();
  }

  void init() {
    log('AuthService initialized');
    _auth.currentUser != null
        ? log('User is logged in')
        : log('User is not logged in');
    currentUser.value = _auth.currentUser;
    currentUser.bindStream(_auth.authStateChanges());
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
      }
    }
    return null;
  }

  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final employeeCollection = _firestore.collection(EMPLOYEE_DB);
      await employeeCollection.doc(userCredential.user!.uid).set(
          {'email': email, 'orgnizationName': parseOrgnizationName(email)});
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<bool> isUserExist(String uid) async {
    try {
      final d = await _firestore.collection(EMPLOYEE_DB).doc(uid).get();
      return d.exists;
    } catch (e) {
      return false;
    }
  }

  Future<bool> isEmailExist(String email) async {
    try {
      final d = await _firestore
          .collection(EMPLOYEE_DB)
          .where('email', isEqualTo: email)
          .get();
      return d.docs.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }

  String parseOrgnizationName(String email) {
    final name = email.split('@').last.split('.').first;
    return name;
  }
}
