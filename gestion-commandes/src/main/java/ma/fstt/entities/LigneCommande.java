package ma.fstt.entities;

import java.io.Serializable;

public class LigneCommande implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private Produit produit;
    private int quantite;
    private double prixUnitaire;

    public LigneCommande() { }

    public LigneCommande(Produit produit, int quantite, double prixUnitaire) {
        this.produit = produit; this.quantite = quantite; this.prixUnitaire = prixUnitaire;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public Produit getProduit() { return produit; }
    public void setProduit(Produit produit) { this.produit = produit; }
    public int getQuantite() { return quantite; }
    public void setQuantite(int quantite) { this.quantite = quantite; }
    public double getPrixUnitaire() { return prixUnitaire; }
    public void setPrixUnitaire(double prixUnitaire) { this.prixUnitaire = prixUnitaire; }

    public double getSousTotal() { return quantite * prixUnitaire; }
}
