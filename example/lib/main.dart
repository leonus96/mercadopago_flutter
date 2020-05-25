import 'package:flutter/material.dart';

import 'package:mercadopago_flutter/mercadopago_flutter.dart';
import 'package:mercadopago_flutter/models/MPCustomer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    MercadoPagoFlutter mp = MercadoPagoFlutter(
      accessToken:
          'ACCESS_TOKEN',
      publicKey: 'PUBLIC_KEY',
    );

    mp
        .getCustomer('451334753-PicL1U40mxaTvO')
        .then((MPCustomer customer) async {
      // MPCardholder holder  = MPCardholder(
      //     identification: customer.identification,
      //     name: "${customer.firstName} ${customer.lastName}",
      // );
      // MPCard card = await mp.createCard(
      //   securityCode: '123',
      //   cardNumber: '4170068810108020',
      //   expirationMonth: 11,
      //   expirationYear: 2025,
      //   cardHolder: holder,
      // );

      // card = await mp.linkCardWithCustomer(customer: customer, card: card);

      // print(card.id); 1590170964980

      // await mp.deleteCard(
      //   customerId: customer.id,
      //   cardId: '1590170964980',
      // );

      // MPCard card = await mp.getCard(
      //   customerId: customer.id,
      //   cardId: '1590170964980',
      // );
      // print(card.id);
    });

    // mp.searchCustomer({'email': 'leonus96@gmail.com'})5
    //   .then((List<MPCustomer> customers) {
    //     print("LLEGARON LOS CUSTOMERS");
    //     print(customers[0].email);
    //   });

    // MPCustomer customer = MPCustomer(
    //   email: 'prueba101@gmail.com',
    //   firstName: 'Prueba',
    //   lastName: 'cien',
    //   phone: MPPhone(areaCode: '+51', number: '987654321'),
    //   address: MPAddress(
    //     zipCode: "SG1 2AX",
    //     streetName: "Old Knebworth Ln 123",
    //   ),
    //   description: "Una descripcion",
    // );
    

    //mp.createCustomer(customer);

    // mp.getCardsOfUser('451334753-PicL1U40mxaTvO');


    mp.getCustomer('451334753-PicL1U40mxaTvO')
      .then((MPCustomer customer) async {
        var cardToken = await mp.getCardToken(ccv: '123', cardId: customer.cards[0].id);
        
        if(cardToken == 'error') {
          print('error de token');
        }

        print(cardToken);


        var pay = await mp.createPay(
          token: cardToken, 
          transactionAmount: 20.0, 
          paymentMethodId: customer.cards[0].paymentMethod.id, 
          customer: customer
        );

        if(pay.error != null) {
          print('error en pago : ${pay.error.message}');
        } else {
          print('pago realizado ${pay.id}');
        }

        

        
      });

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
