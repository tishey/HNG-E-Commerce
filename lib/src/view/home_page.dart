
import 'package:flutter/material.dart';
import 'package:hng_task_two_ecommerce/src/model/product_model.dart';
import 'package:hng_task_two_ecommerce/src/view/widget/product_widget.dart';
import 'package:hng_task_two_ecommerce/utils/app_dialogue.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.onProductSelected});

  final Function(ProductsModel) onProductSelected;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<ProductsModel>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = _fetchProducts();
  }

  Future<List<ProductsModel>> _fetchProducts() async {
    await Future.delayed(const Duration(seconds: 3));
    return ProductsModel.generateProduct;
  }

  bool _isLoading = false;

  void _addToCartMethod(
      BuildContext context, int index, ProductsModel products) async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });
    widget.onProductSelected(products);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 39, 24, 65),
        centerTitle: true,
        title: const Text(
          'HNG Task 2',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
            ),
            child: FutureBuilder<List<ProductsModel>>(
              future: futureProducts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No products available'));
                } else {
                  final products = snapshot.data!;
                  return GridView.builder(
                      itemCount: products.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              AppDialogue.showMessageDialogue(
                                context,
                                'Checkout Review',
                                'Do you want to add this product to checkout?',
                                () {
                                  Navigator.pop(context);
                                  _addToCartMethod(
                                      context, index, products[index]);
                                },
                              );
                            },
                            child: ProductWidget(
                                image: products[index].image,
                                name: products[index].name ?? '',
                                price: products[index].price!));
                      });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
