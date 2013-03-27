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

<!-- Sub-Header -->
  		<c:set var="sampleName" value="${node.properties['sampleName']}"/>
 		
		<c:choose>
   			<c:when test="${node.properties['headerLabel'] == null}"><c:set var="visible" value="hide"/></c:when>
   			<c:otherwise><c:set var="visible" value=""/></c:otherwise>
		</c:choose>

		<header class="jumbotron subhead ${visible}" id="overview">
  			<div class="row">
    			<div class="span6">
      				<h1>${node.properties['headerLabel']}</h1>
      				<p class="lead">${node.properties['headerSubLabel']}</p>
    			</div>
    			<div class="span6">

					<c:choose>
   						<c:when test="${node.properties['headerType'] == 'text'}">
							<div class="well" style="padding: 25px 25px 15px 25px;">
								<p>${node.properties['content']}</p>
      						</div>
   						</c:when>

   						<c:when test="${node.properties['headerType'] == 'bundleinfo'}">
							<div class="well" style="padding: 25px 25px 15px 25px;">
								<div class="span5">
      								<div class="row-fluid">
      									<div class="span12">
  											<legend>${nodesite.properties['bundleinfo']}</legend>
  											<dl class="dl-horizontal">
  												<c:set var="query" value="SELECT * FROM  [samplecommons:bundleinfo] WHERE [sampleName] = '${sampleName}' ORDER BY [infoOrder]"/>
												<c:forEach var="n" items="${node.SQL2Query[query]}">
													<dt>${n.properties['infoName']}</dt>
											
													<c:choose>
   														<c:when test="${empty n.properties['infoLink']}">
   															<dd>${n.properties['infoValue']}</dd>
   														</c:when>
   														<c:otherwise>
   															<dd><a href="${n.properties['infoLink']}">${n.properties['infoValue']}</a></dd>	
   														</c:otherwise>
													</c:choose>
  												</c:forEach>
											</dl>
										</div>
									</div>
      							</div>        	
        						<div style="clear:both"></div>
      						</div>
   						</c:when>

   						<c:otherwise>
    						<div class="bsa well">
          						<div id="bsap_1277971" class="bsarocks bsap_c466df00a3cd5ee8568b5c4983b6bb19"></div>
      						</div>
   						</c:otherwise>
					</c:choose>
    			</div>
  			</div>
    		
    		<c:set var="query_sub" value="SELECT * FROM  [samplecommons:subpage] WHERE [sampleName] = '${sampleName}' AND [parentPage] = '${node.name}' AND [visibleInSubnav] = true ORDER BY [menuOrder]"/>
  			<c:set var="items_sub" value = "${node.SQL2Query[query_sub]}" />
  			<c:choose>
				<c:when test="${items_sub.size != 0}">
  					<div class="subnav">
    					<ul class="nav nav-pills">
							<c:forEach var="j" items="${items_sub}">
    							<dt>${j.properties['infoName']}</dt>
      							<li><a href="#${j.name}">${j.properties['title']}</a></li>
    						</c:forEach>
    					</ul>
  					</div>
  				</c:when>
  			</c:choose>


		</header>
