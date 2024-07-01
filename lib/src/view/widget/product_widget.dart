
import 'package:flutter/material.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget(
      {super.key,
      required this.image,
      required this.name,
      required this.price});
  final String? image;
  final String name;
  final int price;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: (MediaQuery.of(context).size.width * 0.3),
          width: (MediaQuery.of(context).size.width - 16) * 0.3,
          decoration: const BoxDecoration(
              color: Color(0xfFDECADE),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              )),
          child: Stack(
            children: [
              Center(
                child: SizedBox(
                    width: (MediaQuery.of(context).size.width * 0.3) - 20,
                    height: (MediaQuery.of(context).size.width * 0.3) - 20,
                    child: image != null
                        ? Image.asset(
                            image!,
                            fit: BoxFit.cover,
                          )
                        : const SizedBox.shrink()),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: (MediaQuery.of(context).size.width - 16) * 0.3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      name,
                      style: const TextStyle(
                          fontSize: 10, fontWeight: FontWeight.bold),
                    )),
                const SizedBox(
                  height: 4,
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    SizedBox(
                        width:
                            ((MediaQuery.of(context).size.width - 16) * 0.3) -
                                34,
                        child: Text(
                          "₦$price",
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        )),
                    const Spacer(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
