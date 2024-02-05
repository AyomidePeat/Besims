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

final cloudStoreProvider = Provider<FirestoreClass>((ref) => FirestoreClass());

class FirestoreClass {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  Future addUser(
      {required String name,
      required String username,
      required String email,
      required String role,
      required String image,
      required String phoneNumber,
      required String gender}) async {
    UserModel user = UserModel(
        name: name,
        username: username,
        email: email,
        role: role,
        image: image,
        phoneNumber: phoneNumber,
        gender: gender);
    await firebaseFirestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .set(user.toJson());
  }

  Stream<List<UserModel>> getUser() {
    return firebaseFirestore
        .collection('users')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => UserModel.getModelFromJson(json: doc.data()))
          .toList();
    });
  }

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

  Future<String> updateStore({
    required String originalName,
    required String newName,
    required String manager,
    required String location,
    required String phone,
    required String status,
  }) async {
    try {
      CollectionReference storesCollection =
          firebaseFirestore.collection('stores');

      QuerySnapshot storeSnapshot =
          await storesCollection.where('name', isEqualTo: originalName).get();

      if (storeSnapshot.docs.isNotEmpty) {
        await storesCollection.doc(storeSnapshot.docs.first.id).update({
          'name': newName,
          'manager': manager,
          'location': location,
          'phone': phone,
          'status': status,
        });

        return 'Updated';
      } else {
        return 'Store not found';
      }
    } catch (error) {
      print("Error updating store: $error");
      return 'Failed to update store';
    }
  }

  Future<Map<String, dynamic>> getStoreDetails(String storeName) async {
    try {
      CollectionReference storesCollection =
          firebaseFirestore.collection('stores');

      QuerySnapshot storeSnapshot =
          await storesCollection.where('name', isEqualTo: storeName).get();

      if (storeSnapshot.docs.isNotEmpty) {
        Map<String, dynamic> storeData =
            storeSnapshot.docs.first.data() as Map<String, dynamic>;

        return storeData;
      } else {
        throw Exception("Store not found");
      }
    } catch (error) {
      print("Error getting store details: $error");
      rethrow;
    }
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
          .add(supplierModel.toJson());
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

  Future<Map<String, dynamic>> getSupplierDetails(String supplierName) async {
    try {
      CollectionReference supplierCollection =
          firebaseFirestore.collection('suppliers');

      QuerySnapshot supplierSnapshot =
          await supplierCollection.where('name', isEqualTo: supplierName).get();

      if (supplierSnapshot.docs.isNotEmpty) {
        Map<String, dynamic> supplierData =
            supplierSnapshot.docs.first.data() as Map<String, dynamic>;

        return supplierData;
      } else {
        throw Exception("Supplier not found");
      }
    } catch (error) {
      print("Error getting supplier details: $error");
      rethrow;
    }
  }

  Future<String> updateSupplier(
      {required String originalName,
      required String newName,
      required String company,
      required String phone,
      required String address,
      required String email,
      required String date}) async {
    try {
      CollectionReference suppliersCollection =
          firebaseFirestore.collection('suppliers');

      QuerySnapshot supplierSnapshot = await suppliersCollection
          .where('name', isEqualTo: originalName)
          .get();

      if (supplierSnapshot.docs.isNotEmpty) {
        await suppliersCollection.doc(supplierSnapshot.docs.first.id).update({
          'name': newName,
          'company': company,
          'address': address,
          'email': email,
          'phone': phone,
          'date': date
        });

        return 'Updated';
      } else {
        return 'Store not found';
      }
    } catch (error) {
      print("Error updating store: $error");
      return 'Failed to update store';
    }
  }

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
