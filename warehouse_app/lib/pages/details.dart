import 'package:flutter/material.dart';
import 'package:warehouse_app/models/product.dart';
import 'package:warehouse_app/providers/product.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({
    Key? key,
    required this.product,
    required this.productProvider,
  }) : super(key: key);

  final Product product;
  final ProductProvider productProvider;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
