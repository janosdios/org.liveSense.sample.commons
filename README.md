---
Sample Commons Readme
-----------------------------
**Version 0.1**  
<janos.dios@allretailconsulting.com>  
24/03/2013  

---
---

#### Overview
The purpose of the org.livesense.sample.commons package is to give an anchestor bundle to every liveSense sample to ensure the standardized, nice and clean user interface which easily can be maintained. If this bundle is installed to the JCR repository, any other sample code can use its nodetypes and jsp-pages to render the HTML header, footer. This bundle is using the Bootstrap framework, and built on Bootswatch.

----

#### Sample site

This node type has the multilingual labels for the current sample site.

- **'sampleName'** (String) : this property determines which sample the node belongs to
- **'styleName'** (String) : which Bootswatch theme to use (default: spacelab, '.united', '.spruce', etc.).
- **'brand'** (String) : label for the brand in the menu
- **'backtoTitle'** (String) : label for the 'back to' menu item
- **'backtoTooltip'** (String) : tooltip for the 'back to' menu item
- **'bundleinfo'** (String) : label for the 'bundle info' in the header
- **'backtotop'** (String) : label for the 'back to top' button in the footer
- **'footertext'** (String) : footer text

Node type name: **[samplecommons: samplesite]**    

---

#### Sample page

This node type represents an individual HTML page or a menu item in the sample site. The defined page's menu name is shown in the menu bar.
- **'sampleName'** (String) : this property determines which sample the node belongs to
- **'title'** (String) : the HTML page's title
- **'menuOrder'** (String) : use to determine the sequence of the menu items
- **'menuName'** (String) : label for the menu item
- **'menuLevel'** (String) : **'1'** for the main menu items, **'2'** for the sub-menu items
- **'menuLevel2Parent'** (String) : node name of the parent menu item for sub-menu items
- **'jstorun'** (String) : run this javascript when menu item selected
- **'menuLink'** (String) : href section for the menu item
- **'islink'** (Boolean) : determines if the menu item is a link or not
- **'enabled'** (Boolean) : hide/show menu item
- **'isdivider'** (Boolean) : use this if the menu item is a divider (only in sub-menus)
- **'headerLabel'** (String) : the page's title in the header
- **'headerSubLabel'** (String) : the page's sub-title in the header
- **'headerType'** (String) : **'text'**: show content in a well-element, **'bundleinfo'**: bundle info in a well-element
- **'content'** (String) : text to display in the header if the page type is 'text'

Node type name: **[samplecommons: samplepage]**

---

#### Subpage

Use subpages to make chapters in a specified page. If allowed, subpage's name will shown in the subpage-navigator line, under the header. This bundle only renders the subpage-navigator bar, **will not render the subpage itself**, that is sample-specific task.
- **'sampleName'** (String) : this property determines which sample the node belongs to 
- **'parentPage'** (String) : the subpage belongs to this page
- **'menuOrder'** (String) : determine the order of the subpages
- **'title'** (String) : title of the subpage
- **'content'** (String) : content of the subpage 
- **'contentType'** (String) : **'text'** means a standard title/content subpage, or samples can define their own
- **'visibleInSubnav'** (Boolean) : show in the subpage-navigator bar

Node type name: **[samplecommons: subpage]**

---

#### Bundle info

Use this node type to determine the bundle information to display in the header.
- **'sampleName'** (String) : this property determines which sample the node belongs to
- **'infoName'** (String) : label for the information's name (f.e.: 'Bundle name', 'Version')
- **'infoValue'** (String) : value of the information (f.e.: '1.0.0')
- **'infoOrder'** (String) : use this to determine the order
- **'infoLink'** (String) : href part for the information value

Node type name: **[samplecommons: bundleinfo]**

#### Usage
Simply define the node types of your new sample project using the samplecommons' ones as the type:

	[markdownsample:samplesite] > samplecommons:samplesite
	[markdownsample:markdownpage] > samplecommons:samplepage
	...

Create the necessary sample page, sub-page, etc. nodes:

	...
	"index": {
    	"sampleName": "markdownsample",
		"title": "Markdown Sample",
 		"menuOrder": "1",
    	"menuName_en": "Home",
		"menuLevel": "1",
		"menuLevel2Parent": "",
		"menuLink": "index.html",
		"jstorun": "",
		"islink": true,
		"enabled": true,
		"isdivider": false,
		"headerLabel_en": "Markdown",
		"headerSubLabel_en": "Nice and Clean",
		"headerType": "bundleinfo",
    	"jcr:primaryType": "markdownsample:markdownpage"
	},
	...

Include the header, sub-header and footer jsp files in your new sample's jsp: 

	<jsp:directive.include file="/apps/samplecommons/samplepage/header.jsp" />
	<jsp:directive.include file="/apps/samplecommons/samplepage/subheader.jsp" />
	...
	<jsp:directive.include file="/apps/samplecommons/samplepage/footer.jsp" />

And it's done!




