<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@page import ="com.zensar.db.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Talkzi - Users</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #d0f4c0; 
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
            opacity: 0.6;
            z-index: 0;
            animation: sparkleAnimation 5s infinite;
        }
        @keyframes sparkleAnimation {
            0% { background-position: 0 0; }
            100% { background-position: 100px 100px; }
        }
        .header {
            background-color: #4caf50; 
            color: #fff;
            padding: 20px;
            display: flex;
            align-items: center;
            justify-content: center; 
            position: relative;
            z-index: 3;
            flex-direction: column; 
        }
        .header img {
            height: 60px; 
        }
        .header .company-name {
            font-size: 1.5rem;
            margin-top: 10px;
        }
        .header .menu-icon {
            display: none; 
        }
        .main-content {
            flex: 1;
            padding: 20px;
            background-color: #ffffff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            position: relative;
            z-index: 1;
        }
        .footer {
            background-color: #4caf50;
            color: #fff;
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
            margin-right: 20px;
            color: #fff;
            text-decoration: none;
            padding: 5px 10px;
            background-color: #dc3545;
            border-radius: 5px;
            transition: background-color 0.3s ease, color 0.3s ease;
        }
        .footer .logout-btn:hover {
            background-color: #c82333;
        }
        .table-container {
            margin-top: 20px;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            overflow-x: auto;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
<header class="header">
    <img src="images/taalkzi.jpeg" alt="Talkzi Logo">
    <div class="company-name">Talkzi</div>
</header>

<div class="sparkle"></div>

<main class="main-content">
    <div class="table-container">
        <h2>Users Information</h2>
        <table>
            <thead>
                <tr>
                    <th>Sr. No.</th>
                    <th>Username</th>
                    <th>Email</th>
                    <th>Created At</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    try {
                        Connection con = ConnectDB.dbCon();
                        PreparedStatement ps = con.prepareStatement("SELECT * FROM users");
                        ResultSet rs = ps.executeQuery();
                        int srNo = 1;
                        while (rs.next()) {
                %>
                <tr>
                    <td><%= srNo++ %></td>
                    <td><%= rs.getString("username") %></td>
                    <td><%= rs.getString("email") %></td>
                    <td><%= rs.getString("created_at") %></td>
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
    <div>
        | Talkzi:Your Social Hub | &copy; 2024
    </div>
</footer>
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>
