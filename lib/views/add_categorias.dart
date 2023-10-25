import 'package:flutter/material.dart';
import '../models/crud.dart';

class AddCategoria extends StatefulWidget {
  const AddCategoria({Key? key});
  @override
  State<AddCategoria> createState() => _AddCategoriaState();
}

class _AddCategoriaState extends State<AddCategoria> {
  final TextEditingController _idController = TextEditingController(text: "");
  final TextEditingController _nombreController =
      TextEditingController(text: "");
  final TextEditingController _estadoController =
      TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Categoría'),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const Text(
              'Datos de la Categoría',
              style: TextStyle(
                fontSize: 30,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _idController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Ingrese el ID de la categoría',
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.pink,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _nombreController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Ingrese el nombre de la categoría',
                prefixIcon: Icon(
                  Icons.category,
                  color: Colors.red,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _estadoController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Ingrese el estado de la categoría',
                prefixIcon: Icon(
                  Icons.check_circle,
                  color: Colors.green,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                final id = _idController.text;
                final nombre = _nombreController.text;
                final estado = _estadoController.text;
                if (id.isNotEmpty && nombre.isNotEmpty && estado.isNotEmpty) {
                  await addCategoria(id, nombre, estado).then((_) {
                    Navigator.pop(context);
                  });
                } else {
// Puedes agregar manejo de error si los campos están vacíos
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Campos Vacíos'),
                        content: Text('Por favor, complete todos los campos.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Aceptar'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
