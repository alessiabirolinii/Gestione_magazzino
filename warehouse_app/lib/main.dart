import 'package:flutter/material.dart';
import 'package:warehouse_app/pages/auth_controller.dart';
import 'package:warehouse_app/pages/navigator.dart';
import 'package:warehouse_app/providers/category.dart';
import 'package:warehouse_app/providers/auth.dart';
import 'package:warehouse_app/providers/product.dart';
import 'package:warehouse_app/providers/werehouse.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "warehouse_pcto",
      debugShowCheckedModeBanner: false,
      home: AuthInitializer(),
    );
  }
}

class AuthInitializer extends StatefulWidget {
  const AuthInitializer({Key? key}) : super(key: key);

  @override
  State<AuthInitializer> createState() => _AuthInitializerState();
}

class _AuthInitializerState extends State<AuthInitializer> {
  final AuthProvider authProvider = AuthProvider();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthProvider>.value(
      value: authProvider,
      child: FutureBuilder(
        future: authProvider.init(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.waiting) {
            return const Wrapper();
          }

          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Checking user"),
                  CircularProgressIndicator(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, widget) {
        if (authProvider.token != null) {
          return ProviderInitializer(authProvider: authProvider);
        }

        return const AuthenticationController();
      },
    );
  }
}

class ProviderInitializer extends StatefulWidget {
  const ProviderInitializer({
    Key? key,
    required this.authProvider,
  }) : super(key: key);

  final AuthProvider authProvider;

  @override
  State<ProviderInitializer> createState() => _ProviderInitializerState();
}

class _ProviderInitializerState extends State<ProviderInitializer> {
  bool isInitialized = false;
  late ProductProvider productProvider;
  late CategoryProvider categoryProvider;
  late WarehouseProvider warehouseProvider;

  @override
  void initState() {
    super.initState();
    initializeProvider();
  }

  void initializeProvider() async {
    warehouseProvider = WarehouseProvider();
    categoryProvider = CategoryProvider();
    productProvider = ProductProvider(
      categoryProvider: categoryProvider,
      warehouseProvider: warehouseProvider,
    );

    final AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);

    if (authProvider.email != "ciao@ciao.it") {
      categoryProvider.categories = [];
      warehouseProvider.warehouses = [];
      productProvider.products = [];
    }

    if (mounted) {
      setState(() => isInitialized = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!isInitialized) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("L'app si sta caricando..."),
              SizedBox(height: 20),
              CircularProgressIndicator(),
            ],
          ),
        ),
      );
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductProvider>.value(
          value: productProvider,
        ),
        ChangeNotifierProvider<CategoryProvider>.value(
          value: categoryProvider,
        ),
        ChangeNotifierProvider<WarehouseProvider>.value(
          value: warehouseProvider,
        ),
      ],
      child: const AppNavigator(),
    );
  }
}
