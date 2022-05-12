import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plant_social_flutter/models/user.dart';
import 'package:plant_social_flutter/resources/fire_store_methods.dart';
import 'package:plant_social_flutter/utils/colors.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../widgets/contact_card.dart';

class MessageScreen extends StatefulWidget {
  final snap;
  const MessageScreen({Key? key, required this.snap}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final TextEditingController _msgController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _msgController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    return Container();
  }
}
