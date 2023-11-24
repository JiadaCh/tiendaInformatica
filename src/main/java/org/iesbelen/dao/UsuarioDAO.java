package org.iesbelen.dao;

import org.iesbelen.model.Fabricante;
import org.iesbelen.model.Usuario;

import java.util.List;
import java.util.Optional;

public interface UsuarioDAO {
		
	 void create(Usuario usuario);
	 List<Usuario> getAll();
	 Optional<Usuario>  find(int id);
	 void update(Usuario usuario);
	 void delete(int id);
	 Optional<Usuario>  findUser(String usuario, String password);
}
