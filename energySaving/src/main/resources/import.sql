INSERT INTO tbl_dispositivo (nome, tipo, consumo_por_hora, status) VALUES ('Ar Condicionado', 'Eletrodoméstico', 1.5, TRUE);
INSERT INTO tbl_dispositivo (nome, tipo, consumo_por_hora, status) VALUES ('Geladeira', 'Eletrodoméstico', 2.0, TRUE);
INSERT INTO tbl_dispositivo (nome, tipo, consumo_por_hora, status) VALUES ('Lampada', 'Iluminação', 0.1, FALSE);

INSERT INTO tbl_consumo (dispositivo_id, data_hora_inicio, data_hora_fim, consumo_total) VALUES (1, '2024-11-02T08:00:00', '2024-11-02T10:00:00', 10.0);
INSERT INTO tbl_consumo (dispositivo_id, data_hora_inicio, data_hora_fim, consumo_total) VALUES (1, '2024-11-16T08:00:00', '2024-11-16T10:00:00', 2.0);
INSERT INTO tbl_consumo (dispositivo_id, data_hora_inicio, data_hora_fim, consumo_total) VALUES (1, '2024-11-17T08:00:00', '2024-11-17T10:00:00', 5.0);
INSERT INTO tbl_consumo (dispositivo_id, data_hora_inicio, data_hora_fim, consumo_total) VALUES (1, '2024-11-20T08:00:00', '2024-11-20T10:00:00', 3.0);


