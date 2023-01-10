import 'package:flutter/material.dart';
import 'package:grofast/pages/hero_2.dart';

class HeroAnimation extends StatelessWidget {
  const HeroAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hero animation"),
      ),
      body:  Center(
        child: Hero(
          tag: "1",
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.7),
                borderRadius: BorderRadius.circular(16)
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const HeroScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
