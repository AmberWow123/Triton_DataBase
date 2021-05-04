<%--
  Created by IntelliJ IDEA.
  User: guoyili
  Date: 5/1/21
  Time: 12:21 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*"   contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%!
    String student_id = "";
    String Course_Id = "";
    String Section_ID = "";
    String quarter  = "";
    String year = "";
    String grade = "";
    boolean is_correct = false;
    String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
%>
<%
    student_id = request.getParameter("Student_Id");
    System.out.println(student_id);
    Course_Id = request.getParameter("Course_Id");
    Section_ID = request.getParameter("Section_ID");
    quarter = request.getParameter("quarter");
    year = request.getParameter("year");
    grade = request.getParameter("grade");
    String time = quarter + " " + year;
    try {
        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection(url);
        /*
         *  Check if the Student id whether if valid or not
         * */
        String sql_id = "select * from student where student_id = ?";
        PreparedStatement ID_Check = conn.prepareStatement(sql_id);
        ID_Check.setString(1,student_id);
        ResultSet ID_St = ID_Check.executeQuery();

        /*
         *  Check if the Course ID name whether if valid or not
         * */
//        String sql_Name = "select * from faculty where faculty_name = ?";
//        PreparedStatement Name_Check = conn.prepareStatement(sql_Name);
//        Name_Check.setString(1,name);
//        ResultSet Name_St = Name_Check.executeQuery();

        /*
         *  check if the Section ID existed in database
         * */
//        String sql_thesis = "select * from Thesis_committee where Student_id = ? and faculty_name = ?";
//        PreparedStatement Thesis_Check = conn.prepareStatement(sql_thesis);
//        Thesis_Check.setString(1,student_id);
//        Thesis_Check.setString(2,name);
//        ResultSet Thesis_St = Thesis_Check.executeQuery();

        if (!ID_St.next()) {
            System.out.println("ID/Faculty does not exist");
        } else {
            /*
             *  create a new Thesis committee
             * */
            is_correct = true;
            String sql = "Insert into past_course values (?,?,?,?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1,student_id);
            ps.setString(2,Course_Id);
            ps.setString(3,Section_ID);
            ps.setString(4,time);
            ps.setString(5,grade);
            ps.executeQuery();
            ps.close();
        }
        ID_Check.close();
        ID_St.close();
//        Name_Check.close();
//        Name_St.close();
//        Thesis_Check.close();
//        Thesis_St.close();
    } catch (Exception e) {
        System.out.println(e);
    }
%>
<% if (is_correct) {%>
<h3>Have been add your course info</h3>
<% } else { %>
<h3>Please,check the information.</h3>
<br/>
<h3>Student Id/course/Section name may not correct</h3>
<br/>
<h3> or it may existed in our dataBase</h3>
<% } %>
<a href="./Thesis_Committee_Submission.jsp"><button> Enter More </button></a>
<a href="./Thesis_Committee_DataBase.jsp"><button> Check Database </button></a>
<a href="../index.jsp"><button> Homepage</button></a>
<jsp:include page="../footer.jsp"/>
</body>
</html>