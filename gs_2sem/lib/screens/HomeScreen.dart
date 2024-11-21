import 'dart:convert'; // Import necessário para UTF-8
import 'package:flutter/material.dart';
import 'package:gs_2sem/components/Dispositivo.dart';
import 'package:gs_2sem/components/api_service.dart';
import 'package:gs_2sem/screens/AdicionarDispositivoScreen.dart';
import 'package:gs_2sem/screens/DetailScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Dispositivo>> _dispositivos;

  @override
  void initState() {
    super.initState();
    _dispositivos = ApiService().fetchDispositivos(); // Carregar os dispositivos na inicialização
  }

  // Função para recarregar os dispositivos
  void _recarregarDispositivos() {
    setState(() {
      _dispositivos = ApiService().fetchDispositivos(); // Refaz a chamada à API
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A1F44),
      appBar: AppBar(
        backgroundColor: Color(0xFF12264F),
        title: Text(
          utf8.decode('Gerenciar Dispositivos'.runes.toList()),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Arial',
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Dispositivo>>(
              future: _dispositivos,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      utf8.decode('Erro ao carregar dispositivos'.runes.toList()),
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text(
                      utf8.decode('Nenhum dispositivo encontrado'.runes.toList()),
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  );
                } else {
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final dispositivo = snapshot.data![index];
                      return _buildDispositivoCard(dispositivo);
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () async {
                // Navega para a tela de adicionar dispositivo
                final resultado = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdicionarDispositivoScreen(),
                  ),
                );

                if (resultado == true) {
                  // Se o resultado for true, recarrega a lista de dispositivos
                  _recarregarDispositivos();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 32, 4, 49),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Center(
                child: Text(
                  utf8.decode('Adicionar Novo Dispositivo'.runes.toList()),
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDispositivoCard(Dispositivo dispositivo) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.indigo[700],
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.black, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.devices, color: Colors.white, size: 30),
            SizedBox(width: 12),
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DeviceDetailScreen(dispositivoId: dispositivo.id)),
                  );
                },
                child: Text(
                  dispositivo.nome ?? 'Dispositivo Desconhecido',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            Column(
              children: [
                IconButton(
                  icon: Icon(
                    dispositivo.status
                        ? Icons.power_settings_new
                        : Icons.power_settings_new_outlined,
                    color: dispositivo.status ? Colors.green : Colors.red,
                    size: 30,
                  ),
                  onPressed: () async {
                    bool novoStatus = await _alterarStatusDispositivo(dispositivo);
                    setState(() {
                      dispositivo.status = novoStatus;
                    });
                  },
                ),
                Text(
                  dispositivo.status
                      ? utf8.decode('Ligado'.runes.toList())
                      : utf8.decode('Desligado'.runes.toList()),
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _alterarStatusDispositivo(Dispositivo dispositivo) async {
    try {
      await ApiService().toggleDispositivo(dispositivo.id, !dispositivo.status);
      return !dispositivo.status;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(utf8.decode('Erro ao alterar status do dispositivo'.runes.toList())),
          backgroundColor: Colors.red,
        ),
      );
      return dispositivo.status;
    }
  }
}
