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
        parent_requests: []);
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
        .orderBy("dateTime", descending: false)
        .snapshots();
  }

  static CollectionReference<MyUser> getUsersCollection() {
    return firestore.collection('users').withConverter<MyUser>(
        fromFirestore: (snapshot, options) {
      return MyUser.fromJson(snapshot.data()!);
    }, toFirestore: (myUser, options) {
      return myUser.toJson();
    });
  }

  static setAsParent(String userId) {
    CollectionReference omarMustafaRef = getUsersCollection();
    omarMustafaRef.doc(userId).update({'is_student': false});
  }
}
