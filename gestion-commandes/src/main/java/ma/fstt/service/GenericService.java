package ma.fstt.service;

import java.sql.SQLException;
import java.util.List;

/** Contrat CRUD commun a toutes les classes DAO. */
public interface GenericService<T> {
    void create(T t) throws SQLException;
    void update(T t) throws SQLException;
    void delete(int id) throws SQLException;
    T findById(int id) throws SQLException;
    List<T> findAll() throws SQLException;
}
