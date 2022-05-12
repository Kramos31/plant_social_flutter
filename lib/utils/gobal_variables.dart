import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plant_social_flutter/screens/add_post_screen.dart';
import 'package:plant_social_flutter/screens/feed_screen.dart';
import 'package:plant_social_flutter/screens/profile_screen.dart';
import 'package:plant_social_flutter/screens/search_screen.dart';
import 'package:plant_social_flutter/screens/contact_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  ContactScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];