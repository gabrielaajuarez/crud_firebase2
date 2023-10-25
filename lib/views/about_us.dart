import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
// Datos
  final String names = 'Tania Juarez'; // Nombre
  final String emails = 'tania.juarez22@itca.edu.sv'; // Correo

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acerca de nosotros'),
        backgroundColor: Colors.pink,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
// Imagen con fotos
            Image.asset(
              'images/img.jpeg', // Ruta de la imagen combinada
              width: 300.0,
              height: 300.0,
            ),
            SizedBox(height: 20.0),
            Text(
              names,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              emails,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
