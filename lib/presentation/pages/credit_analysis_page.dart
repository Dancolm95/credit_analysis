import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';    

class CreditAnalysisPage extends StatefulWidget {
  const CreditAnalysisPage({super.key});

  @override
  State<CreditAnalysisPage> createState() => _CreditAnalysisPageState();
}

class _CreditAnalysisPageState extends State<CreditAnalysisPage> {
  final incomeController = TextEditingController();
  String? message;

  void analyze() {
    final income = double.tryParse(incomeController.text);
    if (income == null) {
      setState(() {
        message = 'Por favor, ingrese un ingreso válido.';
      });
      return;
    }         
    setState(() {
      message = 'Ingreso registrado: ${income.toStringAsFixed(0)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: incomeController,
              key: const Key('monthlyIncome'),
              decoration: InputDecoration(
                labelText: 'Ingreso mensual',
              ),
            ),
            TextField(
              key: const Key('creditCards'),
              decoration: InputDecoration(
                labelText: 'Deudas de tarjetas de crédito',
              ),
            ),
            TextField(
              key: const Key('personalLoans'),
              decoration: InputDecoration(
                labelText: 'Préstamos personales',
              ),
            ),
            TextField(
              key: const Key('vehicleLoan'),
              decoration: InputDecoration(
                labelText: 'Préstamo de vehículo',
              ),
            ),
            TextField(
              key: const Key('mortgage'),
              decoration: InputDecoration(
                labelText: 'Hipoteca',
              ),
            ),
            TextField(
              key: const Key('otherDebts'),
              decoration: InputDecoration(
                labelText: 'Otras deudas',
              ),
            ),
            ElevatedButton(
              onPressed: analyze,
              child: const Text('Analizar'),
            ),
            if (message != null) Text(message!),
          ]
        )
      )
    );
  }
}