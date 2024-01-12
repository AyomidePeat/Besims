// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// class PerformancePredictionScreen extends StatefulWidget {
//   @override
//   _PerformancePredictionScreenState createState() => _PerformancePredictionScreenState();
// }

// class _PerformancePredictionScreenState extends State<PerformancePredictionScreen> {
//   List<String> _bestPerformers = [];
//   List<String> _worstPerformers = [];

//   Future<void> _predictPerformance() async {
//     // Replace these values with your actual Firebase configuration
//     final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//     final CollectionReference _salesCollection = _firestore.collection('products');

//     try {
//       QuerySnapshot salesSnapshot = await _salesCollection.get();

//       if (salesSnapshot.docs.isNotEmpty) {
//         // Extract product IDs and quantities sold
//         Map<String, double> totalSales = {};

//         for (QueryDocumentSnapshot saleDoc in salesSnapshot.docs) {
//           String productId = saleDoc['product_id'];
//           double quantitySold = saleDoc['quantity_sold'].toDouble();

//           totalSales[productId] ??= 0.0;
//           totalSales[productId] += quantitySold;
//         }

//         // Sort products based on total sales
//         List<MapEntry<String, double>> sortedSales =
//             totalSales.entries.toList()..sort((a, b) => b.value.compareTo(a.value));

//         // Extract best and worst performers
//         _bestPerformers = sortedSales.sublist(0, 5).map((entry) => entry.key).toList();
//         _worstPerformers = sortedSales.sublist(sortedSales.length - 5).map((entry) => entry.key).toList();
//       } else {
//         print('No sales data available.');
//       }
//     } catch (e) {
//       print('Error predicting performance: $e');
//     }

//     setState(() {}); // Update the UI with the predicted performance
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Performance Prediction'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             ElevatedButton(
//               onPressed: _predictPerformance,
//               child: Text('Predict Performance'),
//             ),
//             SizedBox(height: 16.0),
//             Text('Best Performing Goods: ${_bestPerformers.join(', ')}'),
//             SizedBox(height: 16.0),
//             Text('Worst Performing Goods: ${_worstPerformers.join(', ')}'),
//           ],
//         ),
//       ),
//     );
//   }
// }