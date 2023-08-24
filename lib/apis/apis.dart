import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart';
import 'package:omar_mostafa/models/exam.dart';
import 'package:omar_mostafa/models/lesson.dart';
import 'package:omar_mostafa/models/my_user.dart';
import 'package:omar_mostafa/models/post.dart';
import 'package:omar_mostafa/models/strategy_post.dart';

class APIs {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static FirebaseStorage storage = FirebaseStorage.instance;

  static User get user => auth.currentUser!;

  static FirebaseMessaging fMessaging = FirebaseMessaging.instance;

  static Future<void> getFirebaseMessagingToken() async {
    await fMessaging.requestPermission();
    await fMessaging.getToken().then((t) {
      if (t != null) {
        setPushToken(user.uid, t);
        log('Push Token: $t\n----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------');
      }
    });
  }

  static Future<void> sendPushNotification(
      String pushToken, String name, String msg) async {
    try {
      final body = {
        "to": pushToken,
        "notification": {"title": name, "body": msg}
      };
      var res = await post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader:
                'key=AAAADI31O_U:APA91bG70ZBnTlhYBr7pTdZDC8RunV-fcA3IkLsnSd72bzUZyPn-_W8gVu7ieVXs0-xP6IDGH--s0nnJ0s-f6VmClPV_ReGrz_5lkWH4IhbetXJIkAgPFuRKs5Hy9I9vSpcpqmHGxGeM'
          },
          body: jsonEncode(body));
      log('Response status: ${res.statusCode}');
      log('Response body: ${res.body}');
    } catch (e) {
      log('\nsendPushNotificationE: $e');
    }
  }

  static Future<List<dynamic>> getPushTokens(int level) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('level', isEqualTo: level)
        .get();

    List<dynamic> fieldValues = [];
    for (QueryDocumentSnapshot document in snapshot.docs) {
      dynamic fieldValue = document.get('pushToken');

      fieldValues.add(fieldValue);
    }

    return fieldValues;
  }

  static Future<List<dynamic>> getNames(int level) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('level', isEqualTo: level)
        .get();

    List<dynamic> fieldValues = [];
    for (QueryDocumentSnapshot document in snapshot.docs) {
      dynamic fieldValue = document.get('name');

      fieldValues.add(fieldValue);
    }

    return fieldValues;
  }

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
      male: true,
      jan_1: 0,
      jan_2: 0,
      jan_3: 0,
      jan_4: 0,
      jan_5: 0,
      jan_6: 0,
      jan_7: 0,
      jan_8: 0,
      jan_9: 0,
      jan_10: 0,
      jan_11: 0,
      jan_12: 0,
      feb_1: 0,
      feb_2: 0,
      feb_3: 0,
      feb_4: 0,
      feb_5: 0,
      feb_6: 0,
      feb_7: 0,
      feb_8: 0,
      feb_9: 0,
      feb_10: 0,
      feb_11: 0,
      feb_12: 0,
      mar_1: 0,
      mar_2: 0,
      mar_3: 0,
      mar_4: 0,
      mar_5: 0,
      mar_6: 0,
      mar_7: 0,
      mar_8: 0,
      mar_9: 0,
      mar_10: 0,
      mar_11: 0,
      mar_12: 0,
      apr_1: 0,
      apr_2: 0,
      apr_3: 0,
      apr_4: 0,
      apr_5: 0,
      apr_6: 0,
      apr_7: 0,
      apr_8: 0,
      apr_9: 0,
      apr_10: 0,
      apr_11: 0,
      apr_12: 0,
      may_1: 0,
      may_2: 0,
      may_3: 0,
      may_4: 0,
      may_5: 0,
      may_6: 0,
      may_7: 0,
      may_8: 0,
      may_9: 0,
      may_10: 0,
      may_11: 0,
      may_12: 0,
      jun_1: 0,
      jun_2: 0,
      jun_3: 0,
      jun_4: 0,
      jun_5: 0,
      jun_6: 0,
      jun_7: 0,
      jun_8: 0,
      jun_9: 0,
      jun_10: 0,
      jun_11: 0,
      jun_12: 0,
      jul_1: 0,
      jul_2: 0,
      jul_3: 0,
      jul_4: 0,
      jul_5: 0,
      jul_6: 0,
      jul_7: 0,
      jul_8: 0,
      jul_9: 0,
      jul_10: 0,
      jul_11: 0,
      jul_12: 0,
      aug_1: 0,
      aug_2: 0,
      aug_3: 0,
      aug_4: 0,
      aug_5: 0,
      aug_6: 0,
      aug_7: 0,
      aug_8: 0,
      aug_9: 0,
      aug_10: 0,
      aug_11: 0,
      aug_12: 0,
      sep_1: 0,
      sep_2: 0,
      sep_3: 0,
      sep_4: 0,
      sep_5: 0,
      sep_6: 0,
      sep_7: 0,
      sep_8: 0,
      sep_9: 0,
      sep_10: 0,
      sep_11: 0,
      sep_12: 0,
      oct_1: 0,
      oct_2: 0,
      oct_3: 0,
      oct_4: 0,
      oct_5: 0,
      oct_6: 0,
      oct_7: 0,
      oct_8: 0,
      oct_9: 0,
      oct_10: 0,
      oct_11: 0,
      oct_12: 0,
      nov_1: 0,
      nov_2: 0,
      nov_3: 0,
      nov_4: 0,
      nov_5: 0,
      nov_6: 0,
      nov_7: 0,
      nov_8: 0,
      nov_9: 0,
      nov_10: 0,
      nov_11: 0,
      nov_12: 0,
      dec_1: 0,
      dec_2: 0,
      dec_3: 0,
      dec_4: 0,
      dec_5: 0,
      dec_6: 0,
      dec_7: 0,
      dec_8: 0,
      dec_9: 0,
      dec_10: 0,
      dec_11: 0,
      dec_12: 0,
      likes: [],
      paid: false,
    );
    return await firestore
        .collection('users')
        .doc(user.uid)
        .set(myUser.toJson());
  }

  static CollectionReference<MyUser> getUsersCollection() {
    return firestore.collection('users').withConverter<MyUser>(
        fromFirestore: ((snapshot, options) {
          print('########################${snapshot.data()}');
      return MyUser.fromJson(snapshot.data()!);
    }), toFirestore: (user, options) {
      return user.toJson();
    });
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

  static CollectionReference<Exam> getExamsCollection() {
    return FirebaseFirestore.instance
        .collection(Exam.collectionName)
        .withConverter<Exam>(fromFirestore: (snapshot, options) {
      return Exam.fromFirestore(snapshot.data()!);
    }, toFirestore: (exam, options) {
      return exam.toFirestore();
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

  static Stream<QuerySnapshot<Lesson>> ListenForLevelLessonsRealTimeUpdates(
      int level) {
    // Listen for realtime update
    return getLessonsCollection().where('level', isEqualTo: level).snapshots();
  }

  static Stream<QuerySnapshot<StrategyPost>>
      ListenForStrategyPostsRealTimeUpdates() {
    // Listen for realtime update
    return getStrategyPostsCollection()
        .orderBy("date_time", descending: true)
        .snapshots();
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

  static Future<void> deleteStrategyPost({required String id}) async {
    await firestore.collection('strategy_posts').doc(id).delete();
  }

  static Future<void> addPost(Post post) {
    var postsCollection = getPostsCollection();
    var doc = postsCollection.doc(); //create new doc
    post.id = doc.id;
    post.date_time = DateTime.now();
    return doc.set(post); // get doc -> then set //update
  }

  static Future<void> addLesson(Lesson lesson) {
    var lessonsCollection = getLessonsCollection();
    var doc = lessonsCollection.doc(); //create new doc
    lesson.id = doc.id;
    return doc.set(lesson); // get doc -> then set //update
  }

  static Future<void> addExam(Exam exam) async {
    var examsCollection = getExamsCollection();
    var doc = examsCollection.doc(); //create new doc
    exam.id = doc.id;
    return doc.set(exam); // get doc -> then set //update
  }

  static Future<void> addExamImage(Exam exam, File file) async {
    final ext = file.path.split('.').last;
    log('Extensions: $ext');
    final ref = storage.ref().child('exams_pictures/${exam.id}.$ext');
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      log('Data Transferred: ${p0.bytesTransferred / 1000} kb');
    });
    String image = await ref.getDownloadURL();
    await firestore.collection('exams').doc(exam.id).update({'image': image});
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

  static Stream<QuerySnapshot<Exam>>
      ListenForExamsRealTimeUpdatesDependingOnLevel(int level) {
    // Listen for realtime update
    return getExamsCollection().where('level', isEqualTo: level).snapshots();
  }

  static Stream<QuerySnapshot<Exam>>
      ListenForExamsRealTimeUpdatesDependingOnStudent(String studentId) {
    // Listen for realtime update
    return getExamsCollection()
        .where('student_id', isEqualTo: studentId)
        .snapshots();
  }

  static updateAttendance(String userId, int att, String lec) async {
    CollectionReference omarMustafaRef = getUsersCollection();
    omarMustafaRef.doc(userId).update({lec: att});
  }

  static Future<void> deleteExam(Exam exam) async {
    await firestore.collection('exams').doc(exam.id).delete();
  }

  static Future<void> deleteExamImage(Exam exam) async {
    await storage.refFromURL(exam.image!).delete();
  }

  static updateLikes(String userId, List likes) async {
    CollectionReference omarMustafaRef = getUsersCollection();
    omarMustafaRef.doc(userId).update({'likes': likes});
  }

  static setPushToken(String userId, String token) async {
    CollectionReference omarMustafaRef = getUsersCollection();
    omarMustafaRef.doc(userId).update({'pushToken': token});
  }

  static updatePayment(String userId, bool payment) async {
    CollectionReference omarMustafaRef = getUsersCollection();
    omarMustafaRef.doc(userId).update({'paid': payment});
  }
}
