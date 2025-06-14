package com.tictactoe;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "RestartServlet", value = "/restart")
public class RestartServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        // Новый сеанс создастся автоматически на /start
        resp.sendRedirect("/start");
    }
}
