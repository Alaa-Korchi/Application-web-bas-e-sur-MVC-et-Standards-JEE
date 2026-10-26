package ma.fstt.controller;

import java.io.IOException;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;

/** Force l'UTF-8 pour toutes les requetes (accents dans les formulaires). */
@WebFilter("/*")
public class CharsetFilter implements Filter {
    @Override
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain)
            throws IOException, ServletException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        chain.doFilter(req, resp);
    }
}
