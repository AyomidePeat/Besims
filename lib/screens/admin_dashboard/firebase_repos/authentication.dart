import 'dart:typed_data';
import 'package:bsims/firebase_repos/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationMethod {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirestoreClass firestoreClass = FirestoreClass();

  Future<String> firstSignUp(
      {required String email,
      required String password,
      required String businessName,
      required String name}) async {
    String message = 'Something went wrong';
    email.trim();
    password.trim();
    if (name != "" && email != "" && password != "") {
      try {
        // final userCredential = await auth.createUserWithEmailAndPassword(
        //     email: email, password: password);

        await firestoreClass.addUser(
            name: name,
            username: name,
            email: email,
            role: 'admin',
            image: '',
            phoneNumber: '',
            gender: '');
        message = "Success";
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          message = "Password is too weak";
        } else if (e.code == 'email-already-in-use') {
          message = 'Email already registered';
        } else if (e.code == 'user not found') {
          message = 'Email or Password is incorrect';
        } else if (e.code == '') {
          message = 'No internet connection';
        }
        return message;
      } catch (e) {
        return e.toString();
      }
    } else {
      message = "Please fill up all the fields.";
    }
    return message;
  }

  Future<String> signUp(
      {required String email,
      required String password,
      required String gender,
      required String username,
      required String role,
      required Uint8List pickedImage,
      required String phoneNumber,
      required String name}) async {
    String message = 'Something went wrong';
    email.trim();
    password.trim();
    if (name != "" && email != "" && password != "") {
      try {
        // final userCredential = await auth.createUserWithEmailAndPassword(
        //     email: email, password: password);
        final fileName = name;
        final firebaseStorageRef =
            firebase_storage.FirebaseStorage.instance.ref().child(fileName);
        await firebaseStorageRef.putData(pickedImage);

        final image = await firebaseStorageRef.getDownloadURL();

        await firestoreClass.addUser(
            name: name,
            username: username,
            email: email,
            role: role,
            image: image,
            phoneNumber: phoneNumber,
            gender: gender);
        message = "Success";
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          message = "Password is too weak";
        } else if (e.code == 'email-already-in-use') {
          message = 'Email already registered';
        } else if (e.code == 'user-not-found') {
          message = 'Email or Password is incorrect';
        } else if (e.code == '') {
          message = 'No internet connection';
        } else if (e.code == 'network-request-failed') {
          message = 'No internet connection';
        } else {
     
      message = 'Authentication failed. Please try again.';
    }
        return message;
      } catch (e) {
        return e.toString();
      }
    } else {
      message = "Please fill up all the fields.";
    }
    return message;
  }

  Future<String> signIn(
      {required String email, required String password}) async {
    String message = '';
    if (email != "" && password != "") {
      try {
        await auth.signInWithEmailAndPassword(email: email, password: password);
        message = "Success";
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          message = 'No account was found for this email';
        } else if (e.code == 'wrong-password') {
          message = 'Username or password is incorrect';
        } else if (e.code == 'network-request-failed') {
          message = 'No internet connection';
        }
        else if (e.code == 'wrong-password') {
      message = 'Email or Password is incorrect';
    } else {
     
      message = 'Authentication failed. Please try again.';
    }
      } catch (e) {
        return e.toString();
      }
    } else {
      message = "Please fill up all the fields.";
    }
    return message;
  }
}
