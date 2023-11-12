import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showImageContainer =
      false; // Variable para mostrar/ocultar el contenedor de la imagen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Bienvenido a la pantalla de inicio',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            _showImageContainer
                ? Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'Aquí se mostrará la imagen',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )
                : Container(), // Contenedor de imagen oculto inicialmente
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Muestra u oculta el contenedor de la imagen cuando se presiona el botón
                setState(() {
                  _showImageContainer = !_showImageContainer;
                });
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // Color de fondo del botón
              ),
              child: Text(
                _showImageContainer
                    ? 'Ocultar Imagen'
                    : 'Subir imagen desde la galería',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
