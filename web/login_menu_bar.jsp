<nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">Vegefoods</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="oi oi-menu"></span> Menu
            </button>
            <%
                
            %>
            <div class="collapse navbar-collapse" id="ftco-nav">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item"><a href="index.jsp" class="nav-link">Home</a></li>
                    <li class="nav-item"><a href="about.jsp" class="nav-link">About</a></li>
                    <li class="nav-item"><a href="contact.jsp" class="nav-link">Contact</a></li>
                    <%
                        String uri = request.getRequestURI();
                        String pageName = uri.substring(uri.lastIndexOf("/") + 1);
                        
                        if(pageName.contains("login")){%>
                    
                    <li class="nav-item dropdown">
                        <a class="nav-link btn btn-primary" id="dropdown04" data-toggle="dropdown" style='padding:15px 0px;' aria-haspopup="true" aria-expanded="true">Sign Up</a>
                        <div class="dropdown-menu" aria-labelledby="dropdown04">
                            <a class="dropdown-item" href="signup.jsp">For Customer</a>
                            <a class="dropdown-item" href="shop_emp_signup.jsp">For Shopkeeper/Employee</a>
                        </div>
                    </li>
                    
                        <% }else{
                                if (pageName.contains("signup")){ %>
                                    <li class="nav-item"><button class="btn btn-primary" onclick="window.location.href='login.jsp'">Login</button></li>
                                <% }
                            }
                    %>
                    
                </ul>
            </div>
        </div>
    </nav>