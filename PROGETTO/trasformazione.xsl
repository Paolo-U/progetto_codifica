<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!-- Output in HTML -->
  <xsl:output method="html" indent="yes" encoding="UTF-8"/>

  <!-- Regola principale -->
  <xsl:template match="/teiCorpus">
    <html>
      <head>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>
          <xsl:value-of select="teiHeader/fileDesc/titleStmt/title"/>
        </title>
        <style>
          body { font-family: serif; margin: 2em; }
          h1, h2, h3 { font-family: sans-serif; }
          .corpus-info { margin-bottom: 2em; padding: 1em; background: #f0f0f0; }
          .article { margin-top: 3em; }
        </style>
      </head>
      <body>

        <!-- Informazioni sul corpus -->
        <div class="corpus-info">
          <h1><xsl:value-of select="teiHeader/fileDesc/titleStmt/title"/></h1>
          <p><b>Edizione:</b> <xsl:value-of select="teiHeader/fileDesc/editionStmt/edition"/></p>
          <p><b>Pubblicazione:</b> 
            <xsl:value-of select="teiHeader/fileDesc/publicationStmt/publisher"/>,
            <xsl:value-of select="teiHeader/fileDesc/publicationStmt/pubPlace"/>,
            <xsl:value-of select="teiHeader/fileDesc/publicationStmt/date"/>
          </p>
        </div>

        <!-- Itera su ciascun articolo -->
        <xsl:for-each select="TEI">
          <div class="article">
            <h2>
              <xsl:value-of select="teiHeader/fileDesc/titleStmt/title"/>
              <xsl:if test="teiHeader/fileDesc/titleStmt/title/subtitle">
                – <xsl:value-of select="teiHeader/fileDesc/titleStmt/title/subtitle"/>
              </xsl:if>
            </h2>

            <p>
              <b>Fonte:</b>
              <xsl:value-of select="teiHeader/fileDesc/sourceDesc/bibl/title"/>
              (<xsl:value-of select="teiHeader/fileDesc/sourceDesc/bibl/date"/>),
              Volume <xsl:value-of select="teiHeader/fileDesc/sourceDesc/bibl/biblScope[@unit='volume']"/>,
              Fascicolo <xsl:value-of select="teiHeader/fileDesc/sourceDesc/bibl/biblScope[@unit='issue']"/>
            </p>

            <!-- Corpo del testo -->
            <div class="testo">
              <xsl:apply-templates select="text/body"/>
            </div>
          </div>
        </xsl:for-each>

      </body>
    </html>
  </xsl:template>

  <!-- Trasforma paragrafi -->
  <xsl:template match="p">
    <p><xsl:apply-templates/></p>
  </xsl:template>

  <!-- Titoli interni -->
  <xsl:template match="head">
    <h3><xsl:apply-templates/></h3>
  </xsl:template>

  <!-- Gestione line break -->
  <xsl:template match="lb">
    <br/>
  </xsl:template>

  <!-- Ignora elementi non testuali -->
  <xsl:template match="pb|cb|facsimile|surface|graphic"/>

</xsl:stylesheet>
