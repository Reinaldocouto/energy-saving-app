import 'package:flutter/material.dart';
import 'package:gs_2sem/components/api_service.dart';
import 'package:gs_2sem/screens/EditarDispositivoScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DeviceDetailScreen extends StatefulWidget {
  final int dispositivoId;

  DeviceDetailScreen({required this.dispositivoId});

  @override
  _DeviceDetailScreenState createState() => _DeviceDetailScreenState();
}

class _DeviceDetailScreenState extends State<DeviceDetailScreen> {
  late Future<Map<String, dynamic>> dispositivoData;
  String selectedFilter = 'diario';

  @override
  void initState() {
    super.initState();
    dispositivoData = fetchDispositivo(widget.dispositivoId);
  }

  Future<Map<String, dynamic>> fetchDispositivo(int id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/dispositivos/$id'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );

    if (response.statusCode == 200) {
      return json.decode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Erro ao carregar dispositivo');
    }
  }

  Future<double> fetchConsumo(int dispositivoId, String filter) async {
    String url;
    DateTime today = DateTime.now();

    if (filter == 'diario') {
      String formattedDate = today.toIso8601String().split("T")[0];
      url = '$baseUrl/consumo/diario/$dispositivoId?data=$formattedDate';
    } else if (filter == 'semanal') {
      DateTime lastWeek = today.subtract(Duration(days: 7));
      String formattedStart = lastWeek.toIso8601String().split("T")[0];
      String formattedEnd = today.toIso8601String().split("T")[0];
      url =
          '$baseUrl/consumo/semanal/$dispositivoId?dataInicio=$formattedStart&dataFim=$formattedEnd';
    } else {
      DateTime firstDayOfMonth = DateTime(today.year, today.month, 1);
      DateTime lastDayOfMonth = DateTime(today.year, today.month + 1, 0);
      String formattedStart = firstDayOfMonth.toIso8601String().split("T")[0];
      String formattedEnd = lastDayOfMonth.toIso8601String().split("T")[0];
      url =
          '$baseUrl/consumo/mensal/$dispositivoId?dataInicio=$formattedStart&dataFim=$formattedEnd';
    }

    final response = await http.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );

    if (response.statusCode == 200) {
      return double.parse(response.body);
    } else {
      throw Exception('Erro ao carregar consumo');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = Color(0xFF1E1E2C);
    final Color appBarColor = Color(0xFF42426F);
    final Color cardColor = Colors.white;
    final Color buttonColor = Colors.green;

    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<Map<String, dynamic>>(
          future: dispositivoData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(
                'Detalhes: ${snapshot.data!['nome']}',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              );
            } else {
              return Text('Carregando...',
                  style: TextStyle(color: Colors.white));
            }
          },
        ),
        backgroundColor: appBarColor,
      ),
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            FutureBuilder<Map<String, dynamic>>(
              future: dispositivoData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final dispositivo = snapshot.data!;
                  return Align(
                    alignment: Alignment
                        .topLeft, // Isso garante que o conteúdo esteja alinhado à esquerda
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tipo: ${dispositivo['tipo'] ?? 'N/A'}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Roboto',
                          ),
                        ),
                        SizedBox(height: 8),
                        Text.rich(
                          TextSpan(
                            text: 'Status: ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            children: [
                              TextSpan(
                                text: dispositivo['status'] == true
                                    ? 'Ligado'
                                    : 'Desligado',
                                style: TextStyle(
                                  color: dispositivo['status'] == true
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Text('Carregando informações...',
                      style: TextStyle(color: Colors.white));
                }
              },
            ),
            SizedBox(height: 16),
            Text(
              'Consumo de Energia',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            FutureBuilder<double>(
              future: fetchConsumo(widget.dispositivoId, selectedFilter),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Erro: ${snapshot.error}',
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                } else if (snapshot.hasData) {
                  return Center(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(color: Colors.black, width: 2),
                      ),
                      color: cardColor,
                      elevation: 8,
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Text(
                          '${snapshot.data!.toStringAsFixed(2)} kWh',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: buttonColor,
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Center(child: Text('Sem dados'));
                }
              },
            ),
            SizedBox(height: 16),
            Center(
              child: ToggleButtons(
                isSelected: [
                  selectedFilter == 'diario',
                  selectedFilter == 'semanal',
                  selectedFilter == 'mensal'
                ],
                onPressed: (index) {
                  setState(() {
                    selectedFilter = ['diario', 'semanal', 'mensal'][index];
                  });
                },
                borderRadius: BorderRadius.circular(8),
                selectedColor: Colors.white,
                fillColor: appBarColor,
                color: Colors.white,
                borderColor: Colors.white,
                borderWidth: 1.5,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Diário')),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Semanal')),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Mensal')),
                ],
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _navigateToEditScreen,
                    child: Text(
                      'Editar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18, // Tamanho maior para o texto
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.blue, // Cor de fundo (pode ajustar se quiser)
                      foregroundColor: Colors.white, // Cor do texto
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _deleteDispositivo(context),
                    child: Text(
                      'Deletar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _deleteDispositivo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirmar Exclusão'),
        content: Text('Deseja realmente deletar este dispositivo?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Não'),
          ),
          TextButton(
            onPressed: () async {
              final response = await http.delete(
                Uri.parse(
                    '$baseUrl/dispositivos/${widget.dispositivoId}'),
              );
              if (response.statusCode == 200) {
                Navigator.of(context).pop();
                Navigator.pop(context, true);
              } else {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Erro ao deletar dispositivo')),
                );
              }
            },
            child: Text('Sim'),
          ),
        ],
      ),
    );
  }

  void _navigateToEditScreen() async {
    final dispositivo = await fetchDispositivo(widget.dispositivoId);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditarDispositivoScreen(
          id: widget.dispositivoId,
          dispositivo: dispositivo, // Now resolved
        ),
      ),
    );
  }
}
