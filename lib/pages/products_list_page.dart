import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:grofast/model/new_product_model.dart';
import 'package:grofast/model/product_model.dart';
import 'package:grofast/repository/get_info.dart';
import 'package:grofast/store/local_store.dart';
import 'package:grofast/style/style.dart';
import 'package:grofast/unit/horizontal_product.dart';
import 'package:grofast/unit/image_network.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late RefreshController refreshController;
  List<ProductModel?>? lifOfProduct = [];
  NewProductModel? newProductModel;
  List listOfCategory = [];
  int? currentCategory;
  bool isLoading = true;
  bool isLoadingProduct = false;
  bool isHorizontal = true;
  int pageIndex = 1;

  @override
  void initState() {
    getInformation();
    refreshController = RefreshController();
    super.initState();
  }

  getInformationNew() async {
    pageIndex = 1;
    isLoading = true;
    setState(() {});
    newProductModel = await GetInfo.getProductNew(pageIndex);
    isLoading = false;
    setState(() {});
  }

  getPageProduct(RefreshController controller) async {
    NewProductModel? newData = await GetInfo.getProductNew(++pageIndex);
    if (newData?.data != null && newData!.data!.isNotEmpty) {
      newProductModel!.data!.addAll(newData.data!);
      controller.loadComplete();
    } else {
      controller.loadNoData();
    }
    setState(() {});
  }

  getInformation() async {
    isLoading = true;
    setState(() {});
    lifOfProduct = await GetInfo.getProduct();
    listOfCategory = await GetInfo.getCategory();
    List<String> localList = await LocalStore.getLikeList();
    lifOfProduct?.forEach((element) {
      if (localList.contains(element?.id.toString())) {
        element?.like = true;
      } else {
        element?.like = false;
      }
    });
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
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              onLoading: () async {
                await getPageProduct(refreshController);
              },
              onRefresh: () async {
                await getInformationNew();
                refreshController.refreshCompleted();
              },
              controller: refreshController,
              child: SingleChildScrollView(
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
                                      child:
                                          Text(listOfCategory[index] ?? ""))),
                            );
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              "All Product : ${currentCategory != null ? listOfCategory[currentCategory!] : ""}"),
                          IconButton(
                              onPressed: () {
                                isHorizontal = !isHorizontal;
                                setState(() {});
                              },
                              icon:
                                  Icon(isHorizontal ? Icons.menu : Icons.list))
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
                                  return Slidable(
                                    key: UniqueKey(),
                                    startActionPane: ActionPane(
                                      motion: const ScrollMotion(),
                                      dismissible:
                                          DismissiblePane(onDismissed: () {
                                        lifOfProduct!.removeAt(index);
                                        //share
                                      }),
                                      children: [
                                        SlidableAction(
                                          onPressed: (s) {
                                            lifOfProduct!.removeAt(index);
                                            setState(() {});
                                          },
                                          backgroundColor: Color(0xFFFE4A49),
                                          foregroundColor: Colors.white,
                                          icon: Icons.delete,
                                          label: 'Delete',
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ],
                                    ),
                                    child: HorizontalProduct(
                                      product: lifOfProduct?[index],
                                      onLikeInLikePage: () {},
                                    ),
                                  );
                                },
                              )
                            : GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: newProductModel?.data?.length ?? 0,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2),
                                itemBuilder: (context, index) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.lightBlue,
                                          border:
                                              Border.all(color: Style.black),
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.elliptical(
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  100),
                                              bottomRight: Radius.elliptical(
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  100)),
                                        ),
                                      ),
                                    )),
                  ],
                ),
              ),
            ),
    );
  }
}
