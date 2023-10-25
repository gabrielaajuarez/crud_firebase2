import 'package:flutter/material.dart';

class EditCategoria extends StatefulWidget {
  const EditCategoria({Key? key});
  @override
  State<EditCategoria> createState() => _EditCategoriaState();
}

class _EditCategoriaState extends State<EditCategoria> {
  final TextEditingController _idController = TextEditingController(text: "");
  final TextEditingController _nombreController =
      TextEditingController(text: "");
  final TextEditingController _estadoController =
      TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    _idController.text = arguments['id'] ?? '';
    _nombreController.text = arguments['nombre'];
    _estadoController.text = arguments['estado'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categoría'),
        backgroundColor: Colors.pink,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const Text(
                'Información de la Categoría',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
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
                  hintText: 'Digite el ID de la categoría',
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.blue,
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
                  hintText: 'Digite el nombre de la categoría',
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
                  hintText: 'Digite el estado de la categoría',
                  prefixIcon: Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
