package com.tictactoe;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "LogicServlet", value = "/logic")
public class LogicServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession currentSession = req.getSession();
        Field field = extractField(currentSession);
        int index = getSelectedIndex(req);
        Sign currentSign = field.getField().get(index);

        if (Sign.EMPTY != currentSign) {
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/index.jsp");
            dispatcher.forward(req, resp);
            return;
        }

        // Крестик
        field.getField().put(index, Sign.CROSS);
        if (checkWin(resp, currentSession, field)) {
            return;
        }

        // Нолик
        int emptyFieldIndex = field.getEmptyFieldIndex();
        if (emptyFieldIndex >= 0) {
            field.getField().put(emptyFieldIndex, Sign.NOUGHT);
            if (checkWin(resp, currentSession, field)) {
                return;
            }
        } else {
            // Ничья
            currentSession.setAttribute("draw", true);
            List<Sign> data = field.getFieldData();
            currentSession.setAttribute("data", data);
            resp.sendRedirect("/index.jsp");
            return;
        }

        // Если никто не выиграл и поле не пустое
        List<Sign> data = field.getFieldData();
        currentSession.setAttribute("data", data);
        currentSession.setAttribute("field", field);

        resp.sendRedirect("/index.jsp");
    }

    private boolean checkWin(HttpServletResponse response, HttpSession currentSession, Field field) throws IOException {
        Sign winner = field.checkWin();
        if (Sign.CROSS == winner || Sign.NOUGHT == winner) {
            currentSession.setAttribute("winner", winner);
            List<Sign> data = field.getFieldData();
            currentSession.setAttribute("data", data);
            response.sendRedirect("/index.jsp");
            return true;
        }
        return false;
    }

    private int getSelectedIndex(HttpServletRequest request) {
        String click = request.getParameter("click");
        if (click == null || !click.chars().allMatch(Character::isDigit)) {
            return 0;  // или выбросить ошибку
        }
        return Integer.parseInt(click);
    }

    private Field extractField(HttpSession currentSession) {
        Object fieldAttribute = currentSession.getAttribute("field");
        if (!(fieldAttribute instanceof Field)) {
            currentSession.invalidate();
            throw new RuntimeException("Session is broken, try one more time");
        }
        return (Field) fieldAttribute;
    }
}

