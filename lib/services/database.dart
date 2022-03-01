import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:untitled/helper/constants.dart';

class DataBaseMethods {
  getUserByUserName(String username) async {
    return await Firestore.instance
        .collection('users')
        .where('name', isEqualTo: username)
        .getDocuments();
  }

  getUserByUserEmail(String userEmail) async {
    return await Firestore.instance
        .collection('users')
        .where('email', isEqualTo: userEmail)
        .getDocuments();
  }

  uploadUserInfo(userMap) {
    Firestore.instance.collection('users').add(userMap);
  }
  getConversationMessages(chatRoomId) async {
    return await Firestore.instance
        .collection('chatroom')
        .document(chatRoomId)
        .collection('chats')
        .orderBy('time', descending: true)
        .snapshots();
  }
  createChatRoom(String chatRoomId, chatRoomMap) {
    Firestore.instance
        .collection('chatroom')
        .document(chatRoomId)
        .setData(chatRoomMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  addConversationMessages(chatRoomId, messageMap) {
    Firestore.instance
        .collection('chatroom')
        .document(chatRoomId)
        .collection('chats')
        .add(messageMap)
        .catchError((e) {
      print(e);
    });
  }



  getChatRooms(String userName) async {
    return await Firestore.instance
        .collection('chatroom')
        .where('users', arrayContains: userName)
        .snapshots();
  }

  uploadTask(String destination, File file) async {
    try {
      final ref = await FirebaseStorage.instance.ref().child(destination);

      return ref.putFile(file);
    } catch (e) {
      print(e);
    }
  }
}
