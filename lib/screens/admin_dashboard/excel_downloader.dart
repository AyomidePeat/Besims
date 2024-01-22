import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'dart:typed_data';
import 'package:universal_html/html.dart' as html;

FirebaseFirestore firestore = FirebaseFirestore.instance;
Future<void> exportInventoryExcelFile() async {
  final querySnapshot = await firestore.collection('stock-inventory').get();

  final excel = Excel.createExcel();
  final sheet = excel['Sheet1'];
  sheet.appendRow([
    'Product Name',
    'Category',
    'Expiry Date',
    'Cost Price',
    'Selling Price',
    'Supplier',
    'Quantity',
    'Status'
  ]);
  for (final doc in querySnapshot.docs) {
    final data = doc.data();

    final List<dynamic> rowData = [
      data['name'],
      data['category'],
      data['expiryDate'],
      data['costPrice'],
      data['sellingPrice'],
      data['supplier'],
      data['quantity'],
      data['status'],
    ];

    sheet.appendRow(rowData);
  }

  var fileBytes = excel.save(fileName: 'Inventory file.xlsx');
  final blob = html.Blob([Uint8List.fromList(fileBytes!)]);
  final url = html.Url.createObjectUrlFromBlob(blob);

  html.Url.revokeObjectUrl(url);
}

Future<void> exportOrdersExcelFile() async {
  final querySnapshot = await firestore.collection('products').get();

  final excel = Excel.createExcel();
  final sheet = excel['Sheet1'];
  sheet.appendRow([
    'Products',
    'Category',
    'Price',
    'Stock Quantity',
    'Quantity',
    'Seller',
    'Payment Method',
    'Status',
  ]);
  for (final doc in querySnapshot.docs) {
    final data = doc.data();

    final List<dynamic> rowData = [
      data['productName'],
      data['category'],
      data['unitPrice'],
      data['stockQty'],
      data['quantity'],
      data['Seller'],
      data['paymentMethod'],
      data['status'],
    ];

    sheet.appendRow(rowData);
  }

  var fileBytes = excel.save(fileName: 'Orders file.xlsx');
  final blob = html.Blob([Uint8List.fromList(fileBytes!)]);
  final url = html.Url.createObjectUrlFromBlob(blob);

  html.Url.revokeObjectUrl(url);
}

Future<void> exportStoreExcelFile() async {
  final querySnapshot = await firestore.collection('stores').get();

  final excel = Excel.createExcel();
  final sheet = excel['Sheet1'];
  sheet.appendRow([
    'Name',
    'Location',
    'Manager',
    'Phone',
    'Status',
  ]);
  for (final doc in querySnapshot.docs) {
    final data = doc.data();

    final List<dynamic> rowData = [
      data['name'],
      data['manager'],
      data['location'],
      data['phone'],
      data['status'],
    ];

    sheet.appendRow(rowData);
  }

  var fileBytes = excel.save(fileName: 'Stores.xlsx');
  final blob = html.Blob([Uint8List.fromList(fileBytes!)]);
  final url = html.Url.createObjectUrlFromBlob(blob);

  html.Url.revokeObjectUrl(url);
}

Future<void> exportSupplierExcelFile() async {
  final querySnapshot = await firestore.collection('suppliers').get();

  final excel = Excel.createExcel();
  final sheet = excel['Sheet1'];
  sheet.appendRow([
    'Company',
    'Reg Date',
    'E-mail',
    'Phone',
    'Address',
  ]);
  for (final doc in querySnapshot.docs) {
    final data = doc.data();

    final List<dynamic> rowData = [
      data['name'],
      data['company'],
      data['address'],
      data['email'],
      data['phone'],
    ];

    sheet.appendRow(rowData);
  }

  var fileBytes = excel.save(fileName: 'Supplier file.xlsx');
  final blob = html.Blob([Uint8List.fromList(fileBytes!)]);
  final url = html.Url.createObjectUrlFromBlob(blob);

  html.Url.revokeObjectUrl(url);
}



Future<void> exportReportsExcelFile() async {
  final querySnapshot = await firestore.collection('products').get();

  final excel = Excel.createExcel();
  final sheet = excel['Sheet1'];
  sheet.appendRow([
    'Products',
    'Category',
    'Price',
    'Stock Quantity',
    'Quantity',
    'Seller',
    'Payment Method',
    'Status',
  ]);
  for (final doc in querySnapshot.docs) {
    final data = doc.data();

    final List<dynamic> rowData = [
      data['productName'],
      data['category'],
      data['unitPrice'],
      data['stockQty'],
      data['quantity'],
      data['Seller'],
      data['paymentMethod'],
      data['status'],
    ];

    sheet.appendRow(rowData);
  }

  var fileBytes = excel.save(fileName: 'Reports file.xlsx');
  final blob = html.Blob([Uint8List.fromList(fileBytes!)]);
  final url = html.Url.createObjectUrlFromBlob(blob);

  html.Url.revokeObjectUrl(url);
}
