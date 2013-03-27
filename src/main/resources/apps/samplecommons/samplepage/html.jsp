<%@page import="org.liveSense.core.wrapper.JcrNodeWrapper"%>
<%@page import="org.liveSense.service.markdown.MarkdownWrapper"%>
<%@page import="org.liveSense.service.markdown.MarkdownService"%>

<%@page import="javax.jcr.NodeIterator"%>
<%@page import="javax.jcr.query.Query"%>
<%@page import="javax.jcr.query.QueryManager"%>
<%@page import="javax.jcr.Node"%>
<%@page import="java.util.Locale"%>
<%@page import="org.apache.sling.api.resource.Resource"%>

<%@page session="false"%>
<%@page contentType="text/html; charset=UTF-8" %> 
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="sling" uri="http://sling.apache.org/taglibs/sling/1.1"%>

<sling:defineObjects/>
<jsp:directive.include file="/apps/samplecommons/samplepage/header.jsp" />
<jsp:directive.include file="/apps/samplecommons/samplepage/subheader.jsp" />


<c:set var="sampleName" value="${node.properties['sampleName']}"/>
<c:set var="query_sections" value="SELECT * FROM  [samplecommons:subpage] WHERE [sampleName] = '${sampleName}' AND [parentPage] = '${node.name}' ORDER BY [menuOrder]"/>
<c:forEach var="k" items="${node.SQL2Query[query_sections]}">
	<section id="${k.name}">
  		<div class="page-header">
    		<h1>${k.properties['title']}</h1>
  		</div>
 		<div class="row">
    		<div class="span8">
    			${k.properties['content']}
			</div>
    		<div class="span4"></div>
		</div>
	</section>
</c:forEach>



<jsp:directive.include file="/apps/samplecommons/samplepage/footer.jsp" />






