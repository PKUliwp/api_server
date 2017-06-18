<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="reco_query.reco.Recommendation" %>
<%@ page import="java.util.Collection" %>
<%@ page import="reco_query.entity.Entity" %>
<%@ page import="java.util.Iterator" %>
<% response.setHeader("Access-Control-Allow-Origin", "*"); %>
<%

    String query = request.getParameter("query");
    String conte = request.getParameter("content");

    String api = "";
    String element[] = new String[5];
    String prex[] = new String[5];

    if(query == null || query.length() < 3) {
        query = "index";
    }
    ServletContext sct = getServletConfig().getServletContext();
    Recommendation reco = (Recommendation)sct.getAttribute("db");
    Collection<Entity> results = reco.recommend(query);
    if(results.size() < 5) {
        results = reco.recommend("index");
    }
    Iterator<Entity> it = results.iterator();

    String frame = "";


    String title[] = new String[5];
    String qBody[] = new String[5];
    String aBody[] = new String[5];
    for(int i=0;i<5;i++) {
        Entity entity = it.next();
        if(i == 0) {
            frame = "<div style=\"overflow:hidden;float:right;height:100%;width:35%;\">" +
                    "<iframe id=\"show\" seamless scrolling=\"yes\"" +
                    "style=\"margin:0;padding:0;float:left;height:104%;width:104%;border:none;\" " +
                    "src=\"" +
                    entity.urlPath() +
                    "\"></iframe></div>";
        }
        title[i] = entity.refSoTitle();
        qBody[i] = entity.refSoQuestionBody();
        aBody[i] = entity.refSoAnswerBody();


        element[i] = "<div style=\"float:left;position:relative;width:15%;\">" + entity.name() +
                "</div><div style=\"width:18%;float:left\">" + entity.suffix() + "</div>" +
                "<select style=\"float:left;width:4%;\" type=\"submit\" form=\"f" + i +"\" " +
                "name=\"sel\"" +
                "onChange=\"javascript:document.getElementById('f" + i + "').submit();\">" +
                "<option value=\"" + entity.urlPath() + "\">Javadoc</option>" +
                "<option value=\"qa\">Q&A</option>" +
                "</select>" +
                "<br/>";
        
        prex[i] = "<div style=\"float:left;width:28%;\" >" + entity.prefix() + "<a href="+ entity.urlPath() +" target=\"show\">^</a>" +
                "</div>";
    }


    for(int i=0;i<5;i++) {

        element[i] = prex[i] + element[i];
        api += element[i];
    }
    String html = "\n";

    html = html.replaceAll( "&", "&amp;");
    html = html.replaceAll( "\"", "&quot;");  //"
    html = html.replaceAll( "\t", "&nbsp;&nbsp;");// 替换跳格
    html = html.replaceAll( " ", "&nbsp;");// 替换空格
    html = html.replaceAll("<", "&lt;");
    html = html.replaceAll( ">", "&gt;");
    html = html.replaceAll("\n","<br/>");

    String so = "";
    for(int i=0;i<5;i++) {
        so += "<form id=\"f" + i +"\" method=\"post\" target=\"show\" action=\"http://localhost:9090/api/qa_show.jsp\">";
        so += "<input type=\"text\" style=\"display:none\" name=\"value\" value=\"" +
                (title[i] +"<hr/>"+ qBody[i] +"<hr/>"+ aBody[i]).replaceAll("\"", "&quot;") +
                "\" />";

        so += "</form>";
    }



    html = frame +  so + api + html ;

    out.print(html);


%>