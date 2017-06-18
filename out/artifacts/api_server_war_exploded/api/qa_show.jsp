<%--
  Created by IntelliJ IDEA.
  User: liwp
  Date: 2017/5/25
  Time: 下午10:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>qa</title>
    <style type="text/css">
        a:link {color: #e74c3c} /* 未访问的链接 */
        a:visited {color: #f1c40f} /* 已访问的链接 */
        a:hover {color: #2ecc71} /* 鼠标移动到链接上 */
        a:active {color: #9b59b6} /* 选定的链接 */
    </style>
</head>
<body style="color:whitesmoke">
    <%
        if(request.getParameter("sel").length() > 5) {
            response.sendRedirect(request.getParameter("sel"));
        }
        String content = request.getParameter("value");
        out.println(content);
    %>
</body>
</html>
