<%-- 
    Document   : Student
    Created on : Nov 9, 2019, 4:24:16 PM
    Author     : Nura
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>** Student Page **</title>
    </head>
    <body>
        <h1 style="color:lightblue;" >             Welcome to your page! </h1>
        <%  String stID = request.getSession().getAttribute("session_sID").toString();
            String stPass = session.getAttribute("session_sPass").toString();
        %>

        <br></br>Hello Student: <%= stID%><br</br>

        <%

            String url = "jdbc:mysql://localhost:3306/system";
            String user = "root";
            String password = "1234";
            String id = (String) session.getAttribute("session_sID");
            Connection Con = null;
            Statement Stmt = null;
            ResultSet RS = null;

            try {
                Class.forName("com.mysql.jdbc.Driver");
                Con = DriverManager.getConnection(url, user, password);
                Stmt = Con.createStatement();
                String query = "SELECT * FROM students_answers WHERE SID = " + id;
                RS = Stmt.executeQuery(query);

                if (RS.next()) {%>
        <button disabled>Take Exam</button>

        <% } else {%>
        <form method ="post" action="Exam.jsp">
            <input type="submit" value="Take Exam"></button>
        </form>
        <% }
            } catch (Exception cnfe) {
                System.err.println("Exception: " + cnfe);
            }


        %>
        <%  RS.close();
            Stmt.close();
            Con.close();%>
    </body>
</html>
