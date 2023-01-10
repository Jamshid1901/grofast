import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:grofast/model/product_model.dart';
import 'package:grofast/pages/product_screen.dart';
import 'package:grofast/style/style.dart';
import 'package:grofast/unit/image_network.dart';

class HorizontalProduct extends StatelessWidget {
  final ProductModel? product;

  const HorizontalProduct({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ProductScreen(productModel: product!),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24), color: Style.bgCategory),
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 8),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Hero(
                tag: product?.id ?? 0,
                child: CustomImageNetwork(
                  image: product?.image,
                ),
              ),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(product?.title ?? ""),
                ),
                Text((product?.price ?? 0).toString()),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
