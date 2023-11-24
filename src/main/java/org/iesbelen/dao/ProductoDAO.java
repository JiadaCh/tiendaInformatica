package org.iesbelen.dao;

import org.iesbelen.model.Producto;

import java.util.List;
import java.util.Optional;

public interface ProductoDAO {
		
	 void create(Producto producto);
	 List<Producto> getAll();
	 Optional<Producto>  find(int id);
	 void update(Producto producto);
	 void delete(int id);
	 List<Producto> getByName(String name);
}
