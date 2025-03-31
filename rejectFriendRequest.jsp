<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reject Friend Request</title>

    <!-- Internal CSS -->
    <style>
        /* General page style */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f7f6; /* Light gray background */
            margin: 0;
            padding: 0;
        }

        /* Container to hold all content */
        .container {
            width: 60%;
            margin: 50px auto;
            padding: 30px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        /* Header styling */
        h1 {
            text-align: center;
            color: #333;
            font-size: 24px;
        }

        /* Alert message styles */
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            font-size: 16px;
            text-align: center;
        }

        .alert-success {
            background-color: #28a745; /* Green background for success */
            color: white;
        }

        .alert-danger {
            background-color: #dc3545; /* Red background for error */
            color: white;
        }

        /* Form styling */
        .form-group {
            margin-bottom: 20px;
        }

        .btn {
            display: inline-block;
            padding: 12px 30px;
            margin: 10px 0;
            text-align: center;
            font-size: 16px;
            cursor: pointer;
            border-radius: 5px;
            border: none;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }

        .btn-primary {
            background-color: #007bff; /* Blue background for primary button */
            color: white;
        }

        .btn-danger {
            background-color: #dc3545; /* Red background for reject button */
            color: white;
        }

        .btn-primary:hover {
            background-color: #0056b3; /* Darker blue on hover */
        }

        .btn-danger:hover {
            background-color: #c82333; /* Darker red on hover */
        }

        /* Back to profile button styling */
        .back-link {
            display: inline-block;
            text-align: center;
            margin-top: 40px;
            width: 100%;
        }

        .back-link a {
            text-decoration: none;
            color: white;
            background-color: #007bff; /* Strong blue background */
            padding: 12px 30px;
            font-size: 16px;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .back-link a:hover {
            background-color: #0056b3; /* Darker blue on hover */
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Reject Friend Request</h1>

        <!-- Display success or error messages -->
        <c:if test="${not empty param.message}">
            <div class="alert alert-success">${param.message}</div>
        </c:if>

        <c:if test="${not empty param.error}">
            <div class="alert alert-danger">${param.error}</div>
        </c:if>

        <!-- Form to reject a friend request -->
        <form action="RejectFriendRequestServlet" method="post">
            <!-- Hidden field to pass the user2Id (who sent the request) -->
            <input type="hidden" name="user2Id" value="${param.user2Id}"> <!-- Assuming user2Id is passed in the request -->
            
            <button type="submit" class="btn btn-danger">Reject Friend Request</button>
        </form>

        <!-- Back to Profile Button -->
        <div class="back-link">
            <a href="profile.jsp" class="btn btn-primary">Back to Profile</a>
        </div>
    </div>
</body>
</html>
