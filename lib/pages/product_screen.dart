import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:grofast/model/product_model.dart';
import 'package:grofast/unit/image_network.dart';

class ProductScreen extends StatelessWidget {
  final ProductModel productModel;
  const ProductScreen({Key? key, required this.productModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Hero(
            tag: productModel.id ?? 0,
            child: CustomImageNetwork(
              image: productModel.image,
              height: 374,
              width: double.infinity,
              radius: 16,
            ),
          )
        ],
      ),
    );
  }
}
