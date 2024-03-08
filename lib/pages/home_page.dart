import 'package:chat_pdf_subtivios/pages/chatpdf1.dart';
import 'package:chat_pdf_subtivios/pages/chatpdf2.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CHATPDF"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyApp1(),
                  ),
                );
              },
              child: Text("CHATGPT1"),
            ),
            SizedBox(height: 40,),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyApp2(),
                  ),
                );
              },
              child: Text("CHATGPT2"),
            ),
          ],
        ),
      ),
    );
  }
}
