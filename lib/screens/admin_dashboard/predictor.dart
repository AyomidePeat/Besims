import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PricePredictionScreen extends StatefulWidget {
  const PricePredictionScreen({super.key});

  @override
  _PricePredictionScreenState createState() => _PricePredictionScreenState();
}

class _PricePredictionScreenState extends State<PricePredictionScreen> {
  final TextEditingController _productNameController = TextEditingController();
  double? _predictedPrice;

  Future<void> _predictPrice(String productName) async {
    // Replace these values with your actual Firebase configuration
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference _productsCollection =
        _firestore.collection('products');

    try {
      DocumentSnapshot productSnapshot =
          await _productsCollection.doc(productName).get();

      if (productSnapshot.exists) {
        // Fetch data and perform prediction (replace this with your actual prediction logic)
        String price = productSnapshot['costPrice'].trim();
        double historicalPrice = double.parse(price);
        _predictedPrice = historicalPrice * 1.1; // Simple example: 10% markup
      } else {
        // Handle case where the product is not found
        print('Product not found');
        _predictedPrice = null;
      }
    } catch (e) {
      print('Error predicting price: $e');
      _predictedPrice = null;
    }

    setState(
        () {}); // Update the UI with the predicted price or an error message
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Price Prediction'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _productNameController,
              decoration: InputDecoration(labelText: 'Product Name'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _predictPrice(_productNameController.text),
              child: Text('Predict Price'),
            ),
            SizedBox(height: 16.0),
            _predictedPrice != null
                ? Text(
                    'Predicted Price: \$${_predictedPrice!.toStringAsFixed(2)}')
                : Container(),
          ],
        ),
      ),
    );
  }
}
