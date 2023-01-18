import 'dart:convert';

import 'package:grofast/model/person_model.dart';
import 'package:grofast/model/product_model.dart';
import 'package:http/http.dart' as http;

import '../model/new_product_model.dart';

abstract class GetInfo {
  GetInfo._();

  static Future<List<ProductModel?>?> getProductByCategory(String categoryTitle) async {
    try {
      final url = Uri.parse("https://fakestoreapi.com/products/category/$categoryTitle");
      final res = await http.get(url);
      return productModelFromJson(res.body);
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<List<ProductModel?>?> getProduct() async {
    try {
      final url = Uri.parse("https://fakestoreapi.com/products");
      final res = await http.get(url);
      return productModelFromJson(res.body);
    } catch (e) {
      print(e);
    }
    return null;
  }


  static Future<ProductModel?> getSingleProduct(String productId) async {
    try {
      final url = Uri.parse("https://fakestoreapi.com/products/$productId");
      final res = await http.get(url);
      return ProductModel.fromJson(jsonDecode(res.body));
    } catch (e) {
      print(e);
    }
    return null;
  }


  static Future<NewProductModel?> getProductNew(int pageIndex) async {
    try {
      final url = Uri.parse("https://api.foodyman.org/api/v1/rest/products/paginate?page=$pageIndex&perPage=6");
      final res = await http.get(url);
      return newProductModelFromJson(res.body);
    } catch (e) {
      print(e);
    }
    return null;
  }



  static Future<List<PersonModel?>?> getPersons() async {
    try {
      final url = Uri.parse("https://fakestoreapi.com/users");
      final res = await http.get(url);
      return personModelFromJson(res.body);
    } catch (e) {
      print(e);
    }
    return null;
  }


  static Future<List> getCategory() async {
    try {
      final url = Uri.parse("https://fakestoreapi.com/products/categories");
      final res = await http.get(url);
      return jsonDecode(res.body);
    } catch (e) {
      print(e);
    }
    return [];
  }
}
