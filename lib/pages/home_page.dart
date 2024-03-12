import 'package:chat_pdf_subtivios/pages/chatpdf1.dart';
import 'package:chat_pdf_subtivios/pages/chatpdf2.dart';
import 'package:chat_pdf_subtivios/pages/chatpdf3.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final List _screens = [
    ChatPDF(),
    SmallPDF(),
    Askyourpdf(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            bottomNavigationBar: CurvedNavigationBar(
              key: _bottomNavigationKey,
              index: _page,
              items: [
                CurvedNavigationBarItem(
                    child: Icon(
                      Icons.picture_as_pdf,
                      color: Colors.white,
                    ),
                    label: 'Chat PDF',
                    labelStyle: TextStyle(
                        color: Colors
                            .white) // Use title instead of label for accessibility
                    ),
                CurvedNavigationBarItem(
                    child: Icon(
                      Icons.picture_as_pdf,
                      color: Colors.white,
                    ),
                    label: 'Small PDF',
                    labelStyle: TextStyle(color: Colors.white)),
                CurvedNavigationBarItem(
                    child: Icon(
                      Icons.picture_as_pdf,
                      color: Colors.white,
                    ),
                    label: 'Ask your PDF',
                    labelStyle: TextStyle(color: Colors.white)),
              ],
              color: Colors.black,
              buttonBackgroundColor: Colors.black,
              backgroundColor: Colors.pink,
              animationCurve: Curves.ease,
              animationDuration: Duration(milliseconds: 200),
              onTap: (index) => _handlePageChange(index),
            ),
            body: _screens[_page]));
  }

  void _handlePageChange(int index) {
    setState(() {
      _page = index;
    });
    _bottomNavigationKey.currentState?.setPage(index); // Update navigation bar
  }
}
