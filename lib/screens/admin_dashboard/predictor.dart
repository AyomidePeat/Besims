import 'package:flutter/material.dart';
import 'dart:math';



class LinearRegressionModel {
  double slope;
  double intercept;

  LinearRegressionModel({required this.slope, required this.intercept});

  double predict(double quantitySold) {
    return slope * quantitySold + intercept;
  }
}


class PricePredictionApp extends StatefulWidget {
  @override
  _PricePredictionAppState createState() => _PricePredictionAppState();
}

class _PricePredictionAppState extends State<PricePredictionApp> {
  TextEditingController quantityController = TextEditingController();
  double? predictedPrice;

  LinearRegressionModel model = LinearRegressionModel(
    slope: 10,  // Replace with your model's actual values
    intercept: 5,  // Replace with your model's actual values
  );

  void predictPrice() {
  try {
    double quantity = double.parse(quantityController.text);
    double predictedPrice = model.predict(quantity);
    setState(() {
      this.predictedPrice = predictedPrice;
    });
  } catch (e) {
    setState(() {
      predictedPrice = null;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Invalid input. Please enter a valid number.'),
      ),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Price Prediction'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Quantity Sold'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: predictPrice,
              child: const Text('Predict Price'),
            ),
            const SizedBox(height: 16.0),
            Text(
              predictedPrice != null
                  ? 'Predicted Price: \$${predictedPrice!.toStringAsFixed(2)}'
                  : '',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
