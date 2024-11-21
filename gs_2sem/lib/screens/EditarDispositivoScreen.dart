import 'package:flutter/material.dart';
import 'package:gs_2sem/components/api_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditarDispositivoScreen extends StatefulWidget {
  final int id;
  final Map dispositivo;

  EditarDispositivoScreen({required this.id, required this.dispositivo});

  @override
  _EditarDispositivoScreenState createState() =>
      _EditarDispositivoScreenState();
}

class _EditarDispositivoScreenState extends State<EditarDispositivoScreen> {
  final _formKey = GlobalKey<FormState>();

  late String nome;
  late String tipo;
  late double consumoPorHora;
  late bool status;

  @override
  void initState() {
    super.initState();
    nome = widget.dispositivo['nome'];
    tipo = widget.dispositivo['tipo'];
    consumoPorHora = widget.dispositivo['consumoPorHora'];
    status = widget.dispositivo['status'];
  }

  Future<void> atualizarDispositivo() async {
    final String Url = '$baseUrl/dispositivos/${widget.id}';
    final dispositivo = {
      'nome': nome,
      'tipo': tipo,
      'consumoPorHora': consumoPorHora,
      'status': status
    };

    try {
      final response = await http.put(
        Uri.parse(Url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(dispositivo),
      );

      if (response.statusCode == 200) {
        Navigator.pop(context, true); // Retorna à Home com sucesso
      } else {
        throw Exception('Erro ao atualizar dispositivo: ${response.body}');
      }
    } catch (e) {
      print('Erro: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF42426F), // Cor semelhante à HomeScreen
        title: Text(
          'Editar Dispositivo',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Roboto',
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Color(0xFF1E1E2F), // Cor de fundo similar à HomeScreen
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nome',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Nome do dispositivo',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                initialValue: nome,
                onChanged: (value) => nome = value,
              ),
              SizedBox(height: 16),
              
              Text(
                'Tipo',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Tipo de dispositivo',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                initialValue: tipo,
                onChanged: (value) => tipo = value,
              ),
              SizedBox(height: 16),
              
              Text(
                'Consumo por Hora',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Consumo por hora',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                initialValue: consumoPorHora.toString(),
                keyboardType: TextInputType.number,
                onChanged: (value) =>
                    consumoPorHora = double.tryParse(value) ?? 0.0,
              ),
              SizedBox(height: 16),
              
              Text(
                'Status',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SwitchListTile(
                title: Text(
                  'Ativar/Desativar',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Roboto',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                value: status,
                onChanged: (value) => setState(() => status = value),
                activeColor: Colors.green,
                inactiveThumbColor: Colors.red,
                inactiveTrackColor: Colors.redAccent,
              ),
              SizedBox(height: 20),
              
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      atualizarDispositivo();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF42426F), // Cor igual à da HomeScreen
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: Text(
                    'Atualizar',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
