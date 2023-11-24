package org.iesbelen.dto;

import org.iesbelen.model.Fabricante;

import java.util.Optional;

public class FabricanteDTO extends Fabricante {
    private Integer numProductos;
    public FabricanteDTO(){
    }
    public FabricanteDTO(int id, String nombre){
        setIdFabricante(id);
        setNombre(nombre);
    }

    public Integer getNumProductos() {

        return numProductos;
    }

    public void setNumProductos(Integer numProductos) {
        this.numProductos = numProductos;

    }
}
