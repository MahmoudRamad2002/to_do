import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do/models/Task_module.dart';
import 'package:to_do/models/user-module.dart';

class firebaseFunction {
  static CollectionReference<TaskModel> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection("Tasks")
        .withConverter<TaskModel>(
      fromFirestore: (snapshot, options) {
        return TaskModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, options) {
        return value.toJson();
      },
    );
  }

  static Stream<QuerySnapshot<TaskModel>> getTaskfromFirestore(DateTime date) {
    var collection = getTasksCollection();
    return collection
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('date',
            isEqualTo: DateUtils.dateOnly(date).millisecondsSinceEpoch)
        .snapshots();
  }

  static Future<void> addTask(TaskModel taskModel) {
    var collection = getTasksCollection();
    var docRef = collection.doc();
    taskModel.id = docRef.id;
    return docRef.set(taskModel);
  }

  static Future<void> deletTask(String id) {
    return getTasksCollection().doc(id).delete();
  }

  static Future<void> updateTask(String id, TaskModel task) {
    return getTasksCollection().doc(id).update(task.toJson());
  }

  static Future<void> deleteOldTask() async {
    QuerySnapshot<TaskModel> taskSnap = await getTasksCollection()
        .where('date',
            isLessThan:
                DateUtils.dateOnly(DateTime.now()).millisecondsSinceEpoch)
        .get();
    var task = taskSnap.docs.map((e) => e.data()).toList();
    task.forEach(
      (element) {
        getTasksCollection().doc(element.id).delete();
      },
    );
  }

  static CollectionReference<UserModel> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection("Users")
        .withConverter<UserModel>(
      fromFirestore: (snapshot, options) {
        return UserModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, options) {
        return value.toJson();
      },
    );
  }

  static Future<void> addUserToFirebase(UserModel userModel) {
    var collection = getUsersCollection();
    var docRef = collection.doc(userModel.id);
    // userModel.id = docRef.id;
    return docRef.set(userModel);
  }

  static Future<UserModel?> readUser(String id) async {
    DocumentSnapshot<UserModel> userQuery =
        await getUsersCollection().doc(id).get();
    UserModel? userModel = userQuery.data();
    return userModel;
  }

  static Future<void> creatAuthantionEmail(String name, String email,
      String age, String password, Function afterAddToFirestore) async {
    try {
      var Credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      UserModel userModel = UserModel(
        id: Credential.user!.uid,
        name: name,
        email: email,
        age: age,
      );
      addUserToFirebase(userModel).then((value) {
        afterAddToFirestore();
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('the password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('the accout already exists for that email');
      }
    } catch (e) {
      print(e);
    }
  }

  static void getUserLogin(String emailAddress, String password,
      Function UserNotFoundit, Function getUser) async {
    try {
      var credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      readUser(credential.user!.uid).then((value) {
        getUser(value);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        UserNotFoundit();
        //print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        UserNotFoundit();
      }
    }
  }
}

/*FirebaseAuth.instance
    .authStateChanges()
    .listen((User? user) {
if (user == null) {
print('User is currently signed out!');
} else {
print('User is signed in!');
}
});
try {
  final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: emailAddress,
    password: password,
  );
} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    print('The password provided is too weak.');
  } else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
  }
} catch (e) {
  print(e);
}*/
