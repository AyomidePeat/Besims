 import 'package:bsims/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<ProductModel>> getSalesByDate(DateTime startDate, DateTime endDate) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('products')
          .where('timestamp', isGreaterThanOrEqualTo: Timestamp.fromDate(startDate))
          .where('timestamp', isLessThan: Timestamp.fromDate(endDate.add(Duration(days: 1))))
          .get();

      List<ProductModel> sales = querySnapshot.docs.map((doc) {
        return ProductModel.getModelFromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      return sales;
    } catch (error) {
      return [];
    }
  }