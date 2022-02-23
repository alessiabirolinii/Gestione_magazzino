import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warehouse_app/models/category.dart';
import 'package:warehouse_app/models/product.dart';
import 'package:warehouse_app/models/warehouse.dart';
import 'package:warehouse_app/providers/category.dart';
import 'package:warehouse_app/providers/product.dart';
import 'package:warehouse_app/providers/werehouse.dart';

class AddPage extends StatelessWidget {
  const AddPage({Key? key}) : super(key: key);

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
            ProductAddView(),
            CategoryAddView(),
            WarehouseAddView(),
          ],
        ),
      ),
    );
  }
}

class ProductAddView extends StatefulWidget {
  const ProductAddView({Key? key}) : super(key: key);

  @override
  State<ProductAddView> createState() => _ProductAddViewState();
}

class _ProductAddViewState extends State<ProductAddView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController titoloController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  String? categoriaSelezionata;
  String? magazzinoSelezionato;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProductProvider>(
        builder: (context, value, child) {
          return Form(
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
                              items: value.categoryProvider.categories.map(
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
                              items: value.warehouseProvider.warehouses.map(
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
                        if (formKey.currentState!.validate()) {
                          if (mounted) {
                            setState(() {
                              isLoading = true;
                            });
                          }

                          final ProductProvider productProvider =
                              Provider.of<ProductProvider>(
                            context,
                            listen: false,
                          );

                          final Category cate =
                              value.categoryProvider.categories
                                  .where(
                                    (element) =>
                                        element.name == categoriaSelezionata,
                                  )
                                  .first;
                          final Warehouse ware =
                              value.warehouseProvider.warehouses
                                  .where(
                                    (element) =>
                                        element.name == magazzinoSelezionato,
                                  )
                                  .first;

                          await productProvider.create(
                            ProductCreateDTO(
                              title: titoloController.text,
                              date: DateTime.now(),
                              price: double.parse(priceController.text),
                              quantity: int.parse(quantityController.text),
                              category: cate,
                              warehouse: ware,
                            ),
                          );

                          if (mounted) {
                            setState(() {
                              isLoading = false;
                            });
                          }
                        }
                      },
                      child: !isLoading
                          ? const Text('Add')
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
        },
      ),
    );
  }
}

class CategoryAddView extends StatefulWidget {
  const CategoryAddView({Key? key}) : super(key: key);

  @override
  State<CategoryAddView> createState() => _CategoryAddViewState();
}

class _CategoryAddViewState extends State<CategoryAddView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProductProvider>(
        builder: (context, value, child) {
          return Form(
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
                      if (formKey.currentState!.validate()) {
                        if (mounted) {
                          setState(() {
                            isLoading = true;
                          });
                        }

                        final CategoryProvider categoryProvider =
                            Provider.of<CategoryProvider>(
                          context,
                          listen: false,
                        );

                        await categoryProvider.create(
                          CategoryCreateDTO(
                            name: nameController.text,
                          ),
                        );

                        if (mounted) {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      }
                    },
                    child: !isLoading
                        ? const Text('Add')
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
          );
        },
      ),
    );
  }
}

class WarehouseAddView extends StatefulWidget {
  const WarehouseAddView({Key? key}) : super(key: key);

  @override
  State<WarehouseAddView> createState() => _WarehouseAddViewState();
}

class _WarehouseAddViewState extends State<WarehouseAddView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProductProvider>(
        builder: (context, value, child) {
          return Form(
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
                        if (formKey.currentState!.validate()) {
                          if (mounted) {
                            setState(() {
                              isLoading = true;
                            });
                          }

                          final WarehouseProvider warehouseProvider =
                              Provider.of<WarehouseProvider>(
                            context,
                            listen: false,
                          );

                          await warehouseProvider.create(
                            WarehouseCreateDTO(
                              name: nameController.text,
                              address: addressController.text,
                            ),
                          );

                          if (mounted) {
                            setState(() {
                              isLoading = false;
                            });
                          }
                        }
                      },
                      child: !isLoading
                          ? const Text('Add')
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
        },
      ),
    );
  }
}
