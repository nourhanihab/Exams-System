<%-- 
    Document   : Exam
    Created on : Nov 9, 2019, 5:36:39 PM
    Author     : Nura
--%>


<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>** EXAM PAGE **</title>
        <script>
            function checkAnswers(){
                alert("Your answer is submitted THANK YOU!");
              
            }
        </script>
    </head>
    <body>
        <%
            String id = (String) session.getAttribute("session_sID");

        %>
        <h1 style="color:lightblue;"> Solve as much as you can for good grades student <%=id%> </h1>


        <%

            String arr[] = new String[3];
            String answers[] = new String[3];
            int count = 0;
            String url = "jdbc:mysql://localhost:3306/system";
            String user = "root";
            String password = "1234";
            Connection Con = null;
            Statement Stmt = null;
            ResultSet RS = null;

            try {
                Class.forName("com.mysql.jdbc.Driver");
                Con = DriverManager.getConnection(url, user, password);
                Stmt = Con.createStatement();
                String query = "SELECT * FROM questions ORDER BY RAND() LIMIT 1;";
                RS = Stmt.executeQuery(query);
                String QID = null;
                String A1=null,A2=null,A3 =null;
                while (RS.next()) {
                    out.println(RS.getString("questiontext"));
                    QID = RS.getString("QID");
                    String query2 = "SELECT * FROM answer WHERE correct=0 ORDER BY RAND() LIMIT 2;";
                    RS = Stmt.executeQuery(query2);
                    while (RS.next()) {
                        arr[count] = RS.getString("answertext");
                        answers[count]=RS.getString("AID");
                        count++;
                        //out.println(RS.getString("answertext"));
                    }
                    String query3 = "SELECT * FROM answer WHERE correct=1 and QID=" + QID + ";";
                    RS = Stmt.executeQuery(query3);
                    if (RS.next()) {
                        
                        arr[2] = RS.getString("answertext");
                        answers[2]=RS.getString("AID");
                        //out.println(RS.getString("answertext"));
                    }
                }
                String finalQuery1 = "INSERT INTO students_answers VALUES ('"+answers[0]+"','"+id+"','"+QID+"')";
                String finalQuery2 = "INSERT INTO students_answers VALUES ('"+answers[1]+"','"+id+"','"+QID+"')";
                String finalQuery3 = "INSERT INTO students_answers VALUES ('"+answers[2]+"','"+id+"','"+QID+"')";
                Stmt.executeUpdate(finalQuery1);
                Stmt.executeUpdate(finalQuery2);
                Stmt.executeUpdate(finalQuery3);
                
                
                
            } catch (Exception cnfe) {
                System.err.println("Exception: " + cnfe);
            }

        %>

            <form onsubmit = "checkAnswers()">
                <input type="checkbox" name="answer" id="ch1"> <%=arr[0]%> <br>
                <input type="checkbox" name="answer" id="ch2"> <%=arr[1]%> <br>
                <input type="checkbox" name="answer" id="ch3"> <%=arr[2]%> <br>
                <input type="submit" value="Submit">

            </form>
                
        <% 
            RS.close();
            Stmt.close();
            Con.close();%>
    </body>
</html>
