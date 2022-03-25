
import 'dart:math';

import 'package:box_house/models/agenda.dart';
import 'package:box_house/util/shared_preference.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
class UserService extends Model{

  FirebaseAuth _auth  = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  Map<String, dynamic> userData = Map();
  bool isLoading = false;

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    _loadCurrentUser();
  }

  getUsername() async {
    try {
      return SharedPreference.getData("userEmail");
    } catch (e) {}
    return null;
  }

  getUserpass()async{
    try {
      return SharedPreference.getData("userPass");
    } catch (e) {}
    return null;
  }

  void signUp( {@required Map<String, dynamic> userData, @required String pass, @required VoidCallback onSuccess, @required VoidCallback onFail}){
      isLoading = true;
      notifyListeners();
      _auth.createUserWithEmailAndPassword(
          email: userData["email"],
          password: pass).then((user) async{
            firebaseUser = user;
           await  _saveUserData(userData);
            onSuccess();
            isLoading = false;
            notifyListeners();
      }).catchError((e){
          onFail();
          isLoading = false;
          notifyListeners();
      });
  }

  void signIn({@required String email,@required String pass, @required VoidCallback onSuccess(userData), @required VoidCallback onFail}) async{
      isLoading = true;
      notifyListeners();
      _auth.signInWithEmailAndPassword(email: email, password: pass).then(
          (user) async{
              firebaseUser = user;
              await _loadCurrentUser();
              SharedPreference.setData("userEmail", email);
              SharedPreference.setData("userPass", pass);
              onSuccess(userData);
//              if(userData["active"] == "false"){
//                signOut();
//              }
              isLoading = false;
          }).catchError((e){
        onFail();
        isLoading = false;
        notifyListeners();
      });
  }

   void loaderUser() async{
     await _loadCurrentUser();
   }

  void recoverPass(String email){
    _auth.sendPasswordResetEmail(email: email);
  }

  bool isLoggedIn(){
    return firebaseUser != null;
  }

  void signOut() async{
    await _auth.signOut();
    userData = Map();
    firebaseUser = null;
    isLoading = false;
    notifyListeners();
  }

  Future<Null> _saveUserData( Map<String, dynamic> userData) async{
    this.userData = userData;
    await Firestore.instance.collection("users").document(firebaseUser.uid).setData(userData);
  }

  Future<Null> _loadCurrentUser() async{
    if(firebaseUser == null)
      firebaseUser = await _auth.currentUser();
    if(firebaseUser != null){
      if(userData["name"] == null){
        DocumentSnapshot docUser = await Firestore.instance.collection("users").document(firebaseUser.uid).get();
        userData = docUser.data;
      }
    }
    notifyListeners();
  }

}
