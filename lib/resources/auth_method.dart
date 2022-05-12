import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plant_social_flutter/resources/storage_method.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:plant_social_flutter/models/user.dart' as model;
import 'storage_method.dart';
import 'package:uuid/uuid.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();
    return model.User.fromSnap(snap);
  }

  // sign up user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty) {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(cred.user!.uid);
        // add user to our database
        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

        model.User user = model.User(
          username: username,
          uid: cred.user!.uid,
          email: email,
          bio: bio,
          photoUrl: photoUrl,
          following: [],
          followers: [],
        );
        await _firestore.collection('users').doc(cred.user!.uid).set(
              user.toJson(),
            );

        res = "success";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = 'The email is poorly formatted.';
      } else if (err.code == 'weak-password') {
        res = 'Your password should be 6 characters';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //logging in user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    }
    // on FirebaseAuthException catch(e){
    //   if(e.code == 'wrong-password'){

    //   }
    // }
    catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> sendMessage(String suid, String msg, String ruid, String name,
      String profilePic) async {
    try {
      if (msg.isNotEmpty) {
        String msgId = const Uuid().v1();
        _firestore
            .collection('users')
            .doc(suid) //store messages by sender
            .collection('msg_users') //people we send messages to
            .doc(ruid)
            .collection('messages')
            .doc(msgId)
            .set({
          'profilePic': profilePic,
          //s'name': name,
          's_uid': suid, //sender of message
          'r_uid': ruid, //receiver of message
          'msg': msg,
          'msgId': msgId,
          'msgDate': DateTime.now(),
        });
      } else {
        print('Message is empty');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
