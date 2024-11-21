package br.com.energySaving.controller;

import br.com.energySaving.model.Dispositivo;
import br.com.energySaving.service.DispositivoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/dispositivos")
public class DispositivoController {

    @Autowired
    private DispositivoService dispositivoService;

    // Endpoint para buscar todos os dispositivos e seus consumos
    @GetMapping
    public List<Dispositivo> listarTodos() {
        return dispositivoService.listarTodos();
    }

    // Endpoint para buscar um dispositivo específico
    @GetMapping("/{id}")
    public Dispositivo buscarPorId(@PathVariable Long id) {
        return dispositivoService.buscarPorId(id);
    }

    // Endpoint para adicionar um novo dispositivo
    @PostMapping
    public Dispositivo adicionar(@RequestBody Dispositivo dispositivo) {
        return dispositivoService.adicionar(dispositivo);
    }

    // Endpoint para atualizar um dispositivo existente
    @PutMapping("/{id}")
    public Dispositivo atualizar(@PathVariable Long id, @RequestBody Dispositivo dispositivoAtualizado) {
        return dispositivoService.atualizar(id, dispositivoAtualizado);
    }

    // Endpoint para remover um dispositivo
    @DeleteMapping("/{id}")
    public void remover(@PathVariable Long id) {
        dispositivoService.remover(id);
    }
}

