import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TodoService {
  static final _db = FirebaseFirestore.instance;
  static final _auth = FirebaseAuth.instance;

  // Get Todos (Stream)
  static Stream<QuerySnapshot> getTodos() {
    final user = _auth.currentUser;
    if (user == null) {
      return const Stream.empty();
    }
    return _db
        .collection('todos')
        .where('uid', isEqualTo: user.uid)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  // Add Todo
  static Future<void> addTodo(String title, String category) async {
    final user = _auth.currentUser;
    if (user == null) return;
    
    await _db.collection('todos').add({
      'uid': user.uid,
      'title': title,
      'category': category,
      'isDone': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // Update Todo
  static Future<void> updateTodo(String id, String title, String category) async {
    await _db.collection('todos').doc(id).update({
      'title': title,
      'category': category,
    });
  }

  // Toggle Done
  static Future<void> toggleDone(String id, bool currentVal) async {
    await _db.collection('todos').doc(id).update({
      'isDone': !currentVal,
    });
  }

  // Delete Todo
  static Future<void> deleteTodo(String id) async {
    await _db.collection('todos').doc(id).delete();
  }
}