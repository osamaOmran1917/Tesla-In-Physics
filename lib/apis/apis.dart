import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:omar_mostafa/models/exam.dart';
import 'package:omar_mostafa/models/lessons.dart';
import 'package:omar_mostafa/models/my_user.dart';
import 'package:omar_mostafa/models/post.dart';
import 'package:omar_mostafa/models/strategy_post.dart';

class APIs {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static FirebaseStorage storage = FirebaseStorage.instance;

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
        phone: '',
        is_student: true,
        lessons_num: 0,
        student_id: '',
        level: 0,
        attendance: 0,
        absence: 0,
        male: true);
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
    return getExamsCollection().where('level', isEqualTo: level).snapshots();
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

  static updateName(String userId, String name) {
    CollectionReference omarMustafaRef = getUsersCollection();
    omarMustafaRef.doc(userId).update({'name': name});
  }

  static updatePhone(String userId, String phone) {
    CollectionReference omarMustafaRef = getUsersCollection();
    omarMustafaRef.doc(userId).update({'phone': phone});
  }

  static updateGender(String userId, bool male) {
    CollectionReference omarMustafaRef = getUsersCollection();
    omarMustafaRef.doc(userId).update({'male': male});
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

  static Future<void> deleteUser() async {
    await firestore.collection('users').doc(user.uid).delete();
    // deleteMissingPersonPicture(missingPersonId);
  }

  static Future<bool> checkStudentExistence(String studentId) async {
    final data = await firestore
        .collection('users')
        .where('id', isEqualTo: studentId)
        .get();
    log('data: ${data.docs}');
    if (data.docs.isNotEmpty && data.docs.first.id != user.uid) {
      log('user exists: ${data.docs.first.data()}');
      return true;
    } else {
      return false;
    }
  }

  static CollectionReference<Lesson> getLessonsCollection() {
    return FirebaseFirestore.instance
        .collection(Lesson.collectionName)
        .withConverter<Lesson>(fromFirestore: (snapshot, options) {
      return Lesson.fromFirestore(snapshot.data()!);
    }, toFirestore: (lesson, options) {
      return lesson.toFirestore();
    });
  }

  static Stream<QuerySnapshot<Lesson>> ListenForLessonsRealTimeUpdates() {
    // Listen for realtime update
    return getLessonsCollection()
        .orderBy("index", descending: true)
        .snapshots();
  }

  static CollectionReference<Post> getPostsCollection() {
    return FirebaseFirestore.instance
        .collection(Post.collectionName)
        .withConverter<Post>(fromFirestore: (snapshot, options) {
      return Post.fromFirestore(snapshot.data()!);
    }, toFirestore: (post, options) {
      return post.toFirestore();
    });
  }

  static CollectionReference<StrategyPost> getStrategyPostsCollection() {
    return FirebaseFirestore.instance
        .collection(StrategyPost.collectionName)
        .withConverter<StrategyPost>(fromFirestore: (snapshot, options) {
      return StrategyPost.fromFirestore(snapshot.data()!);
    }, toFirestore: (strategyPost, options) {
      return strategyPost.toFirestore();
    });
  }

  static Stream<QuerySnapshot<Post>> ListenForPostsRealTimeUpdates() {
    // Listen for realtime update
    return getPostsCollection()
        .orderBy("date_time", descending: false)
        .snapshots();
  }

  static Stream<QuerySnapshot<Post>> ListenForLevelPostsRealTimeUpdates(
      int level) {
    // Listen for realtime update
    return getPostsCollection().where('level', isEqualTo: level).snapshots();
  }

  static Stream<QuerySnapshot<StrategyPost>>
      ListenForLevelStrategyPostsRealTimeUpdates(int level) {
    // Listen for realtime update
    return getStrategyPostsCollection()
        .where('level', isEqualTo: level)
        .snapshots();
  }

  static Stream<QuerySnapshot<Post>> getFirstTwoPosts(int level) {
    // Listen for realtime update
    return getPostsCollection()
        .where('level', isEqualTo: level)
        .limit(2)
        .snapshots();
  }

  static Stream<QuerySnapshot<Post>> getFirstTwoPostsForOmar() {
    // Listen for realtime update
    return getPostsCollection()
        .orderBy("date_time", descending: false)
        .limit(2)
        .snapshots();
  }

  static Future<void> deletePost({required String id}) async {
    await firestore.collection('posts').doc(id).delete();
  }

  static Future<void> addPost(Post post) {
    var postsCollection = getPostsCollection();
    var doc = postsCollection.doc(); //create new doc
    post.id = doc.id;
    post.date_time = DateTime.now();
    return doc.set(post); // get doc -> then set //update
  }

  static Future<void> updateProfilePicture(File file) async {
    final ext = file.path.split('.').last;
    log('Extensions: $ext');
    final ref = storage.ref().child('profile_pictures/${user.uid}.$ext');
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      log('Data Transferred: ${p0.bytesTransferred / 1000} kb');
    });
    String image = await ref.getDownloadURL();
    await firestore.collection('users').doc(user.uid).update({'image': image});
  }

  static Future<void> addStrategyPost(StrategyPost strategyPost) {
    var strategyPostsCollection = getStrategyPostsCollection();
    var doc = strategyPostsCollection.doc(); //create new doc
    strategyPost.id = doc.id;
    strategyPost.date_time = DateTime.now();
    strategyPost.time = DateTime.now().millisecondsSinceEpoch.toString();
    return doc.set(strategyPost); // get doc -> then set //update
  }

  static Stream<QuerySnapshot<MyUser>>
      ListenForStudentsRealTimeUpdatesDependingOnLevel(int level) {
    // Listen for realtime update
    return getUsersCollection()
        .where('level', isEqualTo: level)
        .where('is_student', isEqualTo: true)
        .snapshots();
  }

  static Future<dynamic> getFieldValue(
      String documentId, String fieldName) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(documentId)
          .get();

      if (snapshot.exists) {
        dynamic fieldValue = snapshot.get(fieldName);
        return fieldValue;
      } else {
        return null;
      }
    } catch (e) {
      print('Error getting field value: $e');
      return null;
    }
  }

  static updateAttendance(String userId, int att) async {
    String documentId = userId;
    String fieldName = 'attendance';

    dynamic fieldValue = await getFieldValue(documentId, fieldName);

    if (fieldValue != null) {
      // Do something with the field value
      print('Field value: $fieldValue');
    } else {
      print('Document not found or field value is null');
    }
    CollectionReference omarMustafaRef = getUsersCollection();
    omarMustafaRef.doc(userId).update({'attendance': fieldValue + att});
  }
}
