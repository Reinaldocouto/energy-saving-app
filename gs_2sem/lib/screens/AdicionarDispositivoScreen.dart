import 'package:flutter/material.dart';
import 'package:gs_2sem/components/api_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdicionarDispositivoScreen extends StatefulWidget {
  @override
  _AdicionarDispositivoScreenState createState() =>
      _AdicionarDispositivoScreenState();
}

class _AdicionarDispositivoScreenState
    extends State<AdicionarDispositivoScreen> {
  final _formKey = GlobalKey<FormState>();

  String nome = '';
  String tipo = '';
  double consumoPorHora = 0.0;
  bool status = false;

  Future<void> adicionarDispositivo() async {
    final String Url = '$baseUrl/dispositivos';
    final dispositivo = {
      'nome': nome,
      'tipo': tipo,
      'consumoPorHora': consumoPorHora,
      'status': status
    };

    try {
      final response = await http.post(
        Uri.parse(Url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(dispositivo),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Exibe uma confirmação
        _showSuccessConfirmation();
        Navigator.pop(context, true); // Passa true para indicar sucesso
      } else {
        throw Exception('Erro ao adicionar dispositivo: ${response.body}');
      }
    } catch (e) {
      // Exibe uma mensagem de erro caso haja falha na requisição
      _showErrorConfirmation();
    }
  }

  void _showSuccessConfirmation() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Dispositivo adicionado com sucesso!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showErrorConfirmation() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Falha ao adicionar dispositivo!'),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF42426F),
        title: Text(
          'Adicionar Dispositivo',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        color: Color(0xFFF4F4F9),
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nome',
                  labelStyle: TextStyle(
                    color: Color(0xFF42426F),
                    fontSize: 16.0,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF42426F)),
                  ),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => nome = value,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Tipo',
                  labelStyle: TextStyle(
                    color: Color(0xFF42426F),
                    fontSize: 16.0,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF42426F)),
                  ),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => tipo = value,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Consumo por Hora',
                  labelStyle: TextStyle(
                    color: Color(0xFF42426F),
                    fontSize: 16.0,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF42426F)),
                  ),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    consumoPorHora = double.tryParse(value) ?? 0.0;
                  }
                },
              ),
              SizedBox(height: 16),
              SwitchListTile(
                title: Text(
                  'Status',
                  style: TextStyle(
                    color: Color(0xFF42426F),
                  ),
                ),
                value: status,
                onChanged: (value) => setState(() => status = value),
                activeColor: Color(0xFF42426F),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState != null &&
                      _formKey.currentState!.validate()) {
                    adicionarDispositivo();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF42426F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  'Adicionar',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
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
