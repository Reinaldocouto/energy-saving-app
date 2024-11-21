package br.com.energySaving.service;

import br.com.energySaving.model.Dispositivo;
import br.com.energySaving.repository.DispositivoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DispositivoService {

    @Autowired
    private DispositivoRepository dispositivoRepository;

    public List<Dispositivo> listarTodos() {
        return dispositivoRepository.findAll();
    }

    public Dispositivo buscarPorId(Long id) {
        return dispositivoRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Dispositivo não encontrado com ID: " + id));
    }

    public Dispositivo adicionar(Dispositivo dispositivo) {
        return dispositivoRepository.save(dispositivo);
    }

    public Dispositivo atualizar(Long id, Dispositivo dispositivoAtualizado) {
        Dispositivo dispositivo = buscarPorId(id);
        dispositivo.setNome(dispositivoAtualizado.getNome());
        dispositivo.setTipo(dispositivoAtualizado.getTipo());
        dispositivo.setConsumoPorHora(dispositivoAtualizado.getConsumoPorHora());
        dispositivo.setStatus(dispositivoAtualizado.getStatus());
        return dispositivoRepository.save(dispositivo);
    }

    public void remover(Long id) {
        dispositivoRepository.deleteById(id);
    }
}
