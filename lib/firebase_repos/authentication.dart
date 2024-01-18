import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:bsims/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart' as path;
import 'cloud_firestore.dart';

class AuthenticationMethod {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirestoreClass firestoreClass = FirestoreClass();

  Future<String> signUp(
      {required String email,
      required String password,
      required String gender,
      required String username,
      required String role,
      required File pickedImage,
      required String phoneNumber,
      required String name}) async {
    String message = 'Something went wrong';
    email.trim();
    password.trim();
    if (name != "" && email != "" && password != "") {
      try {
        final userCredential = await auth.createUserWithEmailAndPassword(
            email: email, password: password);
 final fileName = path.basename(pickedImage.path);
      final firebaseStorageRef =
          firebase_storage.FirebaseStorage.instance.ref().child(fileName);
      await firebaseStorageRef.putFile(pickedImage);

      final image = await firebaseStorageRef.getDownloadURL();
        UserModel user = UserModel(
            name: name,
            username: username,
            email: email,
            role: role,
            image: image,
            gender: gender,
            phoneNumber: phoneNumber);
        await firestoreClass.addUser(user: user);
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
      } catch (e) {
        return e.toString();
      }
    } else {
      message = "Please fill up all the fields.";
    }
    return message;
  }
}
