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
        <link href="https://fonts.googleapis.com/css?family=Roboto:400,700&amp;display=swap" rel="stylesheet"/>
        <link rel="stylesheet" href="style.css"/>
        <script src="backtotop.js"></script>

      </head>
      <body>
        <header>
          <h1>La Rassegna Settimanale</h1>
        </header>

        <!-- Informazioni sul corpus -->
        <div class="corpus-info">
          <h2><xsl:value-of select="tei:teiCorpus/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/></h2>
          <p>
            <xsl:value-of select="tei:teiCorpus/tei:teiHeader/tei:fileDesc/tei:editionStmt/tei:edition"/>
          </p>
          <p>
            <xsl:value-of select="tei:teiCorpus/tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:publisher"/>,
            <xsl:value-of select="tei:teiCorpus/tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:pubPlace"/>,
            <xsl:value-of select="tei:teiCorpus/tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:date"/>
          </p>

          <xsl:for-each select="//tei:titleStmt/tei:respStmt">
            <div class="resp">
              <p><strong><xsl:value-of select="tei:resp"/></strong></p>
              <ul>
                <xsl:for-each select="tei:persName">
                  <li>
                    <xsl:value-of select="tei:forename"/>
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="tei:surname"/>
                  </li>
                </xsl:for-each>
              </ul>
            </div>
          </xsl:for-each>

        </div>

        <div class="nav">

          <nav id="menu">

            <ul>
             <li><a href="#">ARTICOLI</a>
              <ul id="ul-art">
                <li><a href="#article-1">Corrispondenza da Parigi</a></li>
                <li><a href="#article-2">Lettere militari</a></li>
                <li><a href="#article-3">Don Licciu Papa</a></li>
              </ul>
             </li>  
            
             <li><a href="#">BIBLIOGRAFIA</a>
              <ul id="ul-bibl">
                <li><a href="#article-4">L'Acqua</a></li>
                <li><a href="#article-5">La Psycologie Allemande Contemporaine</a></li>
              </ul>
             </li>  
             
             <li><a href="#">NOTIZIE</a>
              <ul id="ul-not">
                <li><a href="#article-6">Notizie</a></li>
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
                <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type='sub']"/>
              </xsl:if>
            </h2>

            <!-- Fonte -->
            <p class="fonte">
              <b>Fonte:</b>
              <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:bibl/tei:title"/>
              (<xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:bibl/tei:date"/>),
              Volume <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:bibl/tei:biblScope[@unit='volume']"/>,
              Fascicolo <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:bibl/tei:biblScope[@unit='issue']"/>
            </p>

            <!-- testo -->
          <div class="columns">
            
            <xsl:apply-templates select="tei:facsimile"/>
          
            <div class="dx">
                <!-- Testo suddiviso in colonne -->
                <div class="testo colonne" id="text-{position()}">
                  <xsl:apply-templates select="tei:text/tei:body"/>
                  <xsl:apply-templates select="tei:text/tei:back"/>
                </div>
              </div>
           </div>
          </div>
          
          
        </xsl:for-each>
        
        
        <!-- Pulsante Torna su -->
        <div id="legenda">
         <span id="legenda-label">Legenda</span>
         <div id="legenda-content">

          <ul id="leg-list">
            <li>Persone reali</li>
            <li>Personaggi</li>
            <li>Personaggi storici</li>
            <li>Date</li>
            <li>Continenti</li>
            <li>Paesi</li>
            <li>Città</li>
            <li>Regioni amministrative</li>
            <li>Regioni culturali</li>
            <li>Citazioni</li>
            <li>Organizzazioni</li>
            <li>Personaggi mitologici</li>  
          </ul>

         </div>
        </div>
        <button id="back-to-top" title="Torna su">↑</button>
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

  <!-- Template per <back> -->
  <xsl:template match="tei:back">
    <div class="back">
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <!-- Gestione colonne: ogni <cb> apre una nuova colonna -->
    <xsl:template match="tei:cb">
      <xsl:text disable-output-escaping="yes"><![CDATA[</div><div class="colonna">]]></xsl:text>
    </xsl:template>

<!-- Avvia la prima colonna all'inizio del body 
<xsl:template match="tei:body">
  <div class="colonna">
    <xsl:apply-templates/>
  </div>
</xsl:template> -->

  <!-- Gestione immagini -->
  <xsl:template match="tei:facsimile">
    <div class="sx">
      <xsl:for-each select="tei:surface/tei:graphic">
      
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
     
      </xsl:for-each>
    </div>
    
  </xsl:template>

  <!-- Template per la tabella -->
<xsl:template match="tei:table">
  <table border="1" style="border-collapse:collapse; margin:16px 0;">
    <xsl:apply-templates/>
  </table>
</xsl:template>

<!-- Template per le righe -->
<xsl:template match="tei:row">
  <tr>
    <xsl:apply-templates/>
  </tr>
</xsl:template>


<!-- Intestazione -->
<xsl:template match="tei:row[@role='head']">
  <tr>
    <xsl:apply-templates select="tei:cell">
      <xsl:with-param name="header" select="true()"/>
    </xsl:apply-templates>
  </tr>
</xsl:template>

<!-- Celle di intestazione -->
<xsl:template match="tei:cell">
  <xsl:param name="header" select="false()"/>
  <xsl:choose>
    <xsl:when test="$header">
      <th>
        <xsl:apply-templates/>
      </th>
    </xsl:when>
    <xsl:otherwise>
      <td>
        <xsl:apply-templates/>
      </td>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!--template per <hi>-->
<xsl:template match="tei:hi[@rend='italic']">
    <em>
        <xsl:apply-templates/>
    </em>
</xsl:template>

<!-- Template per <hi rend="smallcaps"> -->
<xsl:template match="tei:hi[@rend='smallcap']">
  <i><xsl:apply-templates/></i>
</xsl:template>
  
  <!--template per space-->
  <xsl:template match="tei:space[@dim='horizontal']">
      <span class="indent" style="margin-left:{translate(@extent, ',', '.')}"></span>
  </xsl:template>

  <!-- template per ref -->
  <xsl:template match="tei:ref">
    <a href="{@target}" class="footnote-ref">
      <xsl:apply-templates/>
    </a>
  </xsl:template>
  
  <!-- template per note -->
  <xsl:template match="tei:note">
    <div class="footnote" id="{@xml:id}">
      <sup><xsl:value-of select="@n"/></sup>
      <xsl:apply-templates/>
    </div>
  </xsl:template>



  <!-- Ignora solo pb e cb -->
 <!-- <xsl:template match="tei:pb|tei:cb"/> -->

   <xsl:template match="tei:persName">
    <xsl:choose>
        <!-- Caso 1: personaggio fittizio -->
        <xsl:when test="@type = 'fictional'">
            <span class="entity persName" style="background-color: grey;">
                <xsl:choose>
                    <xsl:when test="@ref">
                        <a href="{@ref}" class="entity-link">
                            <xsl:apply-templates select="node()"/>
                        </a>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates select="node()"/>
                    </xsl:otherwise>
                </xsl:choose>
            </span>
        </xsl:when>

        <!-- Caso 2: personaggio storico -->
        <xsl:when test="@type = 'historical'">
            <span class="entity persName" style="background-color: lightblue;">
                <xsl:choose>
                    <xsl:when test="@ref">
                        <a href="{@ref}" class="entity-link">
                            <xsl:apply-templates select="node()"/>
                        </a>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates select="node()"/>
                    </xsl:otherwise>
                </xsl:choose>
            </span>
        </xsl:when>

        <!-- Caso 3: personaggio mitologico -->
        
        <xsl:when test="@type = 'mythological'">
            <span class="entity persName" style="background-color:  #a39157;">
                <xsl:choose>
                    <xsl:when test="@ref">
                        <a href="{@ref}" class="entity-link">
                            <xsl:apply-templates select="node()"/>
                        </a>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates select="node()"/>
                    </xsl:otherwise>
                </xsl:choose>
            </span>
        </xsl:when>

        <!-- Caso 4: tutti gli altri -->
        <xsl:otherwise>
            <span class="entity persName" id="{@xml:id}" style="background-color: yellow;">
                <xsl:choose>
                    <xsl:when test="@ref">
                        <a href="{@ref}" class="entity-link">
                            <xsl:apply-templates select="node()"/>
                        </a>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates select="node()"/>
                    </xsl:otherwise>
                </xsl:choose>
            </span>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<!-- template per luoghi -->

<xsl:template match="tei:country">
  <span class="entity country" style="background-color: orange">
    <xsl:apply-templates/>
  </span>
</xsl:template>

<xsl:template match="tei:settlement">
  <span class="entity settlement" style="background-color: #00ff1eff;">
    <xsl:apply-templates/>
  </span>
</xsl:template>

<xsl:template match="tei:region">
    <xsl:choose>
        <!-- Caso 1  -->
        <xsl:when test="@type = 'administrative'">
            <span class="entity region" style="background-color: #aa00b0ff;">
                <xsl:choose>
                    <xsl:when test="@ref">
                        <a href="{@ref}" class="entity-link">
                            <xsl:apply-templates select="node()"/>
                        </a>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates select="node()"/>
                    </xsl:otherwise>
                </xsl:choose>
            </span>
        </xsl:when>

        <!-- Caso 2  -->
        <xsl:when test="@type = 'continent'">
            <span class="entity region" style="background-color: pink;">
                <xsl:choose>
                    <xsl:when test="@ref">
                        <a href="{@ref}" class="entity-link">
                            <xsl:apply-templates select="node()"/>
                        </a>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates select="node()"/>
                    </xsl:otherwise>
                </xsl:choose>
            </span>
        </xsl:when>

        <!-- Caso 3  -->
        <xsl:otherwise>
            <span class="entity region" id="{@xml:id}" style="background-color: red;">
                <xsl:choose>
                    <xsl:when test="@ref">
                        <a href="{@ref}" class="entity-link">
                            <xsl:apply-templates select="node()"/>
                        </a>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates select="node()"/>
                    </xsl:otherwise>
                </xsl:choose>
            </span>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<!-- template per citazioni <q> -->
<xsl:template match="tei:q">
  <span class="quote" style="color: blue;">
    <xsl:apply-templates/>
  </span>
</xsl:template>

<!-- template per date  -->
<xsl:template match="tei:date">
  <span class="date" style="background-color: #0c4708ff; color: white">
    <xsl:apply-templates/>
  </span>
</xsl:template>

<!-- template per orgName  -->
<xsl:template match="tei:orgName">
  <span class="date" style="color: red;">
    <xsl:apply-templates/>
  </span>
</xsl:template>

</xsl:stylesheet>
