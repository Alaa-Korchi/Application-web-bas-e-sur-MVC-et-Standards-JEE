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
import ma.fstt.entities.Commande;
import ma.fstt.entities.LigneCommande;
import ma.fstt.entities.Produit;
import ma.fstt.service.CommandeService;

/** DAO de Commande : gere aussi ses lignes (composition) dans une transaction. */
@ApplicationScoped
public class CommandeDao implements CommandeService {

    @Inject
    private DBConnection db;

    @Override
    public void create(Commande c) throws SQLException {
        try (Connection cn = db.getConnection()) {
            cn.setAutoCommit(false);
            try {
                String sql = "INSERT INTO commande(date_commande, statut, client_id) VALUES (?,?,?)";
                try (PreparedStatement ps = cn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                    ps.setDate(1, c.getDateCommande());
                    ps.setString(2, c.getStatut());
                    ps.setInt(3, c.getClient().getId());
                    ps.executeUpdate();
                    try (ResultSet rs = ps.getGeneratedKeys()) {
                        if (rs.next()) c.setId(rs.getInt(1));
                    }
                }
                insertLignes(cn, c);
                cn.commit();
            } catch (SQLException e) {
                cn.rollback();
                throw e;
            }
        }
    }

    @Override
    public void update(Commande c) throws SQLException {
        try (Connection cn = db.getConnection()) {
            cn.setAutoCommit(false);
            try {
                String sql = "UPDATE commande SET date_commande=?, statut=?, client_id=? WHERE id=?";
                try (PreparedStatement ps = cn.prepareStatement(sql)) {
                    ps.setDate(1, c.getDateCommande());
                    ps.setString(2, c.getStatut());
                    ps.setInt(3, c.getClient().getId());
                    ps.setInt(4, c.getId());
                    ps.executeUpdate();
                }
                try (PreparedStatement ps = cn.prepareStatement("DELETE FROM ligne_commande WHERE commande_id=?")) {
                    ps.setInt(1, c.getId());
                    ps.executeUpdate();
                }
                insertLignes(cn, c);
                cn.commit();
            } catch (SQLException e) {
                cn.rollback();
                throw e;
            }
        }
    }

    @Override
    public void delete(int id) throws SQLException {
        // les lignes sont supprimees par ON DELETE CASCADE
        try (Connection cn = db.getConnection();
             PreparedStatement ps = cn.prepareStatement("DELETE FROM commande WHERE id=?")) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    @Override
    public Commande findById(int id) throws SQLException {
        String sql = "SELECT c.id, c.date_commande, c.statut, cl.id AS cid, cl.nom, cl.prenom "
                + "FROM commande c JOIN client cl ON cl.id = c.client_id WHERE c.id=?";
        try (Connection cn = db.getConnection(); PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, id);
            Commande c;
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return null;
                c = mapHeader(rs);
            }
            String sqlL = "SELECT l.id, l.quantite, l.prix_unitaire, p.id AS pid, p.designation, p.prix, p.stock "
                    + "FROM ligne_commande l JOIN produit p ON p.id = l.produit_id "
                    + "WHERE l.commande_id=? ORDER BY l.id";
            try (PreparedStatement psl = cn.prepareStatement(sqlL)) {
                psl.setInt(1, id);
                try (ResultSet rs = psl.executeQuery()) {
                    while (rs.next()) {
                        LigneCommande l = new LigneCommande();
                        l.setId(rs.getInt("id"));
                        l.setQuantite(rs.getInt("quantite"));
                        l.setPrixUnitaire(rs.getDouble("prix_unitaire"));
                        l.setProduit(new Produit(rs.getInt("pid"), rs.getString("designation"),
                                rs.getDouble("prix"), rs.getInt("stock")));
                        c.getLignes().add(l);
                    }
                }
            }
            return c;
        }
    }

    @Override
    public List<Commande> findAll() throws SQLException {
        String sql = "SELECT c.id, c.date_commande, c.statut, cl.id AS cid, cl.nom, cl.prenom, "
                + "(SELECT COALESCE(SUM(l.quantite * l.prix_unitaire), 0) FROM ligne_commande l "
                + " WHERE l.commande_id = c.id) AS total "
                + "FROM commande c JOIN client cl ON cl.id = c.client_id ORDER BY c.id DESC";
        List<Commande> list = new ArrayList<>();
        try (Connection cn = db.getConnection();
             Statement st = cn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Commande c = mapHeader(rs);
                c.setTotal(rs.getDouble("total"));
                list.add(c);
            }
        }
        return list;
    }

    private void insertLignes(Connection cn, Commande c) throws SQLException {
        String sql = "INSERT INTO ligne_commande(commande_id, produit_id, quantite, prix_unitaire) VALUES (?,?,?,?)";
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            for (LigneCommande l : c.getLignes()) {
                ps.setInt(1, c.getId());
                ps.setInt(2, l.getProduit().getId());
                ps.setInt(3, l.getQuantite());
                ps.setDouble(4, l.getPrixUnitaire());
                ps.addBatch();
            }
            ps.executeBatch();
        }
    }

    private Commande mapHeader(ResultSet rs) throws SQLException {
        Commande c = new Commande();
        c.setId(rs.getInt("id"));
        c.setDateCommande(rs.getDate("date_commande"));
        c.setStatut(rs.getString("statut"));
        Client cl = new Client();
        cl.setId(rs.getInt("cid"));
        cl.setNom(rs.getString("nom"));
        cl.setPrenom(rs.getString("prenom"));
        c.setClient(cl);
        return c;
    }
}
