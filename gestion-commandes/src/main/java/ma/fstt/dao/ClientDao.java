package ma.fstt.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;

import ma.fstt.entities.Client;
import ma.fstt.service.ClientService;

@ApplicationScoped
public class ClientDao implements ClientService {

    @Inject
    private DBConnection db;

    @Override
    public void create(Client c) throws SQLException {
        String sql = "INSERT INTO client(nom, prenom, email, telephone, adresse) VALUES (?,?,?,?,?)";
        try (Connection cn = db.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            fill(ps, c);
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) c.setId(rs.getInt(1));
            }
        }
    }

    @Override
    public void update(Client c) throws SQLException {
        String sql = "UPDATE client SET nom=?, prenom=?, email=?, telephone=?, adresse=? WHERE id=?";
        try (Connection cn = db.getConnection(); PreparedStatement ps = cn.prepareStatement(sql)) {
            fill(ps, c);
            ps.setInt(6, c.getId());
            ps.executeUpdate();
        }
    }

    @Override
    public void delete(int id) throws SQLException {
        try (Connection cn = db.getConnection();
             PreparedStatement ps = cn.prepareStatement("DELETE FROM client WHERE id=?")) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    @Override
    public Client findById(int id) throws SQLException {
        try (Connection cn = db.getConnection();
             PreparedStatement ps = cn.prepareStatement("SELECT * FROM client WHERE id=?")) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? map(rs) : null;
            }
        }
    }

    @Override
    public List<Client> findAll() throws SQLException {
        List<Client> list = new ArrayList<>();
        try (Connection cn = db.getConnection();
             Statement st = cn.createStatement();
             ResultSet rs = st.executeQuery("SELECT * FROM client ORDER BY nom, prenom")) {
            while (rs.next()) list.add(map(rs));
        }
        return list;
    }

    private void fill(PreparedStatement ps, Client c) throws SQLException {
        ps.setString(1, c.getNom());
        ps.setString(2, c.getPrenom());
        ps.setString(3, c.getEmail());
        ps.setString(4, c.getTelephone());
        ps.setString(5, c.getAdresse());
    }

    private Client map(ResultSet rs) throws SQLException {
        return new Client(rs.getInt("id"), rs.getString("nom"), rs.getString("prenom"),
                rs.getString("email"), rs.getString("telephone"), rs.getString("adresse"));
    }
}
