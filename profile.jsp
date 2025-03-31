<%@ page import="java.sql.*, java.util.*" %>
<%@ page session="true" %>
<%
   
    String userId = (String) session.getAttribute("userId");
    if (userId == null) {
        
        response.sendRedirect("user_login.jsp");
        return;
    }

   
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    String dbURL = "jdbc:mysql://localhost:3306/Talkzi";
    String dbUser = "root";
    String dbPass = "";

   
    int postsCount = 0;
    int likesCount = 0;
    int commentsCount = 0;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

        
        String postsQuery = "SELECT COUNT(*) FROM Posts WHERE user_id=?";
        stmt = conn.prepareStatement(postsQuery);
        stmt.setString(1, userId);
        rs = stmt.executeQuery();
        if (rs.next()) {
            postsCount = rs.getInt(1);
        }

        
        String likesQuery = "SELECT COUNT(*) FROM Likes WHERE user_id=?";
        stmt = conn.prepareStatement(likesQuery);
        stmt.setString(1, userId);
        rs = stmt.executeQuery();
        if (rs.next()) {
            likesCount = rs.getInt(1);
        }

        
        String commentsQuery = "SELECT COUNT(*) FROM Comments WHERE user_id=?";
        stmt = conn.prepareStatement(commentsQuery);
        stmt.setString(1, userId);
        rs = stmt.executeQuery();
        if (rs.next()) {
            commentsCount = rs.getInt(1);
        }

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Dashboard</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f0f4f8;
            font-family: 'Roboto', sans-serif;
        }
        .dashboard {
            padding: 20px;
            max-width: 800px;
            margin: 0 auto;
        }
        .card {
            margin: 20px 0;
            padding: 20px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }
        .card h3 {
            font-size: 1.5rem;
        }
        .logout-btn {
            background-color: #f00;
            color: white;
            padding: 10px 15px;
            text-align: center;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            margin: 20px 0;
        }
    </style>
</head>
<body>

<div class="dashboard">
    <h1>Welcome, <%= session.getAttribute("username") %></h1>
    <div class="card">
        <h3>Posts Count: <%= postsCount %></h3>
    </div>
    <div class="card">
        <h3>Likes Count: <%= likesCount %></h3>
    </div>
    <div class="card">
        <h3>Comments Count: <%= commentsCount %></h3>
    </div>
    <form action="LogoutServlet" method="post">
        <button class="logout-btn">Logout</button>
    </form>
</div>

</body>
</html>
