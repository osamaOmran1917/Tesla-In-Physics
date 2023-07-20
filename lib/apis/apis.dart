import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
        lessons_num: 0);
    return await firestore
        .collection('users')
        .doc(user.uid)
        .set(myUser.toJson());
  }

  /*static Future<void> createExam(String date) async {
    final exam = Exam(date: date);
    return await firestore
        .collection('exams')
        .doc(exam.)
        .set(myUser.toJson());
  }*/

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
