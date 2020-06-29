import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firebase.dart' as fb;

import '../models/post.dart';

class PostRepository {
  static final Firestore _db = Firestore.instance;

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
    return _db.collection('posts').snapshots().map((snapshot) {
      return snapshot.documents.map((doc) => Post.fromDocument(doc)).toList()
        ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
    });
  }

  static Future<Uri> uploadImageFile(
      Uint8List imageBytes, String imageName, String extenstion) async {
    fb.StorageReference storageRef =
        fb.storage().ref('Posts/$imageName$extenstion');
    fb.UploadTaskSnapshot uploadTaskSnapshot =
        await storageRef.put(imageBytes).future;

    print('ana gwa al repo:  $imageName $extenstion');
    Uri imageUri = await uploadTaskSnapshot.ref.getDownloadURL();
    return imageUri;
  }

  static Future<void> addPost(Post post) async {
    DocumentReference ref = await _db.collection('posts').add(post.toMap());
    print('document id: ${ref.documentID}');
  }

  static Stream<List<Post>> getUsersFilter(String username)  {
    return _db.collection('posts').snapshots().map((snapshot) {
      return snapshot.documents
          .map((doc) => Post.fromDocument(doc))
          .where((element) => element.username == username).toList();

    });
  }

    static Stream<List<Post>> getHashtagsFilter(String hashtag) {
    return _db.collection('posts').snapshots().map((snapshot) {
      return snapshot.documents
          .map((doc) => Post.fromDocument(doc))
          .where((element) => element.hashtag == hashtag).toList();
    });
  }
}
