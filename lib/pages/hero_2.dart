import 'package:flutter/material.dart';

class HeroScreen extends StatelessWidget {
  const HeroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hero animation"),
      ),
      body:  Hero(
        tag: "1",
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.7),
            borderRadius: BorderRadius.circular(16)
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
