import 'package:flutter/material.dart';

 headline(Color color, double fontSize) {
  return TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: fontSize, fontFamily: 'Poppins');
}

bodyText(Color color, double fontSize) {
  return TextStyle(color: color,  fontSize: fontSize, fontFamily: 'Poppins');
} 



                      // StreamBuilder(
                      //     stream: cloudStoreRef.getStocks(),
                      //     builder: (context, snapshot) {
                      //       if (snapshot.connectionState ==
                      //           ConnectionState.waiting) {
                      //         return const CircularProgressIndicator(
                      //             color: Colors.green);
                      //       } else {
                      //         final stocks = snapshot.data!;
                      //         if (stocks.isNotEmpty) {
                      //           for (int index = 0;
                      //               index >= 0 && index < stocks.length;
                      //               index++) {
                      //             String productName = stocks[index].name;
                      //             String category = stocks[index].category;
                      //             String costPrice = stocks[index].costPrice;
                      //             String sellingPrice =
                      //                 stocks[index].sellingPrice;
                      //             String quantity = stocks[index].quantity;
                      //             String supplier = stocks[index].supplier;
                      //             String expiryDate = stocks[index].expiryDate;
                      //             String status = stocks[index].status;

                      //             return Row(
                      //               mainAxisAlignment:
                      //                   MainAxisAlignment.spaceBetween,
                      //               children: [
                      //                 Column(
                      //                   crossAxisAlignment:
                      //                       CrossAxisAlignment.start,
                      //                   children: [
                      //                     Text(
                      //                       'S/N',
                      //                       style: headline(black, 10),
                      //                     ),
                      //                     SizedBox(
                      //                       height: space,
                      //                     ),
                      //                     SizedBox(
                      //                       height: 300,
                      //                       width: 70,
                      //                       child: ListView.builder(
                      //                           itemCount: stocks.length,
                      //                           itemBuilder: (context, index) {
                      //                             return Padding(
                      //                               padding:
                      //                                   const EdgeInsets.only(
                      //                                       bottom: 20),
                      //                               child: Text(
                      //                                 '${index + 1}',
                      //                                 style:
                      //                                     bodyText(black, 10),
                      //                               ),
                      //                             );
                      //                           }),
                      //                     ),
                      //                   ],
                      //                 ),
                      //                 Column(
                      //                   crossAxisAlignment:
                      //                       CrossAxisAlignment.start,
                      //                   children: [
                      //                     Text(
                      //                       'PRODUCTS',
                      //                       style: headline(black, 10),
                      //                     ),
                      //                     SizedBox(
                      //                       height: space,
                      //                     ),
                      //                     SizedBox(
                      //                       height: 300,
                      //                       width: 70,
                      //                       child: ListView.builder(
                      //                           itemCount: stocks.length,
                      //                           itemBuilder: (context, index) {
                      //                             return Padding(
                      //                               padding:
                      //                                   const EdgeInsets.only(
                      //                                       bottom: 20),
                      //                               child: Text(
                      //                                 productName,
                      //                                 style:
                      //                                     bodyText(black, 10),
                      //                               ),
                      //                             );
                      //                           }),
                      //                     ),
                      //                   ],
                      //                 ),
                      //                 Column(
                      //                   crossAxisAlignment:
                      //                       CrossAxisAlignment.start,
                      //                   children: [
                      //                     Text(
                      //                       'CATEGORY',
                      //                       style: headline(black, 10),
                      //                     ),
                      //                     SizedBox(
                      //                       height: space,
                      //                     ),
                      //                     SizedBox(
                      //                       height: 300,
                      //                       width: 70,
                      //                       child: ListView.builder(
                      //                           itemCount: stocks.length,
                      //                           itemBuilder: (context, index) {
                      //                             return Padding(
                      //                               padding:
                      //                                   const EdgeInsets.only(
                      //                                       bottom: 20),
                      //                               child: Text(
                      //                                 category,
                      //                                 style:
                      //                                     bodyText(black, 10),
                      //                               ),
                      //                             );
                      //                           }),
                      //                     ),
                      //                   ],
                      //                 ),
                      //                 Column(
                      //                   crossAxisAlignment:
                      //                       CrossAxisAlignment.start,
                      //                   children: [
                      //                     Text(
                      //                       'EXPIRE',
                      //                       style: headline(black, 10),
                      //                     ),
                      //                     SizedBox(
                      //                       height: space,
                      //                     ),
                      //                     SizedBox(
                      //                       height: 300,
                      //                       width: 70,
                      //                       child: ListView.builder(
                      //                           itemCount: stocks.length,
                      //                           itemBuilder: (context, index) {
                      //                             return Padding(
                      //                               padding:
                      //                                   const EdgeInsets.only(
                      //                                       bottom: 20),
                      //                               child: Text(
                      //                                 expiryDate,
                      //                                 style:
                      //                                     bodyText(black, 10),
                      //                               ),
                      //                             );
                      //                           }),
                      //                     ),
                      //                   ],
                      //                 ),
                      //                 Column(
                      //                   crossAxisAlignment:
                      //                       CrossAxisAlignment.start,
                      //                   children: [
                      //                     Text(
                      //                       'PRICE',
                      //                       style: headline(black, 10),
                      //                     ),
                      //                     SizedBox(
                      //                       height: space,
                      //                     ),
                      //                     SizedBox(
                      //                       height: 300,
                      //                       width: 70,
                      //                       child: Padding(
                      //                         padding: const EdgeInsets.only(
                      //                             bottom: 20),
                      //                         child: ListView.builder(
                      //                             itemCount: stocks.length,
                      //                             itemBuilder:
                      //                                 (context, index) {
                      //                               return Padding(
                      //                                 padding:
                      //                                     const EdgeInsets.only(
                      //                                         bottom: 20),
                      //                                 child: Text(
                      //                                   sellingPrice,
                      //                                   style:
                      //                                       bodyText(black, 10),
                      //                                 ),
                      //                               );
                      //                             }),
                      //                       ),
                      //                     ),
                      //                   ],
                      //                 ),
                      //                 Column(
                      //                   crossAxisAlignment:
                      //                       CrossAxisAlignment.start,
                      //                   children: [
                      //                     Text(
                      //                       'SUPPLIER',
                      //                       style: headline(black, 10),
                      //                     ),
                      //                     SizedBox(
                      //                       height: space,
                      //                     ),
                      //                     SizedBox(
                      //                       height: 300,
                      //                       width: 70,
                      //                       child: ListView.builder(
                      //                           itemCount: stocks.length,
                      //                           itemBuilder: (context, index) {
                      //                             return Padding(
                      //                               padding:
                      //                                   const EdgeInsets.only(
                      //                                       bottom: 20),
                      //                               child: Text(
                      //                                 supplier,
                      //                                 style:
                      //                                     bodyText(black, 10),
                      //                               ),
                      //                             );
                      //                           }),
                      //                     ),
                      //                   ],
                      //                 ),
                      //                 Column(
                      //                   crossAxisAlignment:
                      //                       CrossAxisAlignment.start,
                      //                   children: [
                      //                     Text(
                      //                       'QUANTITY',
                      //                       style: headline(black, 10),
                      //                     ),
                      //                     SizedBox(
                      //                       height: space,
                      //                     ),
                      //                     SizedBox(
                      //                       height: 300,
                      //                       width: 70,
                      //                       child: ListView.builder(
                      //                           itemCount: stocks.length,
                      //                           itemBuilder: (context, index) {
                      //                             return Padding(
                      //                               padding:
                      //                                   const EdgeInsets.only(
                      //                                       bottom: 20),
                      //                               child: Text(
                      //                                 quantity,
                      //                                 style:
                      //                                     bodyText(black, 10),
                      //                               ),
                      //                             );
                      //                           }),
                      //                     ),
                      //                   ],
                      //                 ),
                      //                 Column(
                      //                   crossAxisAlignment:
                      //                       CrossAxisAlignment.start,
                      //                   children: [
                      //                     Text(
                      //                       'STATUS',
                      //                       style: headline(black, 10),
                      //                     ),
                      //                     SizedBox(
                      //                       height: space,
                      //                     ),
                      //                     SizedBox(
                      //                       height: 300,
                      //                       width: 70,
                      //                       child: ListView.builder(
                      //                           itemCount: stocks.length,
                      //                           itemBuilder: (context, index) {
                      //                             return Padding(
                      //                               padding: EdgeInsets.only(
                      //                                   bottom: 20),
                      //                               child: Text(
                      //                                 status,
                      //                                 style: bodyText(
                      //                                     status ==
                      //                                             'Unavailable'
                      //                                         ? red
                      //                                         : green,
                      //                                     10),
                      //                               ),
                      //                             );
                      //                           }),
                      //                     ),
                      //                   ],
                      //                 ),
                      //                 Column(
                      //                   crossAxisAlignment:
                      //                       CrossAxisAlignment.start,
                      //                   children: [
                      //                     Text(
                      //                       'ACTIONS',
                      //                       style: headline(black, 10),
                      //                     ),
                      //                     SizedBox(
                      //                       height: space,
                      //                     ),
                      //                     SizedBox(
                      //                       height: 300,
                      //                       width: 50,
                      //                       child: ListView.builder(
                      //                           itemCount: stocks.length,
                      //                           itemBuilder: (context, index) {
                      //                             return Padding(
                      //                               padding:
                      //                                   const EdgeInsets.only(
                      //                                       bottom: 20),
                      //                               child: Row(
                      //                                 children: [
                      //                                   InkWell(
                      //                                       onTap: () {},
                      //                                       child: Icon(
                      //                                           Icons
                      //                                               .edit_document,
                      //                                           size: 15,
                      //                                           color: green)),
                      //                                   const SizedBox(
                      //                                     width: 8,
                      //                                   ),
                      //                                   InkWell(
                      //                                       onTap: () {},
                      //                                       child: Icon(
                      //                                           Icons
                      //                                               .delete_outlined,
                      //                                           size: 15,
                      //                                           color: red)),
                      //                                 ],
                      //                               ),
                      //                             );
                      //                           }),
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ],
                      //             );
                      //           }
                      //         }
                      //       }
                      //       return Center(
                      //           child: Text('You have not added any product',
                      //               style: headline(black, 20)));
                      //     }),