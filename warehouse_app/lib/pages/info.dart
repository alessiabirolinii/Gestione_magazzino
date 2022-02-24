import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warehouse_app/providers/auth.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("No"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Si"),
      onPressed: () async {
        final p = Provider.of<AuthProvider>(context, listen: false);
        p.remove();
        Navigator.pop(context);
        await p.logout();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("AlertDialog"),
      content: const Text(
        "Premendo si eliminerai tutti i tuoi dati, vuoi comunque procedere?",
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Gestione Prodotti",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text("Utente collegato: ${authProvider.email}"),
            const SizedBox(height: 40),
            const Text("App per la gestione di prodotto e magazzini"),
            const SizedBox(height: 10),
            const Text("Realizata da Acevedo Martin Thomas"),
            const SizedBox(height: 10),
            const Text("Gruppo PCTO: Acevedo, Birolini e Muraru"),
            const SizedBox(height: 200),
            TextButton(
              onPressed: () async {
                final AuthProvider authProvider =
                    Provider.of<AuthProvider>(context, listen: false);
                await authProvider.logout();
              },
              child: const Text("Logout"),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () async {
                showAlertDialog(context);
              },
              child: const Text("Revoca permaessi privacy"),
            ),
          ],
        ),
      ),
    );
  }
}
