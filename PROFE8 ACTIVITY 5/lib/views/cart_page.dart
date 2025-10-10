import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import 'package:intl/intl.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  static String price(double v) =>
      NumberFormat.currency(locale: 'en_PH', symbol: '₱').format(v);

  @override
  Widget build(BuildContext context) {
    // demonstration area for context.watch() vs context.read()
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        backgroundColor: const Color(0xFFE91E63),
      ),
      body: Column(
        children: [
          // Top: catalog and add buttons
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(12),
              children: [
                const Text(
                  'Available Services',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE91E63)),
                ),
                const SizedBox(height: 8),
                // Catalog from provider
                ...context.read<CartProvider>().catalog.map((product) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      title: Text(product.name),
                      subtitle: Text(price(product.price)),
                      trailing: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE91E63)),
                        child: const Text('Add'),
                        onPressed: () {
                          // use read to perform action (doesn't rebuild this widget)
                          context.read<CartProvider>().addToCart(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('${product.name} added to cart')),
                          );
                        },
                      ),
                    ),
                  );
                }).toList(),
                const SizedBox(height: 12),

                const Divider(),
                const SizedBox(height: 8),
                const Text('Cart (items below update via context.watch())',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                // This widget uses watch -> rebuilds when cart changes
                Consumer<CartProvider>(
                  builder: (_, cart, __) {
                    if (cart.items.isEmpty)
                      return const Text('Your cart is empty.');
                    return Column(
                      children: cart.items.map((it) {
                        return Card(
                          child: ListTile(
                            title: Text(it.name),
                            subtitle: Text('${it.qty} × ${price(it.price)}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove_circle_outline),
                                  onPressed: () => cart.decreaseQty(it.id),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add_circle_outline),
                                  onPressed: () => cart.addToCart(it),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () => cart.removeFromCart(it.id),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
                const SizedBox(height: 24),
                // Demonstration of context.watch vs context.read:
                const Divider(),
                const SizedBox(height: 6),
                const Text('Demo: context.watch() vs context.read()',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                // This text uses watch -> it rebuilds when cart.itemCount changes
                Builder(builder: (ctx) {
                  final count = ctx.watch<CartProvider>().itemCount; // WATCH
                  return Text('Total items in cart (using watch): $count');
                }),
                const SizedBox(height: 6),
                // This widget uses read -> it will NOT rebuild when provider notifies
                const _ReadDemo(),
                const SizedBox(height: 24),
              ],
            ),
          ),

          // Bottom summary using watch for total
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Consumer<CartProvider>(
                  builder: (_, cart, __) => Text('Total: ${price(cart.total)}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE91E63)),
                      child: const Text('Checkout'),
                      onPressed: () {
                        final total = context
                            .read<CartProvider>()
                            .total; // read for immediate use
                        if (total == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Cart is empty')));
                          return;
                        }
                        // For demo: clear cart on checkout
                        context.read<CartProvider>().clear();
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Checked out (demo)')));
                      },
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey),
                      child: const Text('Clear'),
                      onPressed: () => context.read<CartProvider>().clear(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// A small widget that uses context.read() — does not rebuild on provider changes
class _ReadDemo extends StatelessWidget {
  const _ReadDemo();

  @override
  Widget build(BuildContext context) {
    // we intentionally use read to show it won't rebuild
    final countRead = context.read<CartProvider>().itemCount;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Snapshot using read (won\'t auto update): $countRead'),
        const SizedBox(height: 6),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE91E63)),
          onPressed: () {
            // show the current count using read (this will pull the latest value at button press)
            final current = context.read<CartProvider>().itemCount;
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Current cart count (read): $current')));
          },
          child: const Text('Show current count (read)'),
        ),
      ],
    );
  }
}
