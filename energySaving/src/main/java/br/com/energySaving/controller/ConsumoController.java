package br.com.energySaving.controller;

import br.com.energySaving.model.Consumo;
import br.com.energySaving.service.ConsumoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/consumo")
public class ConsumoController {

    @Autowired
    private ConsumoService consumoService;

    // Endpoint para calcular consumo diário
    @GetMapping("/diario/{dispositivoId}")
    public Double getConsumoDiario(@PathVariable Long dispositivoId, @RequestParam("data") LocalDate data) {
        return consumoService.calcularConsumoDiario(dispositivoId, data);
    }

    // Endpoint para calcular consumo semanal
    @GetMapping("/semanal/{dispositivoId}")
    public Double getConsumoSemanal(@PathVariable Long dispositivoId, @RequestParam("dataInicio") LocalDate dataInicio, @RequestParam("dataFim") LocalDate dataFim) {
        return consumoService.calcularConsumoSemanal(dispositivoId, dataInicio, dataFim);
    }

    // Endpoint para calcular consumo mensal
    @GetMapping("/mensal/{dispositivoId}")
    public Double getConsumoMensal(@PathVariable Long dispositivoId, @RequestParam("dataInicio") LocalDate dataInicio, @RequestParam("dataFim") LocalDate dataFim) {
        return consumoService.calcularConsumoMensal(dispositivoId, dataInicio, dataFim);
    }

    // Endpoint para calcular o consumo total de todos os dispositivos
    @GetMapping("/total")
    public Double getConsumoTotal(@RequestParam("dataInicio") LocalDateTime dataInicio, @RequestParam("dataFim") LocalDateTime dataFim) {
        return consumoService.calcularConsumoTotal(dataInicio, dataFim);
    }

    // Endpoint para listar todos os consumos
    @GetMapping
    public List<Consumo> listarTodos() {
        return consumoService.listarTodos();
    }
}
