<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="tei">

  <xsl:output method="html" indent="yes" encoding="UTF-8"/>

  <!-- Template principale -->
  <xsl:template match="/">
    <html xmlns="http://www.w3.org/1999/xhtml">
      <head>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>
          <xsl:value-of select="tei:teiCorpus/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/>
        </title>
        <link rel="stylesheet" href="style.css"/>
      </head>
      <body>
        <header>
          <h1>La Rassegna Settimanale</h1>
        </header>

        <!-- Informazioni sul corpus -->
        <div class="corpus-info">
          <h2><xsl:value-of select="tei:teiCorpus/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/></h2>
          <p><b>Edizione:</b>
            <xsl:value-of select="tei:teiCorpus/tei:teiHeader/tei:fileDesc/tei:editionStmt/tei:edition"/>
          </p>
          <p><b>Pubblicazione:</b>
            <xsl:value-of select="tei:teiCorpus/tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:publisher"/>,
            <xsl:value-of select="tei:teiCorpus/tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:pubPlace"/>,
            <xsl:value-of select="tei:teiCorpus/tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:date"/>
          </p>

        </div>
        <div class="nav">

          <nav id="menu">

            <ul>
             <li>
              <ul id="ul-art">
                <li>Articolo 1</li>
                <li>Articolo 2</li>
                <li>Articolo 3</li>
              </ul>
             </li>  
            
             <li>
              <ul id="ul-bibl">
                <li>bibliografia 1</li>
                <li>bibliografia 2</li>
              </ul>
             </li>  

             <li>
              <ul id="ul-not">
                <li>Notizie</li>
              </ul>
             </li> 

            </ul>

          </nav>

        </div>

        <!-- Itera su ciascun TEI -->
        <xsl:for-each select="tei:teiCorpus/tei:TEI">
          <div class="article" id="article-{position()}">

            <h2 class="title">
              <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/>
              <xsl:if test="tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type='sub']">
                – <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type='sub']"/>
              </xsl:if>
            </h2>

            <!-- Fonte -->
            <p>
              <b>Fonte:</b>
              <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:bibl/tei:title"/>
              (<xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:bibl/tei:date"/>),
              Volume <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:bibl/tei:biblScope[@unit='volume']"/>,
              Fascicolo <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:bibl/tei:biblScope[@unit='issue']"/>
            </p>

            <!-- Immagini -->
            <xsl:apply-templates select="tei:facsimile"/>
          </div>
          <div class="dx">
            <!-- Testo -->
            <div class="testo" id="text-{position()}">
              <xsl:apply-templates select="tei:text/tei:body"/>
            </div>
          </div>
          
        </xsl:for-each>
      </body>
    </html>
  </xsl:template>

  <!-- Trasforma paragrafi -->
  <xsl:template match="tei:p">
    <p><xsl:apply-templates/></p>
  </xsl:template>

  <!-- Titoli interni -->
  <xsl:template match="tei:head">
    <h3><xsl:apply-templates/></h3>
  </xsl:template>

  <!-- Line break -->
  <xsl:template match="tei:lb">
    <br/>
  </xsl:template>

  <!-- Gestione immagini -->
  <xsl:template match="tei:facsimile">
    
      <xsl:for-each select="tei:surface/tei:graphic">
      <div class="sx">
       <div class="immagini" id="imm-{position()}">
        <img>
          <xsl:attribute name="src"><xsl:value-of select="@url"/></xsl:attribute>
          <xsl:if test="@width">
            <xsl:attribute name="width">
              <xsl:value-of select="@width"/>
            </xsl:attribute>
          </xsl:if>
          <xsl:if test="@height">
            <xsl:attribute name="height">
              <xsl:value-of select="@height"/>
            </xsl:attribute>
          </xsl:if>
        </img>
      </div>
     </div>
      </xsl:for-each>
    
  </xsl:template>

  <!-- Ignora solo pb e cb -->
  <xsl:template match="tei:pb|tei:cb"/>

</xsl:stylesheet>
