package ma.fstt.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ma.fstt.entities.Produit;
import ma.fstt.service.ProduitService;

/** Controleur de l'espace produit. */
@WebServlet("/produits")
public class ProduitServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String LIST = "/WEB-INF/views/produit/list.jsp";
    private static final String FORM = "/WEB-INF/views/produit/form.jsp";

    @Inject
    private ProduitService produitService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        try {
            if ("new".equals(action)) {
                req.setAttribute("produit", new Produit());
                req.getRequestDispatcher(FORM).forward(req, resp);
            } else if ("edit".equals(action)) {
                Produit p = produitService.findById(Integer.parseInt(req.getParameter("id")));
                if (p == null) { resp.sendRedirect(req.getContextPath() + "/produits"); return; }
                req.setAttribute("produit", p);
                req.getRequestDispatcher(FORM).forward(req, resp);
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
                try {
                    produitService.delete(Integer.parseInt(req.getParameter("id")));
                } catch (SQLException e) {
                    req.setAttribute("error", "Suppression impossible : ce produit figure dans des commandes.");
                    showList(req, resp);
                    return;
                }
            } else {
                Produit p = new Produit();
                String id = req.getParameter("id");
                if (id != null && !id.isEmpty()) p.setId(Integer.parseInt(id));
                p.setDesignation(req.getParameter("designation"));
                try {
                    p.setPrix(Double.parseDouble(req.getParameter("prix").replace(',', '.')));
                    p.setStock(Integer.parseInt(req.getParameter("stock")));
                    if (p.getId() == 0) produitService.create(p); else produitService.update(p);
                } catch (SQLException | NumberFormatException e) {
                    req.setAttribute("error", "Enregistrement impossible : vérifiez les valeurs saisies.");
                    req.setAttribute("produit", p);
                    req.getRequestDispatcher(FORM).forward(req, resp);
                    return;
                }
            }
            resp.sendRedirect(req.getContextPath() + "/produits");
        } catch (SQLException | NumberFormatException e) {
            throw new ServletException(e);
        }
    }

    private void showList(HttpServletRequest req, HttpServletResponse resp)
            throws SQLException, ServletException, IOException {
        req.setAttribute("produits", produitService.findAll());
        req.getRequestDispatcher(LIST).forward(req, resp);
    }
}
