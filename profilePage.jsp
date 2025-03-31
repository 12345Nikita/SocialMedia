<%@ page import="java.sql.*,com.zensar.db.ConnectDB, com.r3sys.services.GetterSetter" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile</title>
    <style>
       * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f4f6f9;
    color: #333;
}

/* Header and Image */


.header .logo {
    position: absolute;
    top: 10px;
    right: 20px;
    max-width: 150px;
    transition: transform 0.3s ease, filter 0.3s ease;
    border-radius: 8px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    overflow: hidden; /* Ensures the rounded corners effect works */
}

.header .logo:hover {
    transform: scale(1.1) rotate(5deg);
    filter: brightness(1.2); /* Adds a subtle brightness effect on hover */
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15); /* Makes the shadow larger and softer */
}

.header {
    display: flex;
    justify-content: flex-end;
    align-items: center;
    padding: 20px;
    background-color: #3498db;
    position: relative;
    border-bottom: 4px solid #2980b9;
}


.container {
    max-width: 900px;
    margin: 30px auto;
    padding: 30px;
    background-color: #ffffff;
    border-radius: 12px;
    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
}

/* Heading Styles */
h1 {
    text-align: center;
    color: #2c3e50;
    font-size: 2.4em;
    margin-bottom: 30px;
}

h2 {
    font-size: 1.8em;
    color: #1abc9c;
    margin-bottom: 15px;
    padding-bottom: 8px;
    border-bottom: 2px solid #1abc9c;
}

/* Profile Info Section */
.profile-info {
    background-color: #fafafa;
    padding: 25px;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
    margin-bottom: 30px;
}

.profile-info label {
    font-weight: 600;
    color: #555;
}

.profile-info p {
    font-size: 1.2em;
    color: #444;
}

/* Delete Link */
.delete-link {
    display: inline-block;
    margin-top: 20px;
    padding: 12px 20px;
    background-color: #e74c3c;
    color: white;
    text-decoration: none;
    border-radius: 5px;
    font-weight: 600;
    text-align: center;
    transition: background-color 0.3s, transform 0.2s ease;
}

.delete-link:hover {
    background-color: #c0392b;
    transform: translateY(-2px);
}

/* Posts and Comments Styling */
.posts, .comments {
    background-color: #f9f9f9;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    margin-bottom: 40px;
}

.post, .comment {
    background-color: #fff;
    padding: 20px;
    margin-bottom: 20px;
    border-radius: 8px;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
    transition: transform 0.2s ease, box-shadow 0.3s ease;
}

.post:hover, .comment:hover {
    transform: translateY(-5px);
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
}

.post img {
    max-width: 100%;
    border-radius: 8px;
    margin-top: 10px;
}

h3 {
    color: #2c3e50;
    font-size: 1.6em;
    margin-bottom: 15px;
}

.no-content {
    font-size: 1.2em;
    color: #888;
    text-align: center;
}

/* Media Queries for Responsive Design */
@media screen and (max-width: 768px) {
    .container {
        padding: 20px;
    }

    .profile-info, .posts, .comments {
        padding: 20px;
    }

    .header .logo {
        top: 0;
        right: 10px;
        max-width: 120px;
    }

    h1 {
        font-size: 2em;
    }
}
       
      
        
    </style>
</head>
<body>

<div class="header">
    <img src="images/taalkzi.jpeg" alt="Logo" class="logo">
</div>

<div class="container">
    <h1>User Profile</h1>

    <%
        String userId = request.getParameter("user_id");

        if (userId != null && !userId.trim().isEmpty()) {
            Connection con = null;
            PreparedStatement ps = null, psPosts = null, psComments = null;
            ResultSet rs = null, rsPosts = null, rsComments = null;

            try {
                con = ConnectDB.dbCon();

                String userQuery = "SELECT * FROM Users WHERE user_id = ?";
                ps = con.prepareStatement(userQuery);
                ps.setInt(1, Integer.parseInt(userId));
                rs = ps.executeQuery();

                if (rs.next()) {
                    GetterSetter user = new GetterSetter();
                    user.setUser_id(rs.getInt("user_id"));
                    user.setUsername(rs.getString("username"));
                    user.setEmail(rs.getString("email"));
    %>
                    <div class="profile-info">
                        <label>User ID:</label>
                        <p><%= user.getUser_id() %></p>
                        <label>Username:</label>
                        <p><%= user.getUsername() %></p>
                        <label>Email:</label>
                        <p><%= user.getEmail() %></p>
                        
                        <a href="delete_users1.jsp?user_id=<%= user.getUser_id() %>" class="delete-link">Delete My Account</a>
                    </div>
<%
    String postQuery = "SELECT * FROM Posts WHERE user_id = ?";
    psPosts = con.prepareStatement(postQuery);
    psPosts.setInt(1, Integer.parseInt(userId));
    rsPosts = psPosts.executeQuery();

    if (rsPosts.isBeforeFirst()) {
%>
    <div class="posts">
        <h2>Posts</h2>
<%
        while (rsPosts.next()) {
            GetterSetter post = new GetterSetter();
            post.setPost_id(rsPosts.getInt("post_id"));
            post.setPost_text(rsPosts.getString("post_text"));
            post.setMedia_url(rsPosts.getString("media_url"));
            post.setPost_type(rsPosts.getString("post_type"));
%>
            <div class="post">
                <h3>Post Type: <%= post.getPost_type() %></h3>
                <p><%= post.getPost_text() %></p>

                <% 
                    String mediaUrl = post.getMedia_url();
                    if (mediaUrl != null && !mediaUrl.isEmpty()) {
                        // Check if the media is an image
                        if (mediaUrl.endsWith(".jpg") || mediaUrl.endsWith(".jpeg") || mediaUrl.endsWith(".png") || mediaUrl.endsWith(".gif")) {
                %>
                            <!-- Display Image -->
                            <img src="<%= mediaUrl %>" alt="Post Media" style="max-width: 100%; border-radius: 8px; margin-top: 10px;">
                <% 
                        // Check if the media is a video
                        } else if (mediaUrl.endsWith(".mp4") || mediaUrl.endsWith(".webm") || mediaUrl.endsWith(".ogg")) {
                %>
                            <video width="100%" controls style="border-radius: 8px; margin-top: 10px;">
                                <source src="<%= mediaUrl %>" type="video/mp4">
                                Your browser does not support the video tag.
                            </video>
                <% 
                        // If the URL is a YouTube or Vimeo link, embed the video using iframe
                        } else if (mediaUrl.contains("youtube.com") || mediaUrl.contains("vimeo.com")) {
                %>
                            <iframe width="100%" height="315" src="<%= mediaUrl %>" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
                <% 
                        // Check if the media is an audio file (e.g., .mp3, .wav)
                        } else if (mediaUrl.endsWith(".mp3") || mediaUrl.endsWith(".wav") || mediaUrl.endsWith(".ogg")) {
                %>
                            <audio controls style="width: 100%; margin-top: 10px;">
                                <source src="<%= mediaUrl %>" type="audio/mpeg">
                                Your browser does not support the audio element.
                            </audio>
                <% 
                        }
                    }
                %>
            </div>
<%
        }
    %>
    </div>
<%
    } else {
%>
        <p class="no-content">No posts found for this user.</p>
<%
    }


  

                    String commentQuery = "SELECT * FROM Comments WHERE user_id = ?";
                    psComments = con.prepareStatement(commentQuery);
                    psComments.setInt(1, Integer.parseInt(userId));
                    rsComments = psComments.executeQuery();

                    if (rsComments.isBeforeFirst()) {
                %>
                    <div class="comments">
                        <h2>Comments</h2>
                    <%
                        while (rsComments.next()) {
                            GetterSetter comment = new GetterSetter();
                            comment.setComment_text(rsComments.getString("comment_text"));
                    %>
                        <div class="comment">
                            <p><%= comment.getComment_text() %></p>
                        </div>
                    <%
                        }
                    %>
                    </div>
                <%
                    } else {
                %>
                    <p class="no-content">No comments found for this user.</p>
                <%
                    }
                } else {
    %>
                <p class="no-content">No user found with the provided ID.</p>
    <%
                }
            } catch (SQLException e) {
                e.printStackTrace();
    %>
                <p class="no-content">An error occurred while fetching user details.</p>
    <%
            } 
        } else {
    %>
            <p class="no-content">No user ID provided.</p>
    <%
        }
    %>
</div>

</body>
</html>
