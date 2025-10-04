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
     TextCellValue('Product Name'),
     TextCellValue('Category'),
     TextCellValue('Expiry Date'),
     TextCellValue('Cost Price'),
     TextCellValue('Selling Price'),
     TextCellValue('Supplier'),
     TextCellValue('Quantity'),
     TextCellValue('Status'),
  ]);
  for (final doc in querySnapshot.docs) {
    final data = doc.data();

    final List<CellValue> rowData = [
      TextCellValue(data['name']?.toString() ?? ''),
      TextCellValue(data['category']?.toString() ?? ''),
      TextCellValue(data['expiryDate']?.toString() ?? ''),
      DoubleCellValue(data['costPrice'] is num ? data['costPrice'] : double.tryParse(data['costPrice']?.toString() ?? '0') ?? 0.0),
      DoubleCellValue(data['sellingPrice'] is num ? data['sellingPrice'] : double.tryParse(data['sellingPrice']?.toString() ?? '0') ?? 0.0),
      TextCellValue(data['supplier']?.toString() ?? ''),
      IntCellValue(data['quantity'] is num ? data['quantity'].toInt() : int.tryParse(data['quantity']?.toString() ?? '0') ?? 0),
      TextCellValue(data['status']?.toString() ?? ''),
    ];

    sheet.appendRow(rowData);
  }

  var fileBytes = excel.save(fileName: 'Inventory file.xlsx');
  final blob = html.Blob([Uint8List.fromList(fileBytes!)]);
  final url = html.Url.createObjectUrlFromBlob(blob);

  final anchor = html.AnchorElement(href: url)
    ..setAttribute('download', 'Inventory file.xlsx')
    ..click();

  await Future.delayed( Duration(seconds: 1));
  html.Url.revokeObjectUrl(url);
}

Future<void> exportOrdersExcelFile() async {
  final querySnapshot = await firestore.collection('products').get();

  final excel = Excel.createExcel();
  final sheet = excel['Sheet1'];
  sheet.appendRow([
     TextCellValue('Products'),
     TextCellValue('Category'),
     TextCellValue('Price'),
     TextCellValue('Stock Quantity'),
     TextCellValue('Quantity'),
     TextCellValue('Seller'),
     TextCellValue('Payment Method'),
     TextCellValue('Status'),
  ]);
  for (final doc in querySnapshot.docs) {
    final data = doc.data();

    final List<CellValue> rowData = [
      TextCellValue(data['productName']?.toString() ?? ''),
      TextCellValue(data['category']?.toString() ?? ''),
      DoubleCellValue(data['unitPrice'] is num ? data['unitPrice'] : double.tryParse(data['unitPrice']?.toString() ?? '0') ?? 0.0),
      IntCellValue(data['stockQty'] is num ? data['stockQty'].toInt() : int.tryParse(data['stockQty']?.toString() ?? '0') ?? 0),
      IntCellValue(data['quantity'] is num ? data['quantity'].toInt() : int.tryParse(data['quantity']?.toString() ?? '0') ?? 0),
      TextCellValue(data['Seller']?.toString() ?? ''),
      TextCellValue(data['paymentMethod']?.toString() ?? ''),
      TextCellValue(data['status']?.toString() ?? ''),
    ];

    sheet.appendRow(rowData);
  }

  var fileBytes = excel.save(fileName: 'Orders file.xlsx');
  final blob = html.Blob([Uint8List.fromList(fileBytes!)]);
  final url = html.Url.createObjectUrlFromBlob(blob);

  final anchor = html.AnchorElement(href: url)
    ..setAttribute('download', 'Orders file.xlsx')
    ..click();

  await Future.delayed(const Duration(seconds: 1));
  html.Url.revokeObjectUrl(url);
}

Future<void> exportStoreExcelFile() async {
  final querySnapshot = await firestore.collection('stores').get();

  final excel = Excel.createExcel();
  final sheet = excel['Sheet1'];
  sheet.appendRow([
     TextCellValue('Name'),
     TextCellValue('Location'),
     TextCellValue('Manager'),
     TextCellValue('Phone'),
     TextCellValue('Status'),
  ]);
  for (final doc in querySnapshot.docs) {
    final data = doc.data();

    final List<CellValue> rowData = [
      TextCellValue(data['name']?.toString() ?? ''),
      TextCellValue(data['manager']?.toString() ?? ''), 
      TextCellValue(data['location']?.toString() ?? ''),
      TextCellValue(data['phone']?.toString() ?? ''),
      TextCellValue(data['status']?.toString() ?? ''),
    ];

    sheet.appendRow(rowData);
  }

  var fileBytes = excel.save(fileName: 'Stores.xlsx');
  final blob = html.Blob([Uint8List.fromList(fileBytes!)]);
  final url = html.Url.createObjectUrlFromBlob(blob);

  final anchor = html.AnchorElement(href: url)
    ..setAttribute('download', 'Stores.xlsx')
    ..click();

  await Future.delayed(const Duration(seconds: 1));
  html.Url.revokeObjectUrl(url);
}

Future<void> exportSupplierExcelFile() async {
  final querySnapshot = await firestore.collection('suppliers').get();

  final excel = Excel.createExcel();
  final sheet = excel['Sheet1'];
  sheet.appendRow([
     TextCellValue('Company'),
     TextCellValue('Reg Date'),
     TextCellValue('E-mail'),
     TextCellValue('Phone'),
     TextCellValue('Address'),
  ]);
  for (final doc in querySnapshot.docs) {
    final data = doc.data();

    final List<CellValue> rowData = [
      TextCellValue(data['name']?.toString() ?? ''),
      TextCellValue(data['company']?.toString() ?? ''),
      TextCellValue(data['address']?.toString() ?? ''),
      TextCellValue(data['email']?.toString() ?? ''),
      TextCellValue(data['phone']?.toString() ?? ''),
    ];

    sheet.appendRow(rowData);
  }

  var fileBytes = excel.save(fileName: 'Supplier file.xlsx');
  final blob = html.Blob([Uint8List.fromList(fileBytes!)]);
  final url = html.Url.createObjectUrlFromBlob(blob);

  final anchor = html.AnchorElement(href: url)
    ..setAttribute('download', 'Supplier file.xlsx')
    ..click();

  await Future.delayed(const Duration(seconds: 1));
  html.Url.revokeObjectUrl(url);
}



Future<void> exportReportsExcelFile() async {
  final querySnapshot = await firestore.collection('products').get();

  final excel = Excel.createExcel();
  final sheet = excel['Sheet1'];
  sheet.appendRow([
     TextCellValue('Products'),
     TextCellValue('Category'),
     TextCellValue('Price'),
     TextCellValue('Stock Quantity'),
     TextCellValue('Quantity'),
     TextCellValue('Seller'),
     TextCellValue('Payment Method'),
     TextCellValue('Status'),
  ]);
  for (final doc in querySnapshot.docs) {
    final data = doc.data();

    final List<CellValue> rowData = [
      TextCellValue(data['productName']?.toString() ?? ''),
      TextCellValue(data['category']?.toString() ?? ''),
      DoubleCellValue(data['unitPrice'] is num ? data['unitPrice'] : double.tryParse(data['unitPrice']?.toString() ?? '0') ?? 0.0),
      IntCellValue(data['stockQty'] is num ? data['stockQty'].toInt() : int.tryParse(data['stockQty']?.toString() ?? '0') ?? 0),
      IntCellValue(data['quantity'] is num ? data['quantity'].toInt() : int.tryParse(data['quantity']?.toString() ?? '0') ?? 0),
      TextCellValue(data['Seller']?.toString() ?? ''),
      TextCellValue(data['paymentMethod']?.toString() ?? ''),
      TextCellValue(data['status']?.toString() ?? ''),
    ];

    sheet.appendRow(rowData);
  }

  var fileBytes = excel.save(fileName: 'Reports file.xlsx');
  final blob = html.Blob([Uint8List.fromList(fileBytes!)]);
  final url = html.Url.createObjectUrlFromBlob(blob);

  final anchor = html.AnchorElement(href: url)
    ..setAttribute('download', 'Reports file.xlsx')
    ..click();

  await Future.delayed(const Duration(seconds: 1));
  html.Url.revokeObjectUrl(url);
}
