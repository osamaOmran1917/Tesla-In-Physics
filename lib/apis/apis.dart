import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:omar_mostafa/models/exam.dart';
import 'package:omar_mostafa/models/my_user.dart';

class APIs {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static User get user => auth.currentUser!;

  static Future<bool> userExists() async {
    return (await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .get())
        .exists;
  }

  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final myUser = MyUser(
        image: user.photoURL.toString(),
        address: '',
        name: user.displayName.toString(),
        about: 'مرحبا. أنا طالب لدى أ. عمر',
        createdAt: time,
        lastActive: time,
        id: user.uid,
        isOnline: false,
        email: user.email.toString(),
        pushToken: '',
        phone_I: '',
        phone_II: '',
        is_student: true,
        lessons_num: 0,
        student_id: '',
        level: 0);
    return await firestore
        .collection('users')
        .doc(user.uid)
        .set(myUser.toJson());
  }

  static CollectionReference<Exam> getExamsCollection() {
    return firestore.collection(Exam.collectionName).withConverter<Exam>(
        fromFirestore: ((snapshot, options) {
          return Exam.fromFirestore(snapshot.data()!);
        }), toFirestore: (exam, options) {
      return exam.toFirestore();
    });
  }

  static CollectionReference<MyUser> getUsersCollection() {
    return firestore.collection('users').withConverter<MyUser>(
        fromFirestore: ((snapshot, options) {
          return MyUser.fromJson(snapshot.data()!);
        }), toFirestore: (user, options) {
      return user.toJson();
    });
  }

  static Future<void> insertExam(Exam exam) {
    var examsCollection = getExamsCollection();
    var doc = examsCollection.doc();
    exam.id = doc.id;
    return doc.set(exam);
  }

  static Stream<QuerySnapshot<Exam>> listenForExamsRealTimeUpdates(int level) {
    // Listen for realtime update
    return getExamsCollection()
        .where('level', isEqualTo: level)
        .snapshots();
  }

  static Stream<QuerySnapshot<MyUser>> listenForUsersRealTimeUpdates() {
    // Listen for realtime update
    return getUsersCollection().snapshots();
  }

  static setAsParent(String userId) {
    CollectionReference omarMustafaRef = getUsersCollection();
    omarMustafaRef.doc(userId).update({'is_student': false});
  }

  static updateStudentId(String userId, String studentId) {
    CollectionReference omarMustafaRef = getUsersCollection();
    omarMustafaRef.doc(userId).update({'student_id': studentId});
  }

  static updateLevel(String userId, int level) {
    CollectionReference omarMustafaRef = getUsersCollection();
    omarMustafaRef.doc(userId).update({'level': level});
  }

  static Future<bool> setStudentAsSon(String studentId) async {
    final data = await firestore
        .collection('users')
        .where('id', isEqualTo: studentId)
        .get();
    log('data: ${data.docs}');
    if (data.docs.isNotEmpty && data.docs.first.id != user.uid) {
      log('user exists: ${data.docs.first.data()}');
      firestore
          .collection('users')
          .doc(user.uid)
          .collection('my_students')
          .doc(data.docs.first.id)
          .set({});
      return true;
    } else {
      return false;
    }
  }

  static Future<MyUser?> getFutureOfUserById(String uid) async {
    var collection = getUsersCollection();
    var docRef = collection.doc(uid);
    var res = await docRef.get();
    return res.data();
  }
}