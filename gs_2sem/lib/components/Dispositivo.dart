class Dispositivo {
  int id;
  String nome;
  String tipo;
  bool status; // True para ligado, false para desligado

  Dispositivo({required this.id, required this.nome, required this.tipo, this.status = false});

  factory Dispositivo.fromJson(Map<String, dynamic> json) {
    return Dispositivo(
      id: json['id'],
      nome: json['nome'],
      tipo: json['tipo'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'tipo': tipo,
      'status': status,
    };
  }
}
