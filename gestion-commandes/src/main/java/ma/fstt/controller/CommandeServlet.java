package ma.fstt.controller;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ma.fstt.entities.Client;
import ma.fstt.entities.Commande;
import ma.fstt.entities.LigneCommande;
import ma.fstt.entities.Produit;
import ma.fstt.service.ClientService;
import ma.fstt.service.CommandeService;
import ma.fstt.service.ProduitService;

/** Controleur de l'espace commande (commande + lignes de commande). */
@WebServlet("/commandes")
public class CommandeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String LIST = "/WEB-INF/views/commande/list.jsp";
    private static final String FORM = "/WEB-INF/views/commande/form.jsp";
    private static final String DETAIL = "/WEB-INF/views/commande/detail.jsp";

    @Inject
    private CommandeService commandeService;
    @Inject
    private ClientService clientService;
    @Inject
    private ProduitService produitService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        try {
            if ("new".equals(action)) {
                Commande c = new Commande();
                c.setDateCommande(new Date(System.currentTimeMillis()));
                showForm(req, resp, c);
            } else if ("edit".equals(action) || "view".equals(action)) {
                Commande c = commandeService.findById(Integer.parseInt(req.getParameter("id")));
                if (c == null) { resp.sendRedirect(req.getContextPath() + "/commandes"); return; }
                if ("edit".equals(action)) {
                    showForm(req, resp, c);
                } else {
                    req.setAttribute("commande", c);
                    req.getRequestDispatcher(DETAIL).forward(req, resp);
                }
            } else {
                showList(req, resp);
            }
        } catch (SQLException | NumberFormatException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        try {
            if ("delete".equals(action)) {
                commandeService.delete(Integer.parseInt(req.getParameter("id")));
                resp.sendRedirect(req.getContextPath() + "/commandes");
                return;
            }

            // ---- save (create / update) : on construit le JavaBean a partir du formulaire
            Commande c = new Commande();
            String id = req.getParameter("id");
            if (id != null && !id.isEmpty()) c.setId(Integer.parseInt(id));
            try {
                c.setDateCommande(Date.valueOf(req.getParameter("dateCommande")));
                c.setStatut(req.getParameter("statut"));
                Client cl = new Client();
                cl.setId(Integer.parseInt(req.getParameter("clientId")));
                c.setClient(cl);

                String[] pids = req.getParameterValues("produitId");
                String[] qtes = req.getParameterValues("quantite");
                List<LigneCommande> lignes = new ArrayList<>();
                if (pids != null && qtes != null) {
                    for (int i = 0; i < pids.length && i < qtes.length; i++) {
                        if (pids[i].isEmpty() || qtes[i].isEmpty()) continue;
                        int q = Integer.parseInt(qtes[i]);
                        Produit p = produitService.findById(Integer.parseInt(pids[i]));
                        if (p == null || q <= 0) continue;
                        lignes.add(new LigneCommande(p, q, p.getPrix())); // prix fige a la commande
                    }
                }
                if (lignes.isEmpty()) throw new IllegalArgumentException("Au moins une ligne est requise.");
                c.setLignes(lignes);

                if (c.getId() == 0) commandeService.create(c); else commandeService.update(c);
                resp.sendRedirect(req.getContextPath() + "/commandes");
            } catch (IllegalArgumentException e) { // inclut NumberFormatException
                req.setAttribute("error", "Formulaire invalide : date, client et au moins une ligne (produit + quantité) sont requis.");
                showForm(req, resp, c);
            }
        } catch (SQLException | NumberFormatException e) {
            throw new ServletException(e);
        }
    }

    private void showList(HttpServletRequest req, HttpServletResponse resp)
            throws SQLException, ServletException, IOException {
        req.setAttribute("commandes", commandeService.findAll());
        req.getRequestDispatcher(LIST).forward(req, resp);
    }

    private void showForm(HttpServletRequest req, HttpServletResponse resp, Commande c)
            throws SQLException, ServletException, IOException {
        req.setAttribute("commande", c);
        req.setAttribute("clients", clientService.findAll());
        req.setAttribute("produits", produitService.findAll());
        req.getRequestDispatcher(FORM).forward(req, resp);
    }
}
