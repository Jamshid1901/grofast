import 'package:flutter/material.dart';
import 'package:grofast/pages/card_page.dart';
import 'package:grofast/pages/persons.dart';
import 'package:grofast/pages/products_list_page.dart';
import 'package:grofast/pages/profile.dart';
import 'package:grofast/style/style.dart';
import 'package:proste_indexed_stack/proste_indexed_stack.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectIndex = 0;

  List<IndexedStackChild> list = [
    IndexedStackChild(child: const ProductListPage()),
    IndexedStackChild(child: const PersonsPage()),
    IndexedStackChild(child: const CardPage()),
    IndexedStackChild(child: const ProfilePage())
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProsteIndexedStack(
        index: selectIndex,
        children: list,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: const IconThemeData(color: Style.primaryColor),
        unselectedIconTheme: const IconThemeData(color: Style.greyColor),
        currentIndex: selectIndex,
        onTap: (value) {
          selectIndex = value;
          setState(() {});
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "")
        ],
      ),
    );
  }
}
