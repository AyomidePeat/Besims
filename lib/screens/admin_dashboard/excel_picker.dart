import 'dart:typed_data';

import 'package:bsims/firebase_repos/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';

Future pickExcelFile() async {
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;

      Uint8List bytes = file.bytes ?? Uint8List(0);

      return bytes.toList();
    } else {
      return <int>[];
    }
  } catch (e) {
    return <int>[];
  }
}

FirestoreClass firestoreClass = FirestoreClass();
Future<void> importInventoryFile(pickExcelFile) async {
  List<int> excelFileBytes = await pickExcelFile;

  Uint8List uint8List = Uint8List.fromList(excelFileBytes);
  final excel = Excel.decodeBytes(uint8List);
  for (var table in excel.tables.keys) {
    if (table == 'Sheet1') {
      var dataRows = excel.tables[table]!.rows.skip(1);

      for (var row in dataRows) {
        final productName = (row[0]!.value is SharedString)
            ? (row[0]!.value as SharedString).toString()
            : (row[0]!.value is int)
                ? (row[0]!.value as int).toString()
                : row[0]!.value ?? '';
        final category = (row[1]!.value is SharedString)
            ? (row[1]!.value as SharedString).toString()
            : (row[1]!.value is int)
                ? (row[1]!.value as int).toString()
                : row[1]!.value ?? '';
        final expiryDate = (row[2]!.value is SharedString)
            ? (row[2]!.value as SharedString).toString()
            : (row[2]!.value is int)
                ? (row[2]!.value as int).toString()
                : row[2]!.value ?? '';
        final costPrice = (row[3]!.value is SharedString)
            ? (row[3]!.value as SharedString).toString()
            : (row[3]!.value is int)
                ? (row[3]!.value as int).toString()
                : row[3]!.value ?? '';
        final sellingPrice = (row[4]!.value is SharedString)
            ? (row[4]!.value as SharedString).toString()
            : (row[4]!.value is int)
                ? (row[4]!.value as int).toString()
                : row[4]!.value ?? '';
        final supplier = (row[5]!.value is SharedString)
            ? (row[5]!.value as SharedString).toString()
            : (row[5]!.value is int)
                ? (row[5]!.value as int).toString()
                : row[5]!.value ?? '';
        final quantity = (row[6]!.value is SharedString)
            ? (row[6]!.value as SharedString).toString()
            : (row[6]!.value is int)
                ? (row[6]!.value as int).toString()
                : row[6]!.value ?? '';
        final status = (row[7]!.value is SharedString)
            ? (row[7]!.value as SharedString).toString()
            : (row[7]!.value is int)
                ? (row[7]!.value as int).toString()
                : row[7]!.value ?? '';

        firestoreClass.addStockInventory(
          name: productName,
          expiryDate: expiryDate,
          sellingPrice: sellingPrice,
          costPrice: costPrice,
          quantity: quantity,
          supplier: supplier,
          category: category,
          status: status,
        );
      }
    }
  }
}

Future<void> importSupplierFile(pickExcelFile) async {
  List<int> excelFileBytes = await pickExcelFile;

  Uint8List uint8List = Uint8List.fromList(excelFileBytes);
  final excel = Excel.decodeBytes(uint8List);
  for (var table in excel.tables.keys) {
    if (table == 'Sheet1') {
      var dataRows = excel.tables[table]!.rows.skip(1);

      for (var row in dataRows) {
        final name = (row[0]!.value is SharedString)
            ? (row[0]!.value as SharedString).toString()
            : (row[0]!.value is int)
                ? (row[0]!.value as int).toString()
                : row[0]!.value ?? '';
        final company = (row[1]!.value is SharedString)
            ? (row[1]!.value as SharedString).toString()
            : (row[1]!.value is int)
                ? (row[1]!.value as int).toString()
                : row[1]!.value ?? '';
        final address = (row[2]!.value is SharedString)
            ? (row[2]!.value as SharedString).toString()
            : (row[2]!.value is int)
                ? (row[2]!.value as int).toString()
                : row[2]!.value ?? '';
        final email = (row[3]!.value is SharedString)
            ? (row[3]!.value as SharedString).toString()
            : (row[3]!.value is int)
                ? (row[3]!.value as int).toString()
                : row[3]!.value ?? '';
        final phone = (row[4]!.value is SharedString)
            ? (row[4]!.value as SharedString).toString()
            : (row[4]!.value is int)
                ? (row[4]!.value as int).toString()
                : row[4]!.value ?? '';
        final now = DateTime.now();
        String currentDate = DateFormat('dd/mm/yyyy').format(now);

        firestoreClass.addSupplier(
            name: name,
            company: company,
            address: address,
            email: email,
            phone: phone,
            date: currentDate);
      }
    }
  }
}

Future<void> importStoreFile(pickExcelFile) async {
  List<int> excelFileBytes = await pickExcelFile;

  Uint8List uint8List = Uint8List.fromList(excelFileBytes);
  final excel = Excel.decodeBytes(uint8List);
  for (var table in excel.tables.keys) {
    if (table == 'Sheet1') {
      var dataRows = excel.tables[table]!.rows.skip(1);

      for (var row in dataRows) {
      
        final name = (row[0]!.value is SharedString)
            ? (row[0]!.value as SharedString).toString()
            : (row[0]!.value is int)
                ? (row[0]!.value as int).toString()
                : row[0]!.value ?? '';
        final location = (row[1]!.value is SharedString)
            ? (row[1]!.value as SharedString).toString()
            : (row[1]!.value is int)
                ? (row[1]!.value as int).toString()
                : row[1]!.value ?? '';
        final manager = (row[2]!.value is SharedString)
            ? (row[2]!.value as SharedString).toString()
            : (row[2]!.value is int)
                ? (row[2]!.value as int).toString()
                : row[2]!.value ?? '';
        final phone = (row[3]!.value is SharedString)
            ? (row[3]!.value as SharedString).toString()
            : (row[3]!.value is int)
                ? (row[3]!.value as int).toString()
                : row[3]!.value ?? '';
        final status = (row[4]!.value is SharedString)
            ? (row[4]!.value as SharedString).toString()
            : (row[4]!.value is int)
                ? (row[4]!.value as int).toString()
                : row[4]!.value ?? '';

        firestoreClass.addStore(
            name: name,
            manager: manager,
            location: location,
            phone: phone,
            status: status);
      }
    }
  }
}

Future<void> importOrderFile(pickExcelFile) async {
  List<int> excelFileBytes = await pickExcelFile;

  Uint8List uint8List = Uint8List.fromList(excelFileBytes);
  final excel = Excel.decodeBytes(uint8List);
  for (var table in excel.tables.keys) {
    if (table == 'Sheet1') {
      var dataRows = excel.tables[table]!.rows.skip(1);

      for (var row in dataRows) {
        final productName = (row[0]!.value is SharedString)
            ? (row[0]!.value as SharedString).toString()
            : (row[0]!.value is int)
                ? (row[0]!.value as int).toString()
                : row[0]!.value ?? '';
        final category = (row[1]!.value is SharedString)
            ? (row[1]!.value as SharedString).toString()
            : (row[1]!.value is int)
                ? (row[1]!.value as int).toString()
                : row[1]!.value ?? '';
        final unitPrice = (row[2]!.value is SharedString)
            ? (row[2]!.value as SharedString).toString()
            : (row[2]!.value is int)
                ? (row[2]!.value as int).toString()
                : row[2]!.value ?? '';
        final stockQty = (row[3]!.value is SharedString)
            ? (row[3]!.value as SharedString).toString()
            : (row[3]!.value is int)
                ? (row[3]!.value as int).toString()
                : row[3]!.value ?? '';
        final quantity = (row[4]!.value is SharedString)
            ? (row[4]!.value as SharedString).toString()
            : (row[4]!.value is int)
                ? (row[4]!.value as int).toString()
                : row[4]!.value ?? '';
        final seller = (row[5]!.value is SharedString)
            ? (row[5]!.value as SharedString).toString()
            : (row[5]!.value is int)
                ? (row[5]!.value as int).toString()
                : row[5]!.value ?? '';
        final paymentMethod = (row[6]!.value is SharedString)
            ? (row[6]!.value as SharedString).toString()
            : (row[6]!.value is int)
                ? (row[6]!.value as int).toString()
                : row[6]!.value ?? '';

        final status = (row[7]!.value is SharedString)
            ? (row[7]!.value as SharedString).toString()
            : (row[7]!.value is int)
                ? (row[7]!.value as int).toString()
                : row[7]!.value ?? '';
        final costPrice = (row[8]!.value is SharedString)
            ? (row[8]!.value as SharedString).toString()
            : (row[8]!.value is int)
                ? (row[8]!.value as int).toString()
                : row[8]!.value ?? '';

        firestoreClass.addProduct(
            category: category,
            paymentMethod: paymentMethod,
            status: status,
            productName: productName,
            stockQty: stockQty,
            unitPrice: unitPrice,
            costPrice: costPrice,
            quantity: quantity,
            seller: seller);
      }
    }
  }
}
