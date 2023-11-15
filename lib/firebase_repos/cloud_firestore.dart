import 'package:bsims/models/category_model.dart';
import 'package:bsims/models/product_model.dart';
import 'package:bsims/models/stock_inventory_model.dart';
import 'package:bsims/models/store_model.dart';
import 'package:bsims/models/supplier_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cloudStoreProvider = Provider<FirestoreClass>((ref) => FirestoreClass());

class FirestoreClass {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  Future addCategory(
      {required String categoryName, required String date}) async {
    CategoryModel category =
        CategoryModel(categoryName: categoryName, dateCreated: date);

    String message = 'Something went wrong';
    try {
      await firebaseFirestore
          .collection('product-categories')
          .doc('categoryName')
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
    DateTime dateAdded = DateTime.now();
    StockInventoryModel stockInventoryModel = StockInventoryModel(
        name: name,
        expiryDate: expiryDate,
        sellingPrice: sellingPrice,
        costPrice: costPrice,
        quantity: quantity,
        supplier: supplier,
        category: category,
        status: status,
        dateAdded: dateAdded);

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

  Future deleteStock(String name) async {
    String message = 'Something went wrong';
    try {
      await firebaseFirestore.collection('stock-inventory').doc(name).delete();
      message = 'Stock deleted';
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

  Stream<List<StoreModel>> getStores() {
    return firebaseFirestore
        .collection('stores')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => StoreModel.getModelFromJson(doc.data()))
          .toList();
    });
  }

  Future deleteStore(String name) async {
    String message = 'Something went wrong';
    try {
      await firebaseFirestore.collection('stores').doc(name).delete();
      message = 'Store deleted';
    } catch (e) {
      return e.toString();
    }
    return message;
  }

  Future addSupplier(
      {required String name,
      required String company,
      required String address,
      required String email,
      required String phone,
      required String date}) async {
    SupplierModel supplierModel = SupplierModel(
        name: name,
        company: company,
        address: address,
        email: email,
        date: date,
        phone: phone);

    String message = 'Something went wrong';
    try {
      await firebaseFirestore
          .collection('suppliers')
          .doc(name)
          .set(supplierModel.toJson());
      message = 'Added';
    } catch (e) {
      return e.toString();
    }
    return message;
  }

  Stream<List<SupplierModel>> getSuppliers() {
    return firebaseFirestore
        .collection('suppliers')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => SupplierModel.getModelFromJson(doc.data()))
          .toList();
    });
  }

  Future deleteSupplier(String name) async {
    String message = 'Something went wrong';
    try {
      await firebaseFirestore.collection('suppliers').doc(name).delete();
      message = 'Supplier deleted';
    } catch (e) {
      return e.toString();
    }
    return message;
  }

  Future addProduct(
      {required String category,
      required String paymentMethod,
      required String status,
      required String productName,
      required String stockQty,
      required String unitPrice,
      required String quantity,
      required String seller,
      required String costPrice}) async {
    DateTime dateAdded = DateTime.now();
    ProductModel productmodel = ProductModel(
        category: category,
        paymentMethod: paymentMethod,
        status: status,
        productName: productName,
        stockQty: stockQty,
        unitPrice: unitPrice,
        quantity: quantity,
        seller: seller,
        costPrice: costPrice,
        dateAdded: dateAdded
        );
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

  Stream<List<ProductModel>> getProducts() {
    return firebaseFirestore
        .collection('products')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => ProductModel.getModelFromJson(doc.data()))
          .toList();
    });
  }

  Future deleteproducts(String name) async {
    String message = 'Something went wrong';
    try {
      await firebaseFirestore.collection('products').doc(name).delete();
      message = 'Product deleted';
    } catch (e) {
      return e.toString();
    }
    return message;
  }
}
