package br.com.energySaving.repository;

import br.com.energySaving.model.Dispositivo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DispositivoRepository extends JpaRepository<Dispositivo, Long> {
    // Métodos personalizados podem ser definidos aqui
}
