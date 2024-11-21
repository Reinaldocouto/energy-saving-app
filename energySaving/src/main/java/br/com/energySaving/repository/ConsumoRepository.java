package br.com.energySaving.repository;

import br.com.energySaving.model.Consumo;
import org.springframework.data.jpa.repository.JpaRepository;
import java.time.LocalDateTime;
import java.util.List;

public interface ConsumoRepository extends JpaRepository<Consumo, Long> {

    // Buscar consumos de um dispositivo entre duas datas
    List<Consumo> findByDispositivoIdAndDataHoraInicioBetween(Long dispositivoId, LocalDateTime startDate, LocalDateTime endDate);

    // Buscar todos os consumos em um intervalo de tempo
    List<Consumo> findByDataHoraInicioBetween(LocalDateTime startDate, LocalDateTime endDate);
}

