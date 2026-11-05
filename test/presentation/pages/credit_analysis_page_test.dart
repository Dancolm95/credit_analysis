import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:credit_analysis_app/presentation/pages/credit_analysis_page.dart';

void main() {
  testWidgets('descripcion', (tester) async {

    //Montar la pantalla o pagina
    await tester.pumpWidget(
      const MaterialApp(
        home: CreditAnalysisPage(),
      )
    );
    // Esperar a que se renderice la pantalla
    await tester.pumpAndSettle();
    // Verificar que se muestre el texto "Ingreso mensual"
    expect(find.text('Ingreso mensual'), findsOneWidget);
  });

  testWidgets('muestra un textfield para ingresar datos necesarios', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: CreditAnalysisPage(),
      )
    );
    expect(find.byType(TextField), findsNWidgets(6));
  }); 

  testWidgets('permite ingresar el "Ingreso mensual"', (tester) async{
    await tester.pumpWidget(
      const MaterialApp(
        home: CreditAnalysisPage(),
      ),
    );

    await tester.enterText(find.byKey(const Key('monthlyIncome')), '5000');
    expect(find.byType(TextField), findsNWidgets(6));
  });
  testWidgets('Muestra el boton analizar', (tester) async{
    await tester.pumpWidget(
      const MaterialApp(
        home: CreditAnalysisPage(),
      ),
    );
    expect(find.text('Analizar'), findsOneWidget);
  });

  testWidgets('permite presionar el boton Analizar',(tester) async{
    await tester.pumpWidget(
      const MaterialApp(
        home: CreditAnalysisPage(),
      ),
    );
    await tester.enterText(
      find.byKey(const Key('monthlyIncome')), '5000',
    );

    await tester.tap(find.text('Analizar'));
    await tester.pump();

    expect(find.text('Ingreso registrado: 5000'), findsOneWidget);
  });
  testWidgets('muestra un error si el ingreso no es de tipo numerico', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: CreditAnalysisPage(),
      ),
    );
    await tester.enterText(
      find.byKey(const Key('monthlyIncome')), 'abc',
    );
    await tester.tap(find.text('Analizar'));
    await tester.pump();

    expect(
      find.text('Por favor, ingrese un ingreso válido.'),
      findsOneWidget,
    );
  });
}