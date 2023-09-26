<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                 xmlns:fo="http://www.w3.org/1999/XSL/Format"
                 xmlns:msxsl="urn:schemas-microsoft-com:xslt" 
                 xmlns:user="urn:my-scripts" 
                 exclude-result-prefixes="fo"                 
                 version="1.0"> 
    <xsl:output method="html"/> 
    <xsl:template match="/">   
    <html>
      <head>        
        <title>Interactive Electronic Technical Manual</title>
        <link rel="stylesheet" type="text/css" href="CSS/my_styles.css"/>
      </head>
      <body>
        <xsl:apply-templates/>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="a">
    <A href="JavaScript:void(0);" id="TopicID">
      <xsl:attribute  name="onclick">
        <xsl:value-of select="@onclick" />
      </xsl:attribute>     
      <xsl:apply-templates />
    </A>
  </xsl:template>
  <!--<xsl:template match="a">
    <A href="#" id="TopicID">
      <xsl:attribute  name="onclick">
        <xsl:value-of select="@onclick" />
      </xsl:attribute>
      <xsl:apply-templates />
    </A>
  </xsl:template>-->
  <!--<xsl:template match="//System/description/">
  <xsl:apply-templates select="content|title"/>
    </xsl:template>
  <xsl:template match="section">
    <xsl:apply-templates select="content"/>
  </xsl:template>
  <xsl:template match="//trouble_shooting/section">
    <xsl:apply-templates select="content"/>
  </xsl:template>
  <xsl:template match="//parts_list/section">
    <xsl:apply-templates select="content"/>
  </xsl:template>-->
  <xsl:template match="//system/description/section">
       <xsl:apply-templates select="title"/>
    </xsl:template>
  <xsl:template match="content">
     <p style="text-align:justify">
        <xsl:apply-templates select="para"/>
      </p>
  </xsl:template>
   <!-- Paragraph -->
  <xsl:template match="para">
       <xsl:apply-templates select="text()|B|I|U|DEF|LINK|title|table|figure|ol|ul|dl|caution|warning|note|xlink|figtitle|toc|br|a|h1|h2|h3|h4|h5|h6|content"/>
      <p style="text-align:justify">
        <xsl:apply-templates select="para"/>
      </p>
    </xsl:template>
   <xsl:template match="toc">
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="br">
    <xsl:apply-templates select ="table|figure|graphic"/>
  </xsl:template>
  <xsl:template match="title">
    <H3>
      <xsl:apply-templates/>
    </H3>
  </xsl:template>
  <xsl:template match="h6">
    <b>
      <xsl:apply-templates/>
    </b>
  </xsl:template>
  <xsl:template match="h4">
     <h4>
      <xsl:apply-templates/>
      </h4>   
  </xsl:template>
  <xsl:template match="figtitle">
    <H3>
      <center><xsl:apply-templates/></center>
    </H3>
  </xsl:template>

  <!-- Text -->

  <xsl:template match="text()">
    <xsl:value-of select="normalize-space()"/>
  </xsl:template>

  <!-- Figure-->

  <xsl:template match="graphic">
    <p></p>
    <table align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td>
          <fo:block  space-after="7pt" space-before.optimum="8pt" space-before.maximum="10pt">
            <xsl:element name="IMG">
                <xsl:attribute name="SRC">
                <xsl:value-of select="@fileref"/>
              </xsl:attribute>
          </xsl:element>
          </fo:block >
        </td>
      </tr>
    </table>
  </xsl:template>

  <!-- LIST  -->
  <!--<xsl:template match="OL">
    <xsl:if test="@type='ordered'">
      <ol>
        <xsl:apply-templates/>
      </ol>
    </xsl:if>
    <xsl:if test="@type='unordered'">
      <ul>
        <xsl:apply-templates/>
      </ul>
    </xsl:if>
    <xsl:if test="@type='gloss'">
      <ol>
        <xsl:apply-templates/>
      </ol>
    </xsl:if>
  </xsl:template>-->
  
  <xsl:template match="li">
      <li style="text-align:justify" >
          <xsl:apply-templates/>
      </li>    
  </xsl:template>
  <!-- xlink -->

  <xsl:template match="xlink">
    <A target="top_frame">
      <xsl:attribute  name="href">
        <xsl:value-of select="@onclick" />
      </xsl:attribute>
      <xsl:apply-templates />
    </A>
  </xsl:template>

  
  <xsl:template match="DEF">
    <i>
      <xsl:apply-templates/>
    </i>
  </xsl:template>

  <xsl:template match="B|I|U">
    <xsl:element name="{name()}">
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="LINK">
    <xsl:if test="@target">
      <!--Target attribute specified.-->
      <xsl:call-template name="htmLink">
        <xsl:with-param name="dest" select="@target"/>
        <!--Destination = attribute value-->
      </xsl:call-template>
    </xsl:if>

    <xsl:if test="not(@target)">
      <!--Target attribute not specified.-->
      <xsl:call-template name="htmLink">
        <xsl:with-param name="dest">
          <xsl:apply-templates/>
          <!--Destination value = text of node-->
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <!-- A named template that constructs an HTML link -->
  <xsl:template name="htmLink">
    <xsl:param name="dest" select="UNDEFINED"/>
    <!--default value-->
    <xsl:element name="a">
      <xsl:attribute name="href">
        <xsl:value-of select="$dest"/>
        <!--link target-->
      </xsl:attribute>
      <xsl:apply-templates/>
      <!--name of the link from text of node-->
    </xsl:element>
  </xsl:template>

  <xsl:template match="note">
    <p></p>
    <BLOCKQUOTE style="background-color: white; color: #F40000; font-weight:bold; text-align:justify;">
      <xsl:apply-templates />
    </BLOCKQUOTE>
  </xsl:template>

  <xsl:template match="warning">
    <p></p>
        <table align="center" border ="20px" bordercolor ="red" width ="85%">
        <tr>
          <td class="td" style="text-align:justify;">
            <xsl:apply-templates />
          </td>
        </tr>
      </table>    
  </xsl:template>
  <xsl:template match="div">
    <div style="overflow:auto;height:100px;width:400px">
      <xsl:apply-templates />
    </div>
  </xsl:template>
   <xsl:template match="caution">    
    <p></p>    
    <table border ="20px" align="center" bordercolor="#ffc200"  width ="85%">
        <tr>
          <td class="td" style="text-align:justify;">
            <BLOCKQUOTE style="color: red;">            
                <xsl:apply-templates />            
            </BLOCKQUOTE>
          </td>
        </tr>
      </table>    
  </xsl:template>
  <xsl:template match="emphasis">
    <i>
      <xsl:apply-templates/>
    </i>
  </xsl:template>

  <xsl:template match="table">
    <xsl:if test="@border='0'">
      <p></p>
      <TABLE border="0" cellpadding="0" cellspacing="0" width ="90%">
        <!--<xsl:apply-templates select="./title" mode="table"/>
        <xsl:apply-templates select="./tgroup"/>
        <xsl:apply-templates select="./tbody"/>-->
        <xsl:apply-templates/>
      </TABLE>
    </xsl:if>
    <xsl:if test="@frame='box'">
      <p></p>
      <div id="table-container">
      <TABLE frame="box" rules="all" width ="90%" align="center">
        <!--<xsl:apply-templates select="./title" mode="table"/>
        <xsl:apply-templates select="./tgroup"/>
        <xsl:apply-templates select="./tbody"/>-->
       <xsl:apply-templates/>       
      </TABLE>
        <div id="bottom_anchor"></div>
      </div>
    </xsl:if >
  </xsl:template>
  <!--CALS  Table -->
  <!--<xsl:template match="tbody">
    <xsl:variable name="maxColumns">
      <xsl:for-each select="tr">
        <xsl:sort select="sum(td/@colspan) + count(td[not(@colspan)])" data-type="number"/>
        <xsl:if test="position() = last()">
          <xsl:value-of select="sum(td/@colspan) + count(td[not(@colspan)])"/>
        </xsl:if>
       </xsl:for-each>    
    </xsl:variable>
    <tgroup>
      <xsl:attribute name="cols">
        <xsl:value-of select="$maxColumns"/>
        </xsl:attribute>
      <xsl:apply-templates select="@*|node()"/>
    </tgroup>
  </xsl:template>

  <xsl:template match="td[@colspan > 1]">
    <td>
      <xsl:attribute name="namest">
        <xsl:value-of select="sum(preceding-sibling::td/@colspan) + count(preceding-sibling::td[not(@colspan)]) + 1"/>
      </xsl:attribute>
      <xsl:attribute name="nameend">
        <xsl:value-of select="sum(preceding-sibling::td/@colspan) + count(preceding-sibling::td[not(@colspan)]) + @colspan"/>
      </xsl:attribute>
      <xsl:apply-templates select="@*[name() != 'colspan']|node()"/>
      </td>
  </xsl:template>

  <xsl:template match="tr">
    <tr>
      <xsl:apply-templates select="@*|node()"/>
    </tr>
  </xsl:template>

  <xsl:template match="td">
    <td height="25px" class="td">
      <xsl:apply-templates select="@*|node()|figure|br|sub|sup"/>
    </td>
  </xsl:template>

  <xsl:template match="td/@rowspan">
    <xsl:attribute name="morerows">
      <xsl:value-of select=". - 1"/>
    </xsl:attribute> 
  </xsl:template>-->
  
  <xsl:template match="thead">
    <thead style="text-align:justify">
      <xsl:apply-templates select="tr|th|td"/>
    </thead>
  </xsl:template>

  <xsl:template match="th">
    <th class="td" height="5px" style="text-align:justify">
      <xsl:apply-templates select="@*|node()|figure|br|sub|sup|h6|h4"/>
    </th>
  </xsl:template>
  
  <xsl:template match="td">
    <td class="td" height="5px" style="text-align:justify">
      <xsl:apply-templates select="@*|node()|figure|br|sub|sup|h6|h4"/>
    </td>
  </xsl:template>

  <!-- fallback rule -->
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>