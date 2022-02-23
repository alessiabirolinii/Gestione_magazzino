import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warehouse_app/models/category.dart';
import 'package:warehouse_app/models/product.dart';
import 'package:warehouse_app/models/warehouse.dart';
import 'package:warehouse_app/pages/details.dart';
import 'package:warehouse_app/providers/category.dart';
import 'package:warehouse_app/providers/product.dart';
import 'package:warehouse_app/providers/werehouse.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Gestione magazzino"),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.house)),
              Tab(icon: Icon(Icons.category)),
              Tab(icon: Icon(Icons.archive)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ProductView(),
            CategoryView(),
            WarehouseView(),
          ],
        ),
      ),
    );
  }
}

class ProductView extends StatelessWidget {
  const ProductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProductProvider>(
        builder: (context, value, child) {
          final List<Product> products = value.products;
          return Padding(
            padding: const EdgeInsets.only(right: 5),
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: products.length,
              itemBuilder: (context, index) {
                final Product p = products[index];
                return ProductListTile(product: p);
              },
            ),
          );
        },
      ),
    );
  }
}

class ProductListTile extends StatefulWidget {
  const ProductListTile({
    Key? key,
    required this.product,
  }) : super(key: key);
  final Product product;
  @override
  State<ProductListTile> createState() => _ProductListTileState();
}

class _ProductListTileState extends State<ProductListTile> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        final ProductProvider productProvider = Provider.of<ProductProvider>(
          context,
          listen: false,
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsView(
              productProvider: productProvider,
              product: widget.product,
            ),
          ),
        );
      },
      title: Text(widget.product.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Quantità: ${widget.product.quantity},  Prezzo: €${widget.product.price}",
          ),
          const SizedBox(height: 5),
          Text("Categoria: ${widget.product.category.name}"),
          const SizedBox(height: 5),
          Text("Magazzino: ${widget.product.warehouse.name}"),
        ],
      ),
      trailing: TextButton(
        onPressed: () async {
          final ProductProvider productProvider = Provider.of<ProductProvider>(
            context,
            listen: false,
          );

          if (mounted) {
            setState(() {
              isLoading = true;
            });
          }

          await productProvider.delete(widget.product.code);

          if (mounted) {
            setState(() {
              isLoading = false;
            });
          }
        },
        child: isLoading
            ? const CircularProgressIndicator()
            : const Icon(Icons.delete, color: Colors.black54),
        style: TextButton.styleFrom(
          minimumSize: Size.zero,
          splashFactory: NoSplash.splashFactory,
          padding: const EdgeInsets.only(top: 18),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
    );
  }
}

class CategoryView extends StatelessWidget {
  const CategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CategoryProvider>(
        builder: (context, value, child) {
          List<Category> categories = value.categories;
          return Padding(
            padding: const EdgeInsets.only(right: 5),
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final Category c = categories[index];
                return CategoryListTile(category: c);
              },
            ),
          );
        },
      ),
    );
  }
}

class CategoryListTile extends StatefulWidget {
  const CategoryListTile({Key? key, required this.category}) : super(key: key);
  final Category category;

  @override
  State<CategoryListTile> createState() => _CategoryListTileState();
}

class _CategoryListTileState extends State<CategoryListTile> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      title: Text(widget.category.name),
      trailing: TextButton(
        onPressed: () async {
          final CategoryProvider categoryProvider =
              Provider.of<CategoryProvider>(
            context,
            listen: false,
          );

          if (mounted) {
            setState(() {
              isLoading = true;
            });
          }

          await categoryProvider.delete(widget.category.code);

          if (mounted) {
            setState(() {
              isLoading = false;
            });
          }
        },
        child: isLoading
            ? const CircularProgressIndicator()
            : const Icon(Icons.delete, color: Colors.black54),
        style: TextButton.styleFrom(
          minimumSize: Size.zero,
          padding: EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
    );
  }
}

class WarehouseView extends StatelessWidget {
  const WarehouseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<WarehouseProvider>(
        builder: (context, value, child) {
          List<Warehouse> warehouses = value.warehouses;
          return Padding(
            padding: const EdgeInsets.only(right: 5),
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: warehouses.length,
              itemBuilder: (context, index) {
                final Warehouse w = warehouses[index];
                return WarehouseListTile(warehouse: w);
              },
            ),
          );
        },
      ),
    );
  }
}

class WarehouseListTile extends StatefulWidget {
  const WarehouseListTile({Key? key, required this.warehouse})
      : super(key: key);

  final Warehouse warehouse;

  @override
  State<WarehouseListTile> createState() => _WarehouseListTileState();
}

class _WarehouseListTileState extends State<WarehouseListTile> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      title: Text(widget.warehouse.name),
      subtitle: Text("Indirizzo: ${widget.warehouse.address}"),
      trailing: TextButton(
        onPressed: () async {
          final WarehouseProvider warehouseProvider =
              Provider.of<WarehouseProvider>(
            context,
            listen: false,
          );

          if (mounted) {
            setState(() {
              isLoading = true;
            });
          }

          await warehouseProvider.delete(widget.warehouse.id);

          if (mounted) {
            setState(() {
              isLoading = false;
            });
          }
        },
        child: isLoading
            ? const CircularProgressIndicator()
            : const Icon(Icons.delete, color: Colors.black54),
        style: TextButton.styleFrom(
          minimumSize: Size.zero,
          padding: EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
    );
  }
}
