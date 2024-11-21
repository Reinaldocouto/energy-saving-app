package br.com.energySaving.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import java.util.List;


@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(of = {"id"})
@Entity
@Table(name = "tbl_dispositivo")
public class Dispositivo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String nome;
    private String tipo;
    private Double consumoPorHora;
    private Boolean status;

    // Relacionamento com a entidade Consumo
    @OneToMany(mappedBy = "dispositivo", fetch = FetchType.LAZY)
    @JsonIgnore
    private List<Consumo> consumos;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public Double getConsumoPorHora() {
        return consumoPorHora;
    }

    public void setConsumoPorHora(Double consumoPorHora) {
        this.consumoPorHora = consumoPorHora;
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }

    public List<Consumo> getConsumos() {
        return consumos;
    }

    public void setConsumos(List<Consumo> consumos) {
        this.consumos = consumos;
    }

    // Getters and Setters
}

