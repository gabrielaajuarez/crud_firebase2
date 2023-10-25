import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:crud_firebase/models/crud.dart';
import 'package:crud_firebase/views/about_us.dart';
import 'package:quickalert/quickalert.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void alertas() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
    ); // That's it to display an alert, use other properties to customize.
  }

  void alertas1(QuickAlertType quickAlertType, String title, String text) {
    QuickAlert.show(
        context: context,
        title: title,
        text: text,
        type: quickAlertType,
        confirmBtnText: 'Yes',
        cancelBtnText: 'No',
        confirmBtnColor: Colors.green,
        barrierDismissible:
            false); // That's it to display an alert, use other properties to customize.
  }

  void confirmar(String titulo, String texto) {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.confirm,
        title: titulo,
        text: texto,
        confirmBtnText: 'Aceptar',
        cancelBtnText: 'Cancelar',
        confirmBtnColor: Colors.green,
        barrierDismissible: false,
        onConfirmBtnTap: () {
          FirebaseAuth.instance.signOut();
          Navigator.pushNamed(context, "/login");
        },
        onCancelBtnTap: () {
          Navigator.of(context).pop();
        });
  }

  void _dataFirestore() {
    db.collection("tb-categoria").get().then(
      (querySnapshot) {
        print("Consulta completada exitosamente");
        for (var docSnapshot in querySnapshot.docs) {
          print('${docSnapshot.id} => ${docSnapshot.data()}');
        }
      },
      onError: (e) => print("Error al completar la consulta: $e"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                print("has presionado icono menu");
              },
            );
          }),
          actions: [
            IconButton(
              onPressed: () {
                confirmar('Pregunta...', 'realmente desea salir?');
                //_alertClose();
              },
              icon: const Icon(Icons.close),
            ),
            IconButton(
              onPressed: () {
                alertas1(
                  QuickAlertType.success,
                  'Respuesta',
                  'datos guardados correctamente',
                );
              },
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              icon: Icon(Icons.info),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutUs()));
              },
            ),
          ]),
      body: FutureBuilder(
        future: getCategorias(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: ((context, index) {
                return Dismissible(
                  onDismissed: (direction) async {
                    await deleteCategoria(snapshot.data?[index]["id"]);
                    snapshot.data?.removeAt(index);
                    setState(() {});
                  },
                  confirmDismiss: (direction) async {
                    bool result = false;
                    result = await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                              "¿Realmente desea eliminar la categoría ${snapshot.data?[index]['nombre']}?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, false);
                              },
                              child: const Text(
                                "Cancelar",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 255, 7, 7),
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              child: const Text("Aceptar"),
                            )
                          ],
                        );
                      },
                    );

                    return result;
                  },
                  background: Container(
                    color: Color.fromARGB(255, 244, 54, 60),
                    child: const Icon(Icons.delete),
                  ),
                  key: Key(snapshot.data?[index]['id'] ?? ''),
                  direction: DismissDirection.endToStart,
                  child: Card(
                    elevation: 10,
                    clipBehavior: Clip.hardEdge,
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.pink,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: InkWell(
                      splashColor: Color.fromARGB(255, 59, 203, 255),
                      onTap: () async {
                        await Navigator.pushNamed(context, "/edit", arguments: {
                          'id': snapshot.data?[index]['id'],
                          'nombre': snapshot.data?[index]['nombre'],
                          'estado': snapshot.data?[index]['estado'],
                        });

                        setState(() {});
                      },
                      child: SizedBox(
                        width: 600,
                        height: 100,
                        child: Center(
                          child: Text(
                            snapshot.data?[index]['nombre'],
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 233, 30, 98)),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, "/add");

          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
