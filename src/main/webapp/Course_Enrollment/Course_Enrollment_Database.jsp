<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: AmberWang
  Date: 2021/5/2
  Time: 下午 01:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Course Enrollment Database</title>
</head>
<style>
    table {
        font-family: sans-serif;
        border-collapse: collapse;
        width: 100%;
    }
    td, th {
        border: 1px solid black;
        text-align: left;
    }
</style>
<body>
<h1 align="center"> Course Enrollment Database </h1>
<table>
    <%
        String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
        try {
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(url);
            Statement sm = conn.createStatement();
            ResultSet st = sm.executeQuery("SELECT * FROM Enrollment");
            out.println("<tr><th>Student ID</th>"
                        + "<th>Course ID</th>"
                        + "<th>Section ID</th>"
                        + "<th>Units</th>"
                        + "<th>Grade Option</th>"
                        + "</tr>");
            while(st.next()) {
                out.print("<tr><th>" + st.getString(1) + "</th>"
                        + "<th>" + st.getString(2) + "</th>"
                        + "<th>" + st.getString(3) + "</th>"
                        + "<th>" + st.getString(4) + "</th>"
                        + "<th>" + st.getString(5) + "</th>"
                        + "</tr>");
            }
            sm.close();
            st.close();
            conn.close();

        } catch (Exception e) {
            System.out.println(e);
        }
    %>
</table>
<a href="../index.jsp"><button>Back to HomePage</button></a>
<jsp:include page="./../footer.jsp"/>
</body>
</html>
