import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guardiancare/screens/forum/forum_page.dart';
import 'package:guardiancare/screens/homepage/home_page.dart';
import 'package:guardiancare/screens/Report/report_page.dart';

class Pages extends StatefulWidget {
  const Pages({super.key});

  @override
  State<Pages> createState() => _PagesState();
}

class _PagesState extends State<Pages> {
  int _index = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late User? _user;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: CustomAppBar(user: _user),
      body: SafeArea(
        child: IndexedStack(
          index: _index,
          children: const [
            HomePage(),
            ReportPage(),
            ForumPage(),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _index,
        onTap: (index) => setState(() => _index = index),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final User? user;

  const CustomAppBar({super.key, required this.user});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Guardian Care"),
      backgroundColor: Colors.white,
      centerTitle: true,
      actions: [
        if (user != null) _signOutButton(context) else const Text("Hi"),
      ],
    );
  }

  Widget _signOutButton(BuildContext context) {
    return TextButton(
      onPressed: () => FirebaseAuth.instance.signOut(),
      child: const Text("Sign Out"),
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      items: const [
        Icon(Icons.home, size: 25, color: Colors.amber),
        Icon(Icons.report, size: 25, color: Colors.amber),
        Icon(Icons.forum, size: 25, color: Colors.amber),
      ],
      backgroundColor: Colors.transparent,
      color: Colors.blue,
      height: 65,
      index: currentIndex,
      onTap: onTap,
    );
  }
}
