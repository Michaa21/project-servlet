<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Tic-Tac-Toe</title>
    <link href="static/main.css" rel="stylesheet">
    <script src="<c:url value='/static/jquery-3.6.0.min.js'/>"></script>
</head>
<body>
<h1>Tic-Tac-Toe</h1>

<c:set var="winner" value="${sessionScope.winner}" />
<c:set var="draw" value="${sessionScope.draw}" />

<!-- Показываем победителя -->
<c:if test="${not empty winner}">
    <c:choose>
        <c:when test="${winner == 'CROSS'}">
            <h1>CROSSES WIN!</h1>
        </c:when>
        <c:when test="${winner == 'NOUGHT'}">
            <h1>NOUGHTS WIN!</h1>
        </c:when>
    </c:choose>
    <button onclick="restart()">Start again</button>
</c:if>

<!-- Показываем ничью -->
<c:if test="${draw == true}">
    <h1>IT'S A DRAW</h1>
    <button onclick="restart()">Start again</button>
</c:if>

<!-- Игровое поле -->
<c:if test="${not empty sessionScope.data}">
    <table>
        <tr>
            <td onclick="makeMove(0)" class="${sessionScope.data[0].name() == 'CROSS' ? 'cross' : (sessionScope.data[0].name() == 'NOUGHT' ? 'nought' : '')}">
                    ${sessionScope.data[0].sign}
            </td>
            <td onclick="makeMove(1)" class="${sessionScope.data[1].name() == 'CROSS' ? 'cross' : (sessionScope.data[1].name() == 'NOUGHT' ? 'nought' : '')}">
                    ${sessionScope.data[1].sign}
            </td>
            <td onclick="makeMove(2)" class="${sessionScope.data[2].name() == 'CROSS' ? 'cross' : (sessionScope.data[2].name() == 'NOUGHT' ? 'nought' : '')}">
                    ${sessionScope.data[2].sign}
            </td>
        </tr>
        <tr>
            <td onclick="makeMove(3)" class="${sessionScope.data[3].name() == 'CROSS' ? 'cross' : (sessionScope.data[3].name() == 'NOUGHT' ? 'nought' : '')}">
                    ${sessionScope.data[3].sign}
            </td>
            <td onclick="makeMove(4)" class="${sessionScope.data[4].name() == 'CROSS' ? 'cross' : (sessionScope.data[4].name() == 'NOUGHT' ? 'nought' : '')}">
                    ${sessionScope.data[4].sign}
            </td>
            <td onclick="makeMove(5)" class="${sessionScope.data[5].name() == 'CROSS' ? 'cross' : (sessionScope.data[5].name() == 'NOUGHT' ? 'nought' : '')}">
                    ${sessionScope.data[5].sign}
            </td>
        </tr>
        <tr>
            <td onclick="makeMove(6)" class="${sessionScope.data[6].name() == 'CROSS' ? 'cross' : (sessionScope.data[6].name() == 'NOUGHT' ? 'nought' : '')}">
                    ${sessionScope.data[6].sign}
            </td>
            <td onclick="makeMove(7)" class="${sessionScope.data[7].name() == 'CROSS' ? 'cross' : (sessionScope.data[7].name() == 'NOUGHT' ? 'nought' : '')}">
                    ${sessionScope.data[7].sign}
            </td>
            <td onclick="makeMove(8)" class="${sessionScope.data[8].name() == 'CROSS' ? 'cross' : (sessionScope.data[8].name() == 'NOUGHT' ? 'nought' : '')}">
                    ${sessionScope.data[8].sign}
            </td>
        </tr>
    </table>
</c:if>

<script>
    function makeMove(index) {
        var winner = '${winner != null ? winner : ""}';
        var draw = '${draw == true}';
        if (!winner && draw !== 'true') {
            window.location = '/logic?click=' + index;
        }
    }

    function restart() {
        $.ajax({
            url: '/restart',
            type: 'POST',
            contentType: 'application/json;charset=UTF-8',
            async: false,
            success: function () {
                location.reload();
            }
        });
    }
</script>

</body>
</html>

