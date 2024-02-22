import 'package:bsims/models/category_model.dart';
import 'package:bsims/models/change_model.dart';
import 'package:bsims/models/product_model.dart';
import 'package:bsims/models/stock_inventory_model.dart';
import 'package:bsims/models/store_model.dart';
import 'package:bsims/models/supplier_model.dart';
import 'package:bsims/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cloudStoreProvider = Provider<CashierFirestoreClass>((ref) => CashierFirestoreClass());

class CashierFirestoreClass {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;


  Future addCategory({
    required String categoryName,
  }) async {
    DateTime date = DateTime.now();

    CategoryModel category =
        CategoryModel(categoryName: categoryName, dateCreated: date);

    String message = 'Something went wrong';
    try {
      await firebaseFirestore
          .collection('product-categories')
          .doc(categoryName)
          .set(category.toJson());
      message = 'Added';
    } catch (e) {
      return e.toString();
    }
    return message;
  }

  Stream<List<CategoryModel>> getCategories() {
    return firebaseFirestore
        .collection('product-categories')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => CategoryModel.getModelFromJson(doc.data()))
          .toList();
    });
  }

  Future deleteCategory(String name) async {
    String message = 'Something went wrong';
    try {
      await firebaseFirestore
          .collection('product-categories')
          .doc(name)
          .delete();
      message = 'Category deleted';
    } catch (e) {
      return e.toString();
    }
    return message;
  }

  Future<Map<String, dynamic>> getCategoryDetails(String stockName) async {
    try {
      CollectionReference stockCollection =
          firebaseFirestore.collection('product-categories');

      QuerySnapshot categorySnapshot = await stockCollection
          .where('categoryName', isEqualTo: stockName)
          .get();

      if (categorySnapshot.docs.isNotEmpty) {
        Map<String, dynamic> stockData =
            categorySnapshot.docs.first.data() as Map<String, dynamic>;

        return stockData;
      } else {
        throw Exception("stock not found");
      }
    } catch (error) {
      print("Error getting stock details: $error");
      rethrow;
    }
  }

  Future<String> updateCtegory({
    required String originalName,
    required String newName,
  }) async {
    try {
      CollectionReference categoriesCollection =
          firebaseFirestore.collection('product-categories');

      QuerySnapshot storeSnapshot = await categoriesCollection
          .where('categoryName', isEqualTo: originalName)
          .get();

      if (storeSnapshot.docs.isNotEmpty) {
        await categoriesCollection.doc(storeSnapshot.docs.first.id).update({
          'categoryName': newName,
        });

        return 'Updated';
      } else {
        return 'Category not found';
      }
    } catch (error) {
      print("Error updating Category: $error");
      return 'Failed to update Category';
    }
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
      print(e);
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

  Future<Map<String, dynamic>> getStockDetails(String stockName) async {
    try {
      CollectionReference stockCollection =
          firebaseFirestore.collection('stock-inventory');

      QuerySnapshot stockSnapshot =
          await stockCollection.where('name', isEqualTo: stockName).get();

      if (stockSnapshot.docs.isNotEmpty) {
        Map<String, dynamic> stockData =
            stockSnapshot.docs.first.data() as Map<String, dynamic>;

        return stockData;
      } else {
        throw Exception("stock not found");
      }
    } catch (error) {
      print("Error getting stock details: $error");
      rethrow;
    }
  }

  Future<String> updateStock({
    required String originalName,
    required String newName,
    required String expiryDate,
    required String sellingPrice,
    required String costPrice,
    required String quantity,
    required String supplier,
    required String category,
    required String status,
  }) async {
    DateTime dateAdded = DateTime.now();
    try {
      CollectionReference stockCollection =
          firebaseFirestore.collection('stock-inventory');

      QuerySnapshot storeSnapshot =
          await stockCollection.where('name', isEqualTo: originalName).get();

      if (storeSnapshot.docs.isNotEmpty) {
        await stockCollection.doc(storeSnapshot.docs.first.id).update({
          'name': newName,
          'expiryDate': expiryDate,
          'sellingPrice': sellingPrice,
          'costPrice': costPrice,
          'quantity': quantity,
          'supplier': supplier,
          'category': category,
          'status': status,
          'dateAdded': dateAdded
        });

        return 'Updated';
      } else {
        return 'Stock not found';
      }
    } catch (error) {
      print("Error updating stock: $error");
      return 'Failed to update stock';
    }
  }


 Future<List<Change>> getOfflineChanges() async {
    // Placeholder for retrieving offline changes
    // You may want to query a local database or use a state management solution
    // Note: Firestore persistence handles offline changes automatically

    List<Change> changes = [
      Change( changeData: {'name': 'Updated Product'}),
      // Add more changes as needed
    ];

    return changes;
  }

  // Future<void> applyOfflineChanges() async {
  //   try {
  //     List<Change> offlineChanges = await getOfflineChanges();

  //     for (Change change in offlineChanges) {
  //       await applyChangeToFirebase(change);
  //     }
  //   } catch (e) {
  //     print('Error applying offline changes: $e');
  //   }
  // }

  // Future<void> applyChangeToFirebase(Change change) async {
   

  //   final CollectionReference productsCollection =
  //       FirebaseFirestore.instance.collection('products');

  //   try {
  //     await productsCollection.doc(change.productId).update(change.changeData);
  //   } catch (e) {
  //     print('Error applying change to Firebase: $e');
  //   }
  // }
  Future addProduct({
    required String category,
    required String paymentMethod,
    required String status,
    required String productName,
    required String stockQty,
    required String unitPrice,
    required String quantity,
    required String seller,
    required String costPrice,
  }) async {
    DateTime dateAdded = DateTime.now();
    Timestamp timestamp = Timestamp.fromDate(dateAdded);
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
      dateAdded: dateAdded,
      timestamp: timestamp,
    );
    String message = 'Something went wrong';
    try {
      await firebaseFirestore.collection('products').add(productmodel.toJson());

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

  Stream<List<StockInventoryModel>> filterStocksByName(String query) {
    return firebaseFirestore
        .collection(
            'stock-inventory') // Replace with your actual collection name
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThan: '${query}z')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => StockInventoryModel.fromFirestore(doc))
            .toList());
  }
}
