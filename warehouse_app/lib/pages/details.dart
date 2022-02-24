import 'package:flutter/material.dart';
import 'package:warehouse_app/models/category.dart';
import 'package:warehouse_app/models/product.dart';
import 'package:warehouse_app/models/warehouse.dart';
import 'package:warehouse_app/providers/category.dart';
import 'package:warehouse_app/providers/product.dart';
import 'package:warehouse_app/providers/werehouse.dart';

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
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController titoloController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  String? categoriaSelezionata;
  String? magazzinoSelezionato;

  @override
  void initState() {
    super.initState();
    titoloController.text = widget.product.title;
    priceController.text = widget.product.price.toString();
    quantityController.text = widget.product.quantity.toString();
    categoriaSelezionata = widget.product.category.name;
    magazzinoSelezionato = widget.product.warehouse.name;
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.product.title)),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: titoloController,
                  decoration: InputDecoration(
                    labelText: "Titolo",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Inserisci qualcosa";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: priceController,
                  decoration: InputDecoration(
                    labelText: "Prezzo",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Inserisci qualcosa";
                    }

                    if (double.tryParse(value) == null) {
                      return "Inserisci un numero";
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: quantityController,
                  decoration: InputDecoration(
                    labelText: "Quantità",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Inserisci qualcosa";
                    }

                    if (double.tryParse(value) == null) {
                      return "Inserisci un numero";
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 20),
                FormField(
                  builder: (state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        errorStyle: const TextStyle(
                          color: Colors.redAccent,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      isEmpty: categoriaSelezionata == '',
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          hint: const Text("Categoria"),
                          value: categoriaSelezionata,
                          isDense: true,
                          onChanged: (newValue) {
                            setState(() {
                              categoriaSelezionata = newValue;
                              state.didChange(newValue);
                            });
                          },
                          items: widget
                              .productProvider.categoryProvider.categories
                              .map(
                            (value) {
                              return DropdownMenuItem<String>(
                                value: value.name,
                                child: Text(value.name),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                FormField<String>(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Inserisci qualcosa";
                    }
                    return null;
                  },
                  builder: (state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        errorStyle: const TextStyle(
                          color: Colors.redAccent,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      isEmpty: magazzinoSelezionato == '',
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          hint: const Text("Magazzino"),
                          value: magazzinoSelezionato,
                          isDense: true,
                          onChanged: (newValue) {
                            setState(() {
                              magazzinoSelezionato = newValue;
                              state.didChange(newValue);
                            });
                          },
                          items: widget
                              .productProvider.warehouseProvider.warehouses
                              .map(
                            (value) {
                              return DropdownMenuItem<String>(
                                value: value.name,
                                child: Text(value.name),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (mounted) {
                      setState(() {
                        isLoading = true;
                      });
                    }

                    final Category cate =
                        widget.productProvider.categoryProvider.categories
                            .where(
                              (element) => element.name == categoriaSelezionata,
                            )
                            .first;
                    final Warehouse ware =
                        widget.productProvider.warehouseProvider.warehouses
                            .where(
                              (element) => element.name == magazzinoSelezionato,
                            )
                            .first;

                    await widget.productProvider.update(
                      ProductReadAndUpdateDTO(
                        code: widget.product.code,
                        title: titoloController.text,
                        date: DateTime.now(),
                        price: double.parse(priceController.text),
                        quantity: int.parse(quantityController.text),
                        category: cate,
                        warehouse: ware,
                      ),
                    );

                    magazzinoSelezionato = null;
                    categoriaSelezionata = null;
                    titoloController.clear();
                    priceController.clear();
                    quantityController.clear();

                    if (mounted) {
                      setState(() {
                        isLoading = false;
                      });
                    }

                    Navigator.pop(context);
                  },
                  child: !isLoading
                      ? const Text('Edit')
                      : const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryDetailsView extends StatefulWidget {
  const CategoryDetailsView({
    Key? key,
    required this.category,
    required this.categoryProvider,
  }) : super(key: key);

  final Category category;
  final CategoryProvider categoryProvider;

  @override
  State<CategoryDetailsView> createState() => _CategoryDetailsViewState();
}

class _CategoryDetailsViewState extends State<CategoryDetailsView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    nameController.text = widget.category.name;
    super.initState();
  }

  final TextEditingController nameController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.category.name)),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Nome",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Inserisci qualcosa";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (mounted) {
                    setState(() {
                      isLoading = true;
                    });
                  }

                  await widget.categoryProvider.update(
                    Category(
                      code: widget.category.code,
                      name: nameController.text,
                    ),
                  );

                  nameController.clear();

                  if (mounted) {
                    setState(() {
                      isLoading = false;
                    });
                  }

                  Navigator.pop(context);
                },
                child: !isLoading
                    ? const Text('Edit')
                    : const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WarehouseDetailsView extends StatefulWidget {
  const WarehouseDetailsView({
    Key? key,
    required this.warehouse,
    required this.warehouseProvider,
  }) : super(key: key);

  final Warehouse warehouse;
  final WarehouseProvider warehouseProvider;

  @override
  State<WarehouseDetailsView> createState() => _WarehouseDetailsViewState();
}

class _WarehouseDetailsViewState extends State<WarehouseDetailsView> {
  @override
  void initState() {
    nameController.text = widget.warehouse.name;
    addressController.text = widget.warehouse.address;
    super.initState();
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.warehouse.name)),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "Nome",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Inserisci qualcosa";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(
                    labelText: "Indirizzo",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Inserisci qualcosa";
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (mounted) {
                      setState(() {
                        isLoading = true;
                      });
                    }

                    await widget.warehouseProvider.update(
                      Warehouse(
                        id: widget.warehouse.id,
                        name: nameController.text,
                        address: addressController.text,
                      ),
                    );

                    nameController.clear();
                    addressController.clear();

                    if (mounted) {
                      setState(() {
                        isLoading = false;
                      });
                    }

                    Navigator.pop(context);
                  },
                  child: !isLoading
                      ? const Text('Edit')
                      : const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
