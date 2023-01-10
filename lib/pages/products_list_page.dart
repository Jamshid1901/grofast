import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:grofast/model/product_model.dart';
import 'package:grofast/repository/get_info.dart';
import 'package:grofast/style/style.dart';
import 'package:grofast/unit/horizontal_product.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  List<ProductModel?>? lifOfProduct = [];
  List listOfCategory = [];
  int? currentCategory;
  bool isLoading = true;
  bool isLoadingProduct = false;
  bool isHorizontal = true;

  @override
  void initState() {
    getInformation();
    super.initState();
  }

  getInformation() async {
    isLoading = true;
    setState(() {});
    lifOfProduct = await GetInfo.getProduct();
    listOfCategory = await GetInfo.getCategory();
    isLoading = false;
    setState(() {});
  }

  getProductByCategory([String? title]) async {
    isLoadingProduct = true;
    setState(() {});
    lifOfProduct = title != null
        ? await GetInfo.getProductByCategory(title)
        : await GetInfo.getProduct();
    isLoadingProduct = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 24),
                        shrinkWrap: true,
                        itemCount: listOfCategory.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              if (currentCategory == index) {
                                currentCategory = null;
                                getProductByCategory();
                              } else {
                                getProductByCategory(listOfCategory[index]);
                                currentCategory = index;
                              }
                            },
                            child: Container(
                                margin: const EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                        color: currentCategory == index
                                            ? Colors.red
                                            : Colors.transparent),
                                    color: Style.bgCategory),
                                padding: const EdgeInsets.all(8),
                                child: Center(
                                    child: Text(listOfCategory[index] ?? ""))),
                          );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Text("All Product : ${currentCategory != null ? listOfCategory[currentCategory!] : ""}"),
                        IconButton(
                            onPressed: () {
                              isHorizontal = !isHorizontal;
                              setState(() {});
                            },
                            icon: Icon(isHorizontal ? Icons.menu : Icons.list))
                      ],
                    ),
                  ),
                  isLoadingProduct
                      ? const CircularProgressIndicator()
                      : isHorizontal
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: lifOfProduct?.length ?? 0,
                              itemBuilder: (context, index) {
                                return HorizontalProduct(
                                    product: lifOfProduct?[index]);
                              },
                            )
                          : GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: lifOfProduct?.length ?? 0,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              itemBuilder: (context, index) =>  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Hero(
                                        tag:  "${lifOfProduct?[index]?.id}GridView",
                                        child: Placeholder()),
                                  )),
                ],
              ),
            ),
    );
  }
}
