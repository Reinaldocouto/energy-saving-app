package br.com.energySaving.service;

import br.com.energySaving.model.Consumo;
import br.com.energySaving.repository.ConsumoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.time.LocalDateTime;
import java.time.LocalDate;
import java.util.List;

@Service
public class ConsumoService {

    @Autowired
    private ConsumoRepository consumoRepository;

    // Calcular o consumo diário de um dispositivo
    public Double calcularConsumoDiario(Long dispositivoId, LocalDate data) {
        LocalDateTime inicioDoDia = data.atStartOfDay();
        LocalDateTime fimDoDia = data.plusDays(1).atStartOfDay();

        List<Consumo> consumos = consumoRepository.findByDispositivoIdAndDataHoraInicioBetween(dispositivoId, inicioDoDia, fimDoDia);
        return consumos.stream()
                .mapToDouble(Consumo::getConsumoTotal)
                .sum();
    }

    // Calcular o consumo semanal de um dispositivo
    public Double calcularConsumoSemanal(Long dispositivoId, LocalDate dataInicio, LocalDate dataFim) {
        LocalDateTime inicioDaSemana = dataInicio.atStartOfDay();
        LocalDateTime fimDaSemana = dataFim.plusDays(1).atStartOfDay();

        List<Consumo> consumos = consumoRepository.findByDispositivoIdAndDataHoraInicioBetween(dispositivoId, inicioDaSemana, fimDaSemana);
        return consumos.stream()
                .mapToDouble(Consumo::getConsumoTotal)
                .sum();
    }

    // Calcular o consumo mensal de um dispositivo
    public Double calcularConsumoMensal(Long dispositivoId, LocalDate dataInicio, LocalDate dataFim) {
        LocalDateTime inicioDoMes = dataInicio.atStartOfDay();
        LocalDateTime fimDoMes = dataFim.plusDays(1).atStartOfDay();

        List<Consumo> consumos = consumoRepository.findByDispositivoIdAndDataHoraInicioBetween(dispositivoId, inicioDoMes, fimDoMes);
        return consumos.stream()
                .mapToDouble(Consumo::getConsumoTotal)
                .sum();
    }

    // Calcular o consumo total de todos os dispositivos em uma data
    public Double calcularConsumoTotal(LocalDateTime inicio, LocalDateTime fim) {
        List<Consumo> consumos = consumoRepository.findByDataHoraInicioBetween(inicio, fim);
        return consumos.stream()
                .mapToDouble(Consumo::getConsumoTotal)
                .sum();
    }

    public List<Consumo> listarTodos() {
        return consumoRepository.findAll();
    }
}

