import 'package:bsims/const/colors.dart';
import 'package:bsims/const/textstyle.dart';
import 'package:bsims/widgets/textfield_widget.dart';
import 'package:bsims/widgets/white_textfield.dart';
import 'package:flutter/material.dart';

class SellProduct extends StatefulWidget {
  final double screenWidth;
  final Size size;

  const SellProduct({super.key, required this.screenWidth, required this.size});

  @override
  State<SellProduct> createState() => _SellProductState();
}

class _SellProductState extends State<SellProduct> {
  String? category;
  String? paymentMethod;
  final categoryOptions = [
    'Drug',
    'Foodstuff',
    'Cosmetic',
    'Brevaerage',
    'Skin Care',
    'Baby Products'
  ];

  final paymentMethods = [
    'Cash ',
    'Transfer',
    'POS',
    'Cheque',
  ];
  final customerNameController = TextEditingController();
  void addToCart() {}
  @override
  void dispose() {
    customerNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SizedBox(
            height: 80,
            width: widget.screenWidth * 0.3,
            child: TextFieldWidget(
                controller: customerNameController, label: 'Customer Name:'),
          ),
          Container(
            height: 80,
            width: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: DropdownButtonFormField(
                  hint: const Text('Product Category'),
                  value: category,
                  onChanged: (value) {
                    setState(() {
                      category = value as String;
                    });
                  },
                  items: categoryOptions
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.toString()),
                          ))
                      .toList(),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
        ]),
        const SizedBox(
          height: 20,
        ),
        InkWell(
          onTap: addToCart,
          child: Container(
            height: 40,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: green),
            child: Row(
              children: [
                Icon(
                  Icons.add_circle_sharp,
                  size: 20,
                  color: white,
                ),
                const SizedBox(width: 5),
                const Text('Add to Cart'),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
            width: widget.size.width - 293,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.blue[200]),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PRODUCT NAME',
                      style: bodyText(black, 14),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: widget.screenWidth * 0.4,
                      child: WhiteTextfield(
                          controller: customerNameController,
                          label: 'Product four'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: widget.screenWidth * 0.4,
                      child: WhiteTextfield(
                          controller: customerNameController,
                          label: 'sample one'),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 30,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('STOCK QTY', style: bodyText(black, 14)),
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: green, borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        '200 in Stock',
                        style: bodyText(white, 14),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: green, borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        '200 in Stock',
                        style: bodyText(white, 14),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 30,
                ),
                Column(
                  children: [
                    Text(
                      'UNIT PRICE',
                      style: bodyText(black, 14),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 70,
                      child: WhiteTextfield(
                          controller: customerNameController, label: '350'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 70,
                      child: WhiteTextfield(
                          controller: customerNameController, label: '450'),
                    ),
                  ],
                ),
                SizedBox(
                  width: 30,
                ),
                Column(
                  children: [
                    Text(
                      'QTY',
                      style: bodyText(black, 14),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 70,
                      child: WhiteTextfield(
                          controller: customerNameController, label: '450'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 70,
                      child: WhiteTextfield(
                          controller: customerNameController, label: '450'),
                    ),
                  ],
                ),
                SizedBox(
                  width: 30,
                ),
                Column(
                  children: [
                    Text(
                      'SUBTOTAL',
                      style: bodyText(black, 14),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 70,
                      child: WhiteTextfield(
                          controller: customerNameController, label: '1350'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 70,
                      child: WhiteTextfield(
                          controller: customerNameController, label: '450'),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 20),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.delete_outline_sharp,
                          color: red,
                        )),
                    SizedBox(height: 20),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.delete_outline_sharp,
                          color: red,
                        )),
                  ],
                )
              ],
            )),
        SizedBox(
          height: 30,
        ),
        const Row(
          children: [
            Text('Grand Total'),
            SizedBox(width: 70),
            Text('3100'),
          ],
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Payment Method'),
            Container(
              height: 80,
              width: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Center(
                  child: DropdownButtonFormField(
                    hint: const Text('Select'),
                    value: paymentMethod,
                    onChanged: (value) {
                      setState(() {
                        paymentMethod = value as String;
                      });
                    },
                    items: ['Cash ', 'Transfer', 'POS', 'Cheque']
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e.toString()),
                            ))
                        .toList(),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
