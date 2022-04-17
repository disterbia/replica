import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:panda/model/user.dart';
import 'package:panda/provider/user_provider.dart';

class UserRepositoy {
  final UserProvider _userProvider = UserProvider();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  ConfirmationResult? confirmationResult;

  Future<void> logout() async => await _auth.signOut();

  Future<User> join(String email, String password, String username, String phoneNumber) async {
    UserCredential? userCredential;
    try{
       userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    }catch(e){

    }

    if (userCredential != null) {
      User principal = User(
          uid: userCredential.user!.uid,
          username: username,
          email: email,
          phoneNumber: phoneNumber,
          created: userCredential.user!.metadata.creationTime,
          updated: userCredential.user!.metadata.creationTime);
      await _userProvider.join(principal);
      return principal;
    }
    return User();
  }

  Future<User> login(String email, String password) async {
    UserCredential? userCredential;
    try {
      userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {}

    if (userCredential != null) {
      QuerySnapshot querySnapshot =
          await _userProvider.login(userCredential.user!.uid);

      List<QueryDocumentSnapshot> docs = querySnapshot.docs;

      if (docs.isNotEmpty) {
        User principal = User.fromJson(
            querySnapshot.docs.first.data() as Map<String, dynamic>);
        return principal;
      }
    }
    return User();
  }

  Future<User> findById(String id) async {
    QuerySnapshot querySnapshot = await _userProvider.findById(id);
    List<QueryDocumentSnapshot> docs = querySnapshot.docs;
    if (docs.isNotEmpty) {
      User principal = User.fromJson(
          querySnapshot.docs.first.data() as Map<String, dynamic>);
      return principal;
    }
    return User();
  }

  Future<bool> checkEmail(String email) async {
    QuerySnapshot querySnapshot = await _userProvider.checkEmail(email);
    return querySnapshot.docs.isEmpty ? true : false;
  }

  Future<bool> checkPhoneNumber(String phoneNumber) async {
    try {
      confirmationResult =
          await FirebaseAuth.instance.signInWithPhoneNumber("+82$phoneNumber");
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> checkCode(String code) async {
    try {
      UserCredential? userCredential = await confirmationResult?.confirm(code);
      print(userCredential);

      return userCredential == null ? false : true;
    } catch (e) {
      return false;
    }
  }

  Future<void> updatePoint(String uid) async {
    await _userProvider.updatePoint(uid);
  }

  Future<void> buyComplete(String uid ,int totalMoney,int point) async {
    await _userProvider.buyComplete(uid,totalMoney,point);
  }
}
