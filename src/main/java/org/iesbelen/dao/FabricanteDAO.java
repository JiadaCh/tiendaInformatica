package org.iesbelen.dao;

import java.util.List;
import java.util.Optional;

import org.iesbelen.model.Fabricante;

public interface FabricanteDAO {
		
	void create(Fabricante fabricante);
	List<Fabricante> getAll();
	 Optional<Fabricante>  find(int id);
	 void update(Fabricante fabricante);
	 void delete(int id);

	 Optional<Integer> getCountProductos (int id);
}
