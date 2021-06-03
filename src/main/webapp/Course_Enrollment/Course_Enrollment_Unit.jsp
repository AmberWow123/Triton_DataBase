<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: AmberWang
  Date: 2021/5/2
  Time: 下午 11:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <%!
        String Student_ID = "";
        String Course_ID = "";
        String Section_ID = "";
        String Units = "";
        String Grade_Option = "";
        boolean is_correct = true;
        String wrong = "";
    %>
    <%
        String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
        try {
            is_correct = true;
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(url);
            conn.setAutoCommit(false);
            Student_ID = request.getParameter("StudentID");
            Course_ID = request.getParameter("CourseID");
            Section_ID = request.getParameter("SectionID");
            Units = request.getParameter("Units");
            Grade_Option = request.getParameter("GradeOption");
            String sql_insert = "INSERT INTO Enrollment VALUES (?,?,?,?,?)";
            PreparedStatement st = conn.prepareStatement(sql_insert);
            st.setString(1, Student_ID);
            st.setString(2, Course_ID);
            st.setString(3, Section_ID);
            st.setString(4, Units);
            st.setString(5, Grade_Option);
            st.executeUpdate();
            st.close();
            conn.commit();
            conn.setAutoCommit(true);
            conn.close();
        } catch (Exception e) {
            is_correct = false;
            wrong = e.toString();
            System.out.println(e);
        }
    %>
    <%
        if (is_correct) {
            out.println("<H3><u>Successful Insert new Enrollment into the dataBase</u></b>");
        } else {
//            if (wrong.contains("Exceed the enrollment limit")) {
//                out.print("<h3>Exceed the enrollment limit of selected section.</h3>");
//            } else {
//                out.print("<h3>" + wrong + "</h3>");
//            }
            out.print("<h3>" + wrong + "</h3>");
        }
    %>
    <br/><br>
    Student ID: <%= Student_ID%>
    <br/><br>
    Course ID: <%=Course_ID%>
    <br/><br>
    Section ID: <%=Section_ID%>
    <br/><br>
    Units: <%=Units%>
    <br/><br>
    Grade Option: <%=Grade_Option%>
    <br/><br>
    <a href="Course_Enrollment_Submission.jsp"><button> Submit again </button></a>
    <a href="../Course_Enrollment/Course_Enrollment_Database.jsp"><button> Check Database </button></a>
    <a href="./../index.jsp"><button> Homepage </button></a>
    <jsp:include page="../footer.jsp"/>
</body>
</html>
