<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.zensar.db.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Talkzi - View Likes</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #e6f7e6; 
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            margin: 0;
            position: relative;
        }
        .sparkle {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            background: url('sparkle.png') repeat;
            background-size: 50px 50px;
            opacity: 0.5;
            z-index: 0;
            animation: sparkleAnimation 5s infinite;
        }
        @keyframes sparkleAnimation {
            0% { background-position: 0 0; }
            100% { background-position: 100px 100px; }
        }
        .header {
            background-color: #4caf50; 
            color: white;
            padding: 30px 0;
            text-align: center;
            position: relative;
            z-index: 3;
        }
        .header img {
            height: 80px;
            margin-bottom: 10px;
        }
        .header .company-name {
            font-size: 2rem;
            font-weight: bold;
            text-transform: uppercase;
        }
        .main-content {
            flex: 1;
            padding: 40px 20px;
            background-color: #fff;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            position: relative;
            z-index: 1;
        }
        .table-container {
            margin-top: 30px;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            background-color: #f9f9f9;
        }
        h2 {
            font-size: 1.8rem;
            margin-bottom: 20px;
            font-weight: bold;
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            border-radius: 10px;
            overflow: hidden;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #4caf50; 
            color: white;
        }
        td {
            background-color: #ffffff;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #e8f5e9;
        }
        .footer {
            background-color: #4caf50; 
            color: white;
            padding: 10px;
            text-align: center;
            width: 100%;
            margin-top: auto;
            position: relative;
            z-index: 3;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .footer .logout-btn {
            color: #fff;
            text-decoration: none;
            padding: 10px 20px;
            background-color: #dc3545;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }
        .footer .logout-btn:hover {
            background-color: #c82333;
        }
        .footer .company-info {
            font-size: 0.9rem;
            color: #f1f1f1;
        }
        .like-icon {
            color: #e74c3c;
        }
    </style>
</head>
<body>
<header class="header">
    <img src="images/taalkzi.jpeg" alt="Talkzi Logo">
    <div class="company-name">Talkzi - Likes</div>
</header>

<div class="sparkle"></div>

<main class="main-content">
    <div class="table-container">
        <h2>Likes</h2>
        <table>
            <thead>
                <tr>
                    <th>Sr. No.</th>
                    <th>Like ID</th>
                    <th>Post ID</th>
                    <th>User ID</th>
                    <th>Liked At</th>
                    <th>Like</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    try {
                        Connection con = ConnectDB.dbCon();
                        PreparedStatement ps = con.prepareStatement("SELECT like_id, post_id, user_id, liked_at FROM Likes");
                        ResultSet rs = ps.executeQuery();
                        int srNo = 1;
                        while (rs.next()) {
                %>
                <tr>
                    <td><%= srNo++ %></td>
                    <td><%= rs.getInt("like_id") %></td>
                    <td><%= rs.getInt("post_id") %></td>
                    <td><%= rs.getInt("user_id") %></td>
                    <td><%= rs.getTimestamp("liked_at") %></td>
                    <td><i class="fa fa-heart like-icon"></i></td>
                </tr>
                <% 
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
                %>
            </tbody>
        </table>
    </div>
</main>

<footer class="footer">
    <a href="admin_welcome_dashboard.html" class="logout-btn">Logout</a>
    <div class="company-info">
        | Talkzi: Your Social Hub | &copy; 2024
    </div>
</footer>

<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>
