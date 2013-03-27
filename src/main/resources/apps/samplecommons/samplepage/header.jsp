<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="org.liveSense.service.languageselector.LanguageSelectorService"%>
<%@page import="javax.security.auth.callback.LanguageCallback"%>
<%@page import="org.liveSense.core.wrapper.RequestWrapper"%>
<%@page import="java.util.Locale"%>
<%@page import="org.liveSense.service.markdown.MarkdownWrapper"%>
<%@page import="org.liveSense.core.wrapper.JcrNodeWrapper"%>
<%@page import="javax.jcr.NodeIterator"%>
<%@page import="javax.jcr.query.Query"%>
<%@page import="javax.jcr.query.QueryManager"%>
<%@page import="javax.jcr.Node"%>
<%@page import="org.liveSense.service.markdown.MarkdownService"%>

<%@page session="false"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="sling" uri="http://sling.apache.org/taglibs/sling/1.1"%>
<%@taglib prefix="json" uri="http://www.atg.com/taglibs/json"%>
<sling:defineObjects />
<%
		// Get Node wrapper
		LanguageSelectorService languageSelectorService = sling.getService(LanguageSelectorService.class);
		Locale locale =  languageSelectorService.getLocaleByRequest(request);
		JcrNodeWrapper node = new JcrNodeWrapper(currentNode, locale, true);

		pageContext.setAttribute("markdown", new MarkdownWrapper(sling.getService(MarkdownService.class)));
		pageContext.setAttribute("node", node);
		
	    String sql_site = "SELECT * FROM  [samplecommons:samplesite] WHERE [sampleName] = '" + currentNode.getProperty("sampleName").getString() + "'";
	    JcrNodeWrapper nodesite = new JcrNodeWrapper(currentNode.getSession().getWorkspace().getQueryManager().createQuery(sql_site, Query.JCR_SQL2).execute().getNodes().nextNode(), locale, true);
		pageContext.setAttribute("nodesite", nodesite);
%>

<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" lang="en-US" xml:lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

	<script type="text/javascript">
	function post_language(lang_code) {
		<%	
		final LanguageSelectorService lang_service = sling.getService(LanguageSelectorService.class);
		final String storekey_name = lang_service.getStoreKeyName(); 
		%>
		var myForm = document.createElement("form");
  		myForm.method="post" ;
  		myForm.action = "/session/language";

  		var myInput = document.createElement("input") ;
  		myInput.setAttribute("name", "<%= storekey_name %>");
  		myInput.setAttribute("value", lang_code);
  		myForm.appendChild(myInput) ;

  		document.body.appendChild(myForm) ;
  		myForm.submit() ;
  		document.body.removeChild(myForm) ;
	}
	</script>    

    <title>${node.properties['title']}</title>
    
    <link href="/samplecommons/css/bootstrap.min${nodesite.properties['styleName']}.css" rel="stylesheet">
    <link href="/samplecommons/css/bootstrap-responsive.min.css" rel="stylesheet">
    <link href="/samplecommons/css/font-awesome.min.css" rel="stylesheet">
    <link href="/samplecommons/css/bootswatch.css" rel="stylesheet">
    <link href="/samplecommons/css/livesense-sample.css" rel="stylesheet">
</head>

<body class="preview" id="top" data-spy="scroll" data-target=".subnav" data-offset="80">
    
<!-- Navbar -->

	<div class="navbar navbar-fixed-top">
   		<div class="navbar-inner">
     		<div class="container">
       			<a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
         			<span class="icon-bar"></span>
         			<span class="icon-bar"></span>
         			<span class="icon-bar"></span>
       			</a>
       			<a class="brand" href="http://www.livesense.me">${nodesite.properties['brand']}</a>
       			<div class="nav-collapse collapse" id="main-menu">
        			<ul class="nav" id="main-menu-left">

  						<c:set var="sampleName" value="${node.properties['sampleName']}"/>
						<c:set var="query_level1" value="SELECT * FROM  [samplecommons:samplepage] WHERE [sampleName] = '${sampleName}' AND [menuLevel] = '1' ORDER BY [menuOrder]"/>
						<c:forEach var="n" items="${node.SQL2Query[query_level1]}">

							<c:set var="link_level1" value = "#" />
							<c:if test="${n.properties['islink'].boolean}">
								<c:set var="link_level1" value = "${n.properties['menuLink']}" />
							</c:if>

							<c:if test="${n.properties['jstorun'] != ''}">
								<c:set var="link_level1" value = "javascript: ${n.properties['jstorun']}" />
							</c:if>

							<!-- Selecting menu level 2 -->
							<c:set var="query_level2" value="SELECT * FROM [samplecommons:samplepage] WHERE [sampleName] = '${sampleName}' AND [menuLevel2Parent] ='${n.name}' AND [menuLevel] = '2' ORDER BY [menuOrder]"/>
							<c:set var="items_level2" value = "${node.SQL2Query[query_level2]}" />

							<c:choose>
								<c:when test="${items_level2.size != 0}">

          							<li class="dropdown">
            							<a class="dropdown-toggle" data-toggle="dropdown" href="#">${n.properties['menuName']} <b class="caret"></b></a>
            							<ul class="dropdown-menu" id="swatch-menu">

											<c:forEach var="j" items="${items_level2}">
												<c:set var="link_level2" value = "#" />
												<c:if test="${j.properties['islink'].boolean}">
													<c:set var="link_level2" value = "${j.properties['menuLink']}" />
												</c:if>

												<c:if test="${j.properties['jstorun'] != ''}">
													<c:set var="link_level2" value = "javascript: ${j.properties['jstorun']}" />
												</c:if>
									
												<c:choose>
													<c:when test="${j.properties['isdivider'].boolean}">
														<li class="divider"></li>
													</c:when>
													<c:otherwise>
														<li><a href="${link_level2}">${j.properties['menuName']}</a></li>									
													</c:otherwise>
												</c:choose>
									
									
											</c:forEach>

										</ul>
          							</li>

								</c:when>
								<c:otherwise>
								
									<c:choose>
										<c:when test="${n.properties['isdivider'].boolean}">
											<li class="divider"></li>
										</c:when>
										<c:otherwise>
											<li><a href="${link_level1}">${n.properties['menuName']}</a></li>
										</c:otherwise>
									</c:choose>
									
								</c:otherwise>
							</c:choose>

						</c:forEach>
        			</ul>
        			
        			<ul class="nav pull-right" id="main-menu-right">
          				<li><a rel="tooltip" target="_blank" href="http://livesense.me/samples" title="${nodesite.properties['backtoTooltip']}">${nodesite.properties['backtoTitle']} <i class="icon-share-alt"></i></a></li>
        			</ul>
       			</div>
     		</div>
   		</div>
 	</div>





<div class="container">



