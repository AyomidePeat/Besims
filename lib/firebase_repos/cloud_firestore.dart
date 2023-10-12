import 'package:bsims/models/category_model.dart';
import 'package:bsims/models/product_model.dart';
import 'package:bsims/models/stock_inventory_model.dart';
import 'package:bsims/models/store_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cloudStoreProvider = Provider<FirestoreClass>((ref) => FirestoreClass());

class FirestoreClass {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
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
          .doc(name)
          .set(stockInventoryModel.toJson());
      message = 'Added';
    } catch (e) {
      return e.toString();
    }
    return message;
  }

  Stream<List<StockInventoryModel>> getStocks() {
    return firebaseFirestore
        .collection('stock-inventory')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => StockInventoryModel.getModelFromJson(doc.data()))
          .toList();
    });
  }

  Future addStore({
    required String name,
    required String manager,
    required String location,
    required String phone,
    required String status,
  }) async {
    StoreModel storeModel = StoreModel(
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
          .set(storeModel.toJson());
      message = 'Added';
    } catch (e) {
      return e.toString();
    }
    return message;
  }

  Future addProduct({
    required String category,
    required String paymentMethod,
    required String customerName,
    required String productName,
    required String stockQty,
    required String unitPrice,
    required String quantity,
    required String seller,
  }) async {
    ProductModel productmodel = ProductModel(
        category: category,
        paymentMethod: paymentMethod,
        customerName: customerName,
        productName: productName,
        stockQty: stockQty,
        unitPrice: unitPrice,
        quantity: quantity,
        seller: seller);
    String message = 'Something went wrong';
    try {
      await firebaseFirestore
          .collection('products')
          .doc(productName)
          .set(productmodel.toJson());
      message = 'Added';
    } catch (e) {
      return e.toString();
    }
    return message;
  }

  Stream<List<ProductModel>> getProcucts(String productName) {
    return firebaseFirestore
        .collection('products')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => ProductModel.getModelFromJson(doc.data()))
          .toList();
    });
  }
}
