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

import ma.fstt.entities.Produit;
import ma.fstt.service.ProduitService;

@ApplicationScoped
public class ProduitDao implements ProduitService {

    @Inject
    private DBConnection db;

    @Override
    public void create(Produit p) throws SQLException {
        String sql = "INSERT INTO produit(designation, prix, stock) VALUES (?,?,?)";
        try (Connection cn = db.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, p.getDesignation());
            ps.setDouble(2, p.getPrix());
            ps.setInt(3, p.getStock());
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) p.setId(rs.getInt(1));
            }
        }
    }

    @Override
    public void update(Produit p) throws SQLException {
        String sql = "UPDATE produit SET designation=?, prix=?, stock=? WHERE id=?";
        try (Connection cn = db.getConnection(); PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, p.getDesignation());
            ps.setDouble(2, p.getPrix());
            ps.setInt(3, p.getStock());
            ps.setInt(4, p.getId());
            ps.executeUpdate();
        }
    }

    @Override
    public void delete(int id) throws SQLException {
        try (Connection cn = db.getConnection();
             PreparedStatement ps = cn.prepareStatement("DELETE FROM produit WHERE id=?")) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    @Override
    public Produit findById(int id) throws SQLException {
        try (Connection cn = db.getConnection();
             PreparedStatement ps = cn.prepareStatement("SELECT * FROM produit WHERE id=?")) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? map(rs) : null;
            }
        }
    }

    @Override
    public List<Produit> findAll() throws SQLException {
        List<Produit> list = new ArrayList<>();
        try (Connection cn = db.getConnection();
             Statement st = cn.createStatement();
             ResultSet rs = st.executeQuery("SELECT * FROM produit ORDER BY designation")) {
            while (rs.next()) list.add(map(rs));
        }
        return list;
    }

    private Produit map(ResultSet rs) throws SQLException {
        return new Produit(rs.getInt("id"), rs.getString("designation"),
                rs.getDouble("prix"), rs.getInt("stock"));
    }
}
