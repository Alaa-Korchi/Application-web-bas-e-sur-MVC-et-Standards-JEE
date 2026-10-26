package ma.fstt.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ma.fstt.entities.Client;
import ma.fstt.service.ClientService;

/** Controleur de l'espace client. */
@WebServlet("/clients")
public class ClientServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String LIST = "/WEB-INF/views/client/list.jsp";
    private static final String FORM = "/WEB-INF/views/client/form.jsp";

    @Inject
    private ClientService clientService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        try {
            if ("new".equals(action)) {
                req.setAttribute("client", new Client());
                req.getRequestDispatcher(FORM).forward(req, resp);
            } else if ("edit".equals(action)) {
                Client c = clientService.findById(Integer.parseInt(req.getParameter("id")));
                if (c == null) { resp.sendRedirect(req.getContextPath() + "/clients"); return; }
                req.setAttribute("client", c);
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
                    clientService.delete(Integer.parseInt(req.getParameter("id")));
                } catch (SQLException e) {
                    req.setAttribute("error", "Suppression impossible : ce client possède des commandes.");
                    showList(req, resp);
                    return;
                }
            } else { // save
                Client c = new Client();
                String id = req.getParameter("id");
                if (id != null && !id.isEmpty()) c.setId(Integer.parseInt(id));
                c.setNom(req.getParameter("nom"));
                c.setPrenom(req.getParameter("prenom"));
                c.setEmail(req.getParameter("email"));
                c.setTelephone(req.getParameter("telephone"));
                c.setAdresse(req.getParameter("adresse"));
                try {
                    if (c.getId() == 0) clientService.create(c); else clientService.update(c);
                } catch (SQLException e) {
                    req.setAttribute("error", "Enregistrement impossible (e-mail déjà utilisé ?) : " + e.getMessage());
                    req.setAttribute("client", c);
                    req.getRequestDispatcher(FORM).forward(req, resp);
                    return;
                }
            }
            resp.sendRedirect(req.getContextPath() + "/clients");
        } catch (SQLException | NumberFormatException e) {
            throw new ServletException(e);
        }
    }

    private void showList(HttpServletRequest req, HttpServletResponse resp)
            throws SQLException, ServletException, IOException {
        req.setAttribute("clients", clientService.findAll());
        req.getRequestDispatcher(LIST).forward(req, resp);
    }
}
