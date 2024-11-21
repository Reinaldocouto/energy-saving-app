import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gs_2sem/components/Dispositivo.dart';
import 'package:http/http.dart' as http;

// Altere a URL base para o endpoint da sua API
const String baseUrl = "http://10.0.2.2:8080";

class ApiService {
  // Função para pegar todos os dispositivos
  Future<List<Dispositivo>> fetchDispositivos() async {
    final response = await http.get(Uri.parse('$baseUrl/dispositivos'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Dispositivo.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load devices');
    }
  }

  // Função para ligar/desligar um dispositivo e registrar o consumo
  Future<void> toggleDispositivo(int id, bool status) async {
    final response = await http.put(
      Uri.parse('$baseUrl/dispositivos/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'status': status}),
    );

    if (response.statusCode == 200) {
      // Se o dispositivo for ligado, registre o consumo
      if (status) {
        _registerConsumo(id, DateTime.now());
      }
    } else {
      throw Exception('Failed to update device status');
    }
  }

  // Função para registrar o consumo do dispositivo
  Future<void> _registerConsumo(int id, DateTime startTime) async {
    // A lógica para calcular o tempo e o consumo depende do tempo ligado
    final endTime = DateTime.now();
    final duration = endTime.difference(startTime).inMinutes;
    final consumo = (duration / 60) * 1.5; // Exemplo de cálculo de consumo (consumoPorHora)

    final consumoData = {
      'dispositivo_id': id,
      'data_hora_inicio': startTime.toIso8601String(),
      'data_hora_fim': endTime.toIso8601String(),
      'consumo_total': consumo
    };

    final response = await http.post(
      Uri.parse('$baseUrl/dispositivos/$id/consumo'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(consumoData),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to register consumption');
    }
  }

}
