import 'package:bsims/const/colors.dart';
import 'package:bsims/const/textstyle.dart';
import 'package:bsims/widgets/textfield_widget.dart';
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
  final categoryOptions = [
    'Drug',
    'Foodstuff',
    'Cosmetic',
    'Brevaerage',
    'Skin Care',
    'Baby Products'
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
      children: [
        Row(children: [
          SizedBox(
            width: widget.screenWidth * 0.3,
            child: TextFieldWidget(
                controller: customerNameController, label: 'Customer Name:'),
          ),
          Column(
            children: [
              Text(
                'Select Product Category',
                style: bodyText(black, 10),
              ),
              Container(
                height: 40,
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Center(
                    child: DropdownButtonFormField(
                      hint: const Text('Select'),
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
            ],
          ),
        ]),
        const SizedBox(
          height: 20,
        ),
        InkWell(
          onTap: addToCart,
          child: Container(
            width: 103,
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
             decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.blue[200]),

           child: Column(children: [
Text('PRODUCT NAME', style: bodyText(black, 10),),
const SizedBox(height: 10,),
 SizedBox(
            width: widget.screenWidth * 0.4,
            child: TextFieldWidget(
                controller: customerNameController, label: 'Product four'),
          ),
 const SizedBox(
          height: 10,
        ),
        SizedBox(
            width: widget.screenWidth * 0.4,
            child: TextFieldWidget(
                controller: customerNameController, label: 'sample one'),
          ),
          const SizedBox(width: 30,),
          Column(
            children: [
              Text('STOCK QTY', style: bodyText(black, 10)),
              const SizedBox(
          height: 10,
        ),
Container( )
            ],
          )
            ],)
        )
      ],
    );
  }
}
