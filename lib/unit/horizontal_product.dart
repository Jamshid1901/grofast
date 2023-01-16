import 'package:flutter/material.dart';
import 'package:grofast/model/product_model.dart';
import 'package:grofast/pages/product_screen.dart';
import 'package:grofast/store/local_store.dart';
import 'package:grofast/style/style.dart';
import 'package:grofast/unit/image_network.dart';

class HorizontalProduct extends StatefulWidget {
  final ProductModel? product;
  final VoidCallback onLikeInLikePage;
  const HorizontalProduct({Key? key, required this.product, required this.onLikeInLikePage}) : super(key: key);

  @override
  State<HorizontalProduct> createState() => _HorizontalProductState();
}

class _HorizontalProductState extends State<HorizontalProduct> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ProductScreen(productModel: widget.product!),
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
                tag: widget.product?.id ?? 0,
                child: CustomImageNetwork(
                  image: widget.product?.image,
                ),
              ),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(widget.product?.title ?? ""),
                ),
                Text((widget.product?.price ?? 0).toString()),
              ],
            )),
            IconButton(
              onPressed: () {
                if (widget.product?.like ?? false) {
                  widget.product?.like = !(widget.product?.like ?? false);
                  LocalStore.removeLikeList(widget.product?.id ?? 0);
                  widget.onLikeInLikePage();
                  setState(() {});
                } else {
                  widget.product?.like = !(widget.product?.like ?? false);
                  LocalStore.setLikeList(widget.product?.id ?? 0);
                  setState(() {});
                }
              },
              icon: Icon(
                (widget.product?.like ?? false)
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}
