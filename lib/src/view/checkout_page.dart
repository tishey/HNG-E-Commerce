import 'package:flutter/material.dart';
import 'package:hng_task_two_ecommerce/src/model/product_model.dart';
import 'package:hng_task_two_ecommerce/utils/app_dialogue.dart';

class CheckoutPage extends StatefulWidget {
  final List<ProductsModel> selectedProducts;
  final Function(ProductsModel) onRemoveProduct;
  final Function onClearCart;

  const CheckoutPage(
      {super.key,
      required this.selectedProducts,
      required this.onRemoveProduct,
      required this.onClearCart});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool _isLoading = false;

  void _handleCheckout(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });
    widget.onClearCart();
    _showSuccessMessage(context);
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice =
        widget.selectedProducts.fold(0, (sum, product) => sum + product.price!);

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Stack(
        children: [
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: widget.selectedProducts.isEmpty
                ? const Center(child: Text('No product added yet'))
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: widget.selectedProducts.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Container(
                                height: 150,
                                width: 80,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: AssetImage(widget
                                                .selectedProducts[index]
                                                .image ??
                                            ''),
                                        fit: BoxFit.cover)),
                              ),
                              title: Text(
                                  widget.selectedProducts[index].name ?? ''),
                              subtitle: Text(
                                  '₦${widget.selectedProducts[index].price}'),
                              trailing: IconButton(
                                icon: const Icon(Icons.remove_circle),
                                onPressed: () => widget.onRemoveProduct(
                                    widget.selectedProducts[index]),
                              ),
                            );
                          },
                        ),
                      ),
                      Text('Total: ₦${totalPrice.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 20)),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          AppDialogue.showMessageDialogue(
                              context,
                              'Order Review',
                              'Are you sure you want to make this ${widget.selectedProducts.length} order?',
                              () {
                            Navigator.pop(context);
                            // _showSuccessMessage(context);
                            // widget.onClearCart();
                            _handleCheckout(context);
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 60),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color.fromARGB(255, 39, 24, 65)),
                          child: const Text(
                            'Checkout',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  void _showSuccessMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Success',
          style: TextStyle(color: Colors.green),
        ),
        content: const Text('Order placed successfully!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
