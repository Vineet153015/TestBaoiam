
import 'package:testbaoiam/Screens/Home/searchField.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:testbaoiam/Screens/Notification/Notification.dart';
import 'package:testbaoiam/Screens/ScreenSize.dart';

class HomeScreenAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String userName;

  HomeScreenAppBar({required this.userName});

  @override
  _HomeScreenAppBarState createState() => _HomeScreenAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 60); // Adjusted height for larger app bar
}

class _HomeScreenAppBarState extends State<HomeScreenAppBar> {
  String? userImageUrl;

  @override
  void initState() {
    super.initState();
    fetchUserImage();
  }

  Future<void> fetchUserImage() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Assume the image is stored with the user's UID as the filename
        Reference ref = FirebaseStorage.instance.ref().child('user_images/${user.uid}.jpg');
        String imageUrl = await ref.getDownloadURL();
        setState(() {
          userImageUrl = imageUrl;
        });
      }
    } catch (e) {
      print('Error fetching user image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSizeHelper = ScreenSizeHelper.of(context);
    return AppBar(
      backgroundColor: Colors.white,
      elevation: screenSizeHelper.blockSizeHorizontal*3,
      title: Row(
        children: [
          CircleAvatar(
            backgroundImage: userImageUrl != null
                ? NetworkImage(userImageUrl!)
                : AssetImage('assets/images/boy.png') as ImageProvider,
            radius: 20,
          ),
          SizedBox(width: 10),
          Text(
            'Welcome, ${widget.userName}',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: screenSizeHelper.blockSizeHorizontal *7),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.notifications_none, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotificationScreen()),
            );
          },
        ),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: GestureDetector(
            onTap: () {
              // Navigate to the SearchScreen when tapped
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Searchfield()),
              );
            },
            child: AbsorbPointer(
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  suffixIcon: Icon(Icons.mic_none_outlined, color: Colors.grey),
                  hintText: 'What do you want to learn?',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Color(0xFFF2F2F2),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
