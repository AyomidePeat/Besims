import 'package:bsims/models/category_model.dart';
import 'package:bsims/models/stock_inventory_model.dart';
import 'package:bsims/models/store_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreClass {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future addCategory({
    required String categoryName,
  }) async {
    CategoryModel category = CategoryModel(categoryName: categoryName);

    String message = 'Something went wrong';
    try {
      await firebaseFirestore
          .collection('product-categories')
          .doc('$categoryName')
          .set(category.toJson());
      message = 'Added';
    } catch (e) {
      return e.toString();
    }
    return message;
  }

  Future addStockInventory(
      {required String name,
      required String expiryDate,
      required String sellingPrice,
      required String costPrice,
      required String quantity,
      required String supplier,
      required String category,
      required String status}) async {
    StockInventoryModel stockInventoryModel = StockInventoryModel(
        name: name,
        expiryDate: expiryDate,
        sellingPrice: sellingPrice,
        costPrice: costPrice,
        quantity: quantity,
        supplier: supplier,
        category: category,
        status: status);

    String message = 'Something went wrong';
    try {
      await firebaseFirestore
          .collection('stock-inventory')
          .doc('$name')
          .set(stockInventoryModel.toJson());
      message = 'Added';
    } catch (e) {
      return e.toString();
    }
    return message;
  }

  Future addStore({
    required String name,
    required String manager,
    required String location,
    required String phone,
    required String status,
  }) async {
    StoreModel stockInventoryModel = StoreModel(
        name: name,
        manager: manager,
        location: location,
        phone: phone,
        status: status);

    String message = 'Something went wrong';
    try {
      await firebaseFirestore
          .collection('stores')
          .doc('$name')
          .set(stockInventoryModel.toJson());
      message = 'Added';
    } catch (e) {
      return e.toString();
    }
    return message;
  }
}
