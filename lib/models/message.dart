import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String msg;
  final String uid;
  final String username;
  final String msgId;
  final msgDate;
  final String profImage;

  const Message({
    required this.msg,
    required this.uid,
    required this.username,
    required this.msgId,
    required this.msgDate,
    required this.profImage,
  });

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "uid": uid,
        "username": username,
        "msgId": msgId,
        "msgDate": msgDate,
        "profImage": profImage,
      };
  static Message fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Message(
      username: snapshot['username'],
      uid: snapshot['uid'],
      msg: snapshot['msg'],
      msgId: snapshot['msgId'],
      msgDate: snapshot['msgDate'],
      profImage: snapshot['profImage'],
    );
  }
}
