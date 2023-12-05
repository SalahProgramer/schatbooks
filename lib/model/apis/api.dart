import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

import 'chat_user.dart';
import '../apis/post.dart';

class API  extends GetxService {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseStorage storage = FirebaseStorage.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static User get user => auth.currentUser!;

  static Future<bool> userExists() async {
    return (await firestore.collection('users').doc(user.uid).get()).exists;
  }

  static Future<void> createUser() async {
    final time = DateTime
        .now()
        .millisecondsSinceEpoch;
    final chatuser = ChatUser(
        id: user.uid,
        name: user.displayName.toString(),
        email: user.email.toString(),
        about: "I am using Schatbook",
        image: user.photoURL.toString(),
        createdAt: time.toString(),
        lastActive: time.toString(),
        isOnline: false,
        pushToken: "");
    print("fffffffffffffffffffffffffffffffffffffffffff");
    await firestore.collection('users').doc(user.uid).set(chatuser.toJson());
    createMyUsers();
    createMyPosts();
  }

  static Future<void> createMyUsers() async {
    await firestore
        .collection('users')
        .doc(user.uid)
        .collection('my_users')
        .doc()
        .set({});
  }

  static Future<void> createPost(String text) async {
    final time = DateTime
        .now()
        .millisecondsSinceEpoch;
    final post = Post(text: text.toString(),
        email: user.email.toString(),
        name: user.displayName.toString(),
        id: user.uid,
        CreateAt: time.toString(),
        images
            :[],
        imageUrl: user.photoURL.toString());
    await firestore.collection('users').doc(user.uid).collection('posts').doc(time.toString()).set(post.toJson());


  }

  static Future<void> createMyPosts() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    await firestore
        .collection('users')
        .doc(user.uid)
        .collection('posts')
        .doc(time)
        .set({
      "Create_at": time.toString(),
      "images": [],
      "email": API.user.email,
      "id": user.uid,
      "imageUrl": API.user.photoURL,
      "name": API.user.displayName,
      "text": "Welcome to Schatbook🙂"
    });
  }
  static String getConversationID(String id) => user.uid.hashCode <= id.hashCode
      ? '${user.uid}_$id'
      : '${id}_${user.uid}';
  static Future<void> SaveImage(File file,String time) async {
    final ext = file.path.split('.').last;
    final ref = storage.ref().child(
        'imagesPosts/${getConversationID(user.uid)}/${DateTime.now().millisecondsSinceEpoch}.$ext');
    await ref.putFile(file, SettableMetadata(contentType: 'image/$ext'));
    final imageUrl = await ref.getDownloadURL();
    DocumentReference docRef=firestore.collection('users').doc(user.uid).collection('posts').doc(time);
    docRef.update({"images": FieldValue.arrayUnion([imageUrl])});

    // await API.sendMessage(chatUser, imageUrl, Type.image);
  }
  static Future<void> SavedPost(
      String Text) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final Post post = Post(
        CreateAt: time.toString(),
        imageUrl: user.photoURL.toString(),
        images: [],
        id: user.uid,
        name: user.displayName.toString(),
        email: user.email.toString(),
        text: Text.toString()
    );
    final ref = firestore
        .collection('users/${user.uid}/posts/');
    await ref.doc(time).set(post.toJson());


  }


  static Future<void> SavedPostWithPicture(
      String Text, List<XFile>? images) async {

    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final Post post = Post(
        CreateAt: time.toString(),
        imageUrl: user.photoURL.toString(),
        images: [],
        id: user.uid,
        name: user.displayName.toString(),
        email: user.email.toString(),
        text: Text.toString()
    );
    final ref = firestore
        .collection('users/${user.uid}/posts/');
    await ref.doc(time).set(post.toJson());
    for (var i in images!) {

      await API.SaveImage(File(i.path),time);


    }

  }
  static Future<void> SavedPostWithCamera(
      String Text, XFile? images) async {

    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final Post post = Post(
        CreateAt: time.toString(),
        imageUrl: user.photoURL.toString(),
        images: [],
        id: user.uid,
        name: user.displayName.toString(),
        email: user.email.toString(),
        text: Text.toString()
    );
    final ref = firestore
        .collection('users/${user.uid}/posts/');
    await ref.doc(time).set(post.toJson());


    await API.SaveImage(File(images!.path),time);




  }
  static Future<CollectionReference<Object?>> getAllpostsFuture() async{
    CollectionReference userData= await firestore
        .collection('users/${user.uid}/posts/');
    return userData;

  }
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMyposts() {
    return
      firestore
          .collection('users/${user.uid}/posts/').orderBy('Create_at',descending: true)
          .snapshots();

  }
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMypostsanother() {
    return
      firestore
          .collection('users/rXFU2kT0jXYMyEkjrouhj7xXAgC2/posts/').orderBy('Create_at',descending: true)
          .snapshots();

  }
  static Future<void> deletePost(Post post) async {
    await firestore
        .collection('users/${user.uid}/posts/')
        .doc(post.CreateAt)
        .delete();
    print(post.images.length);
    if (post.images.isNotEmpty) {
      await storage.refFromURL(post.images[0]).delete();
    }
  }
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllusers() {
    return firestore
        .collection('users').where('email',isNotEqualTo: auth.currentUser?.email.toString())
        .snapshots();
  }

  static  Future<List<Post>> getAllPostusers() async {
    List<Post> list1=[];
    List<ChatUser> listUser=[];

    var users= await firestore
        .collection('users').where('email',isNotEqualTo: auth.currentUser?.email.toString())
        .get();

    for(int i=0;i<users.size;i++){
      var d = users.docs;
      listUser = d
          .map((e) => ChatUser.fromJson(e.data()))
          .toList() ??
          [];
      var posts=await firestore
          .collection('users/${listUser[0].id}/posts/').orderBy('Create_at',descending: true)
          .get();
      var  list2 =
          posts.docs.map((e) => Post.fromJson(e.data())).toList() ?? [];

      list1.addAll(list2);


    }
    print(list1.length);
    return list1;
  }

}
