import 'package:flutter/material.dart';
import 'package:grofast/model/new_product_model.dart';
import 'package:grofast/model/product_model.dart';
import 'package:grofast/repository/get_info.dart';
import 'package:grofast/unit/horizontal_product.dart';

import '../store/local_store.dart';

class CardPage extends StatefulWidget {
  const CardPage({Key? key}) : super(key: key);

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  bool isLoading = true;
  List<ProductModel?>? lifOfProduct = [];

  @override
  void initState() {
    getInformation();
    super.initState();
  }

  getInformation() async {
    isLoading = true;
    setState(() {});
    List<String> localList = await LocalStore.getLikeList();
    for (var element in localList) {
      ProductModel? newDate = await GetInfo.getSingleProduct(element);
      newDate?.like = true;
      lifOfProduct?.add(newDate);
    }
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Like"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              shrinkWrap: true,
              itemCount: lifOfProduct?.length ?? 0,
              itemBuilder: (context, index) {
                return HorizontalProduct(
                  product: lifOfProduct?[index],
                  onLikeInLikePage: () {
                    Future.delayed(const Duration(milliseconds: 500), () {
                      lifOfProduct?.removeAt(index);
                      setState(() {});
                    });
                  },
                );
              },
            ),
    );
  }
}
