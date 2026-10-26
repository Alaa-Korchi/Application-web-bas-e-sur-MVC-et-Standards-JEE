package ma.fstt.entities;

import java.io.Serializable;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

public class Commande implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private Date dateCommande;
    private String statut = "EN_ATTENTE";
    private Client client;
    private List<LigneCommande> lignes = new ArrayList<>();
    private double total; // utilise quand les lignes ne sont pas chargees (liste)

    public Commande() { }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public Date getDateCommande() { return dateCommande; }
    public void setDateCommande(Date dateCommande) { this.dateCommande = dateCommande; }
    public String getStatut() { return statut; }
    public void setStatut(String statut) { this.statut = statut; }
    public Client getClient() { return client; }
    public void setClient(Client client) { this.client = client; }
    public List<LigneCommande> getLignes() { return lignes; }
    public void setLignes(List<LigneCommande> lignes) { this.lignes = lignes; }
    public void setTotal(double total) { this.total = total; }

    public double getTotal() {
        if (lignes == null || lignes.isEmpty()) return total;
        double t = 0;
        for (LigneCommande l : lignes) t += l.getSousTotal();
        return t;
    }
}
