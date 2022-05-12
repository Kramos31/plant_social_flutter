import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plant_social_flutter/screens/message_screen.dart';
import 'package:plant_social_flutter/models/user.dart';
import 'package:plant_social_flutter/providers/user_provider.dart';
import 'package:plant_social_flutter/resources/fire_store_methods.dart';
import 'package:plant_social_flutter/utils/colors.dart';
import 'package:plant_social_flutter/utils/utils.dart';
import 'package:provider/provider.dart';

class ContactCard extends StatefulWidget {
  final snap;
  const ContactCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard> {
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    return Container(
      color: mobileBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MessageScreen(
              snap: widget.snap,
            ),
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 16,
              ).copyWith(right: 0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(
                      widget.snap['profImage'],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 8,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.snap['username'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                        DateFormat.yMMMd().format(
                          widget.snap['msgDate'].toDate(),
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                          color: secondaryColor,
                        )),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        "Last msg goes here...",
                        //style: TextStyle(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
