import 'package:flutter/material.dart';
import 'package:grofast/repository/get_info.dart';

import '../model/person_model.dart';

class PersonsPage extends StatefulWidget {
  const PersonsPage({Key? key}) : super(key: key);

  @override
  State<PersonsPage> createState() => _PersonsPageState();
}

class _PersonsPageState extends State<PersonsPage> {
  List<PersonModel?>? list = [];
  bool isLoading = true;

  @override
  void initState() {
    getInfo();
    super.initState();
  }

  getInfo() async {
    isLoading = true;
    setState(() {});
    list = await GetInfo.getPersons();
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ertyuiop["),
      ),



      body: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          itemCount: list?.length ?? 0,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(color: Colors.lightBlue),
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(list?[index]?.username ?? ""),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(list?[index]?.name?.firstname ?? ""),
                  ),
                  Text(list?[index]?.name?.lastname ?? ""),
                ],
              ),
            );
          }),
    );
  }
}
