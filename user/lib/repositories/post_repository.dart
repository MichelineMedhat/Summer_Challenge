import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firebase.dart' as fb;

import '../models/post.dart';

class PostRepository {
  static final Firestore _db = Firestore.instance;
  static DocumentSnapshot lastPostSnapshot;
  static const POSTS_LIMIT = 8;

  static Stream<List<Post>> getUserPost(String username) {
    return _db
        .collection('posts')
        .where('username', isEqualTo: username)
        .snapshots()
        .map((snapshot) {
      return snapshot.documents.map((doc) => Post.fromDocument(doc)).toList()
        ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
    });
  }

  static Stream<List<Post>> getAllPosts() {
    if (lastPostSnapshot == null) {
      return _db
          .collection('posts')
          .orderBy("timestamp", descending: true)
          .limit(POSTS_LIMIT)
          .snapshots()
          .map((snapshot) {
        if (snapshot.documents.length != 0) {
          lastPostSnapshot = snapshot.documents[snapshot.documents.length - 1];
        }
        return snapshot.documents.map((doc) => Post.fromDocument(doc)).toList()
          ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
      });
    } else {
      return _db
          .collection('posts')
          .orderBy("timestamp", descending: true)
          .startAfterDocument(lastPostSnapshot)
          .limit(POSTS_LIMIT)
          .snapshots()
          .map((snapshot) {
        if (snapshot.documents.length != 0) {
          lastPostSnapshot = snapshot.documents[snapshot.documents.length - 1];
        }
        return snapshot.documents.map((doc) => Post.fromDocument(doc)).toList()
          ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
      });
    }
  }

  static void disposePagination(){
    lastPostSnapshot = null;
  }

  static Future<Uri> uploadImageFile(
      Uint8List imageBytes, String imageName, String extenstion) async {
    fb.StorageReference storageRef =
        fb.storage().ref('Posts/$imageName$extenstion');
    fb.UploadTaskSnapshot uploadTaskSnapshot =
        await storageRef.put(imageBytes).future;

    Uri imageUri = await uploadTaskSnapshot.ref.getDownloadURL();
    return imageUri;
  }

  static Future<void> addPost(Post post) async {
    DocumentReference ref = _db.collection('posts').document();
    post.id = ref.documentID;
    post.graded = '0';
    ref.setData(post.toMap());
  }

  static Future<void> deletePost(Post post) async {
    if (post.uri != null) {
      await fb.storage().refFromURL(post.uri).delete();
    }
    await _db.collection('posts').document(post.id).delete();
  }

  static Stream<List<Post>> getUsersFilter(String username) {
    return _db.collection('posts').snapshots().map((snapshot) {
      return snapshot.documents
          .map((doc) => Post.fromDocument(doc))
          .where((element) => element.username == username)
          .toList();
    });
  }

  static Stream<List<Post>> getHashtagsFilter(String hashtag) {
    return _db.collection('posts').snapshots().map((snapshot) {
      return snapshot.documents
          .map((doc) => Post.fromDocument(doc))
          .where((element) => element.hashtag == hashtag)
          .toList();
    });
  }
}
