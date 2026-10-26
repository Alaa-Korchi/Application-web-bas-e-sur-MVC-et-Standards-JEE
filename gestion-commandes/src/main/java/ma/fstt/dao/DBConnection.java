package ma.fstt.dao;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

import javax.annotation.PostConstruct;
import javax.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class DBConnection {

    private String url;
    private String user;
    private String password;

    @PostConstruct
    void init() {
        Properties p = new Properties();
        try (InputStream in = Thread.currentThread().getContextClassLoader()
                .getResourceAsStream("db.properties")) {
            p.load(in);
            Class.forName(p.getProperty("db.driver"));
        } catch (IOException | ClassNotFoundException | NullPointerException e) {
            throw new IllegalStateException("Impossible de charger db.properties / le driver JDBC", e);
        }
        url = p.getProperty("db.url");
        user = p.getProperty("db.user");
        password = p.getProperty("db.password", "");
    }

    public Connection getConnection() throws SQLException {
        return DriverManager.getConnection(url, user, password);
    }
}
