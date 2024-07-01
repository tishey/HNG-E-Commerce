import 'package:flutter/material.dart';
import 'package:hng_task_two_ecommerce/src/bottom-nav/app_bottom_nav.dart';
import 'package:hng_task_two_ecommerce/src/model/product_model.dart';
import 'package:hng_task_two_ecommerce/utils/app_dialogue.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 39, 24, 65)),
        useMaterial3: true,
      ),
      home: const AppBottomNav(),
    );
  }
}

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
                          child: Column(
                            children: [
                              Container(
                                height:
                                    (MediaQuery.of(context).size.width * 0.3),
                                width:
                                    (MediaQuery.of(context).size.width - 16) *
                                        0.3,
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
                                          width: (MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3) -
                                              20,
                                          height: (MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3) -
                                              20,
                                          child: products[index].image != null
                                              ? Image.asset(
                                                  products[index].image!,
                                                  fit: BoxFit.cover,
                                                )
                                              : const SizedBox.shrink()),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                width:
                                    (MediaQuery.of(context).size.width - 16) *
                                        0.3,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Column(
                                    children: [
                                      Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            products[index].name ?? '',
                                            style: const TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
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
                                              width: ((MediaQuery.of(context)
                                                              .size
                                                              .width -
                                                          16) *
                                                      0.3) -
                                                  34,
                                              child: Text(
                                                "₦${products[index].price}",
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                          const Spacer(),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                  //  ListView.builder(
                  //   itemCount: products.length,
                  //   itemBuilder: (context, index) {
                  //     return ListTile(
                  //       title: Text(products[index].name ?? ''),
                  //       subtitle: Text('\$${products[index].price}'),
                  //       // onTap: () => Navigator.push(
                  //       //   context,
                  //       //   // MaterialPageRoute(
                  //       //   //   builder: (context) => CheckoutPage(product: products[index]),
                  //       //   // ),
                  //       // ),
                  //     );
                  //   },
                  // );
                }
              },
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
