import 'package:flutter/material.dart';
import 'package:gs_2sem/components/Dispositivo.dart';
import 'package:gs_2sem/components/api_service.dart';

class AddEditDeviceScreen extends StatefulWidget {
  @override
  _AddEditDeviceScreenState createState() => _AddEditDeviceScreenState();
}

class _AddEditDeviceScreenState extends State<AddEditDeviceScreen> {
  final ApiService _apiService = ApiService();
  final _formKey = GlobalKey<FormState>();
  String _nome = '';
  String _tipo = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Dispositivo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome'),
                onChanged: (value) {
                  _nome = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nome é obrigatório';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Tipo'),
                onChanged: (value) {
                  _tipo = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tipo é obrigatório';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Adicionar dispositivo através da API
                      Dispositivo novoDispositivo = Dispositivo(id: 0, nome: _nome, tipo: _tipo);
                      // Chame a função de adicionar o dispositivo
                    }
                  },
                  child: Text('Salvar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
