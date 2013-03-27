<%@page import="org.liveSense.core.wrapper.JcrNodeWrapper"%>
<%@page import="org.liveSense.service.markdown.MarkdownWrapper"%>
<%@page import="org.liveSense.service.markdown.MarkdownService"%>

<%@page import="javax.jcr.NodeIterator"%>
<%@page import="javax.jcr.query.Query"%>
<%@page import="javax.jcr.query.QueryManager"%>
<%@page import="javax.jcr.Node"%>
<%@page import="java.util.Locale"%>

<%@page session="false"%>
<%@page contentType="text/html; charset=UTF-8" %> 
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="sling" uri="http://sling.apache.org/taglibs/sling/1.1"%>

<sling:defineObjects/>

<%
	JcrNodeWrapper node_footer = new JcrNodeWrapper(currentNode, (Locale) request.getAttribute("curr_locale"), true);
	pageContext.setAttribute("markdown", new MarkdownWrapper(sling.getService(MarkdownService.class)));
	pageContext.setAttribute("node_footer", node_footer);
%>

		<br><br>
		<hr>
	
		<footer id="footer">
    		<p class="pull-right"><a href="#top">${nodesite.properties['backtotop']}</a></p>
        	<div class="links">
        		<a href="http://livesense.me/blog">Blog</a>
          		<a href="#">RSS</a>
          		<a href="#">Twitter</a>
          		<a href="https://github.com/livesense/">GitHub</a>
        	</div>
        	${nodesite.properties['footertext']}
		</footer>
 
	</div> <!-- /container -->


    <!-- Javascript -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="/samplecommons/js/jquery-1.9.1.min.js"></script>
    <script src="/samplecommons/js/jquery.smooth-scroll.min.js"></script>
    <script src="/samplecommons/js/bootstrap.min.js"></script>
    <script src="/samplecommons/js/bootswatch.js"></script>

</body>
  
</html>
