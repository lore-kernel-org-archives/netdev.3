Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0D039FCCA
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 12:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790513199; cv=none; b=gbyDcc+Rc4a1vJxgcyif2rlAjn87NIbGQ49ntaifSzRNGUKUkZkmTamD1TSEA2NB3yGQ9U0TU2BaIeqyrEwT9wWyRmh8C+NnT4k9jshzuh/gbK9tadG2p6B1bVZg840fq2l5iJrQf1fh8T/c7znUMgE6gJJFD1pkBf4HPKOJDao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790513199; c=relaxed/simple;
	bh=0w0ZDwJddlnh904r+mRuec6f89Y7DzmrUKJMyuP3GNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bSEWBc6rwIwd7VaL5ZFLer2rvG/vUZiMx3zdvSXxVUC3Kaha6UiK2nUOT0+8F6EXtcKhh+TXxVLCjTGY2kmlOdJwEL4Fd4yAm5pk6GCVejl3wXVurqPxY3clPjPmyob8J747dfZVfZ5aI+2LoMMhiYcRiPPSTriTteohUyKMq/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rYxBWbpo; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rYxBWbpo"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6351831so1221179f8f.1
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 05:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790513194; x=1791117994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UHsv2hT/hhrQYy+V3Qgql/tn3KVUrq4/vMJj+QwfoHI=;
        b=rYxBWbpoK8Q7W9iD33Q41lIKCRdq04EDX23iuj2CFNa/8EH+ozoOLSjN80PzgAKjHV
         y6PpqMVVucoKHE60oc63T6rD5ZUFSjgpq6IGGNcA+DY78/uiE6I/ZyWe9u//d4Sh+pBQ
         mbk/R5aICerF69/iGRSVsgVuwx85BrlNsl3/Q7tyqbBA/Wabg2LXui5gnJZGu6y14DpK
         C4tIQfG9yQCCYkA//i5Fo9KiAwTBlLvbSE6DkoHA7gkxIJUhgtac1iAjEi5xS1bg4CbH
         qh9MrT/BvOEbFQsb7xnzePiOTtifF1F0BLtrxBrO4lVIrsJKyquZpmcFQ2ngnwcdqLFG
         fe8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790513194; x=1791117994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UHsv2hT/hhrQYy+V3Qgql/tn3KVUrq4/vMJj+QwfoHI=;
        b=0b8aEdo2BHUOf2ayedDTxydr8v8G5jtpK8pKuNQK1LYs7XC8Ind+fiGgmWx9MkkaWG
         czEwWzf9AwNiu9jJJsuR97CqEfBCvXb2wa8DBn9OJbG5ZaK7S6sK4xpeK6TjWota9+eR
         yAOeHN5kfklmDgDC/ceCmsWW+LwPLYAg9pfj/IlvHwQTiMepMprbFbaKVHWNpLkOfCOk
         VZtCTzQZELR8Rsn5+gkovyz1Ko2aQCGpee5HfGOXl/chZn5dE6xnbwCQc3enaX3+uCi7
         gAmKm4Lk/kUtzeFB4nFMK30BBtXxA8bx902h0hNHaABVINl6sZ287ZD/ihX6iICEAiht
         Zp9w==
X-Forwarded-Encrypted: i=1; AKwUvBwNBAPiLZJvC86b3Sw5V/C2Zzy6JYcNwY32NSM/biC+Yf3f/kYYV1vXXXAgAeWr7n0FmOwxbtA=@vger.kernel.org
X-Gm-Message-State: AFuF++lEvdHPCuBpLC/erdYlCIGF5gIdZBw8FzH02OP8dABGLnjPY/2G
	nGMhWBOKa3vvSwVoZxNxzQ136nleH9dY3REsQ1aiTGURW4fdazyWlbeW
X-Gm-Gg: AYBFou00cMwZMxIacJvPG+KRLJXUsHOermlCHxHl6sjcncwIFav6eoEEWVCbSymgXqn
	I2NT5jaJuYgUTJmQKw70LHM5icrCZ9HOQbjEDqUXYq0puBT8y4o0mpF1ZrhYv238w6w26avLu/u
	4oeJY9N97QbRM5d8tqhLlnaLU4PeYOpr49ngqjLPvzJZByp2QP/TMymdvO9Y9g/K7f/+mKifuDc
	h3jddogb4/PLzjBWGdC69Mck/0ojlPAQnmk7a29ChA86WX+D/gWHWCgI/A+5oB2i9mUxRCagVhp
	6tSSfTtb7/jL25WwG7cUxmaj0zopV0soiL8qXO7SGs11RvhX8D0YbcY1xwyhkUPcrBuvN2meiSY
	/0R1ycqqjHGPlKgeXVW1f9NIm8KAh2NHYYZBVuV8tokvCkNtuXe4TXXyl3yqTTXkDYS473pzsif
	Vku5dtDqdFHi7gZG1dMLEj1ZyUw0ktlNMzrIBdgfAMxABwjtB/ndROYVKyWdFRV50Zc/y2/KKm2
	FphzbWobGnW7mpgIetnrVg48fC5GZ/WTd4yf30OVRdDCRbD8uG5JAWbg3jbzVW4Z2Q912HzlTl0
	/dEcPnsH7rijcpPGno/o8A==
X-Received: by 2002:a05:600c:1c21:b0:4a0:2dd:7573 with SMTP id 5b1f17b1804b1-4a002dd77demr20084135e9.33.1790513193690;
        Sun, 27 Sep 2026 05:46:33 -0700 (PDT)
Received: from Lord-Beerus.station ([31.27.155.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fef60da94sm148440605e9.4.2026.09.27.05.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 05:46:33 -0700 (PDT)
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
X-Google-Original-From: Stefano Radaelli <stefano.r@variscite.com>
To: Frank Li <Frank.Li@nxp.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: pierluigi.p@variscite.com,
	Stefano Radaelli <stefano.r@variscite.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Shawn Guo <shawnguo@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Joseph Guo <qijian.guo@nxp.com>,
	Josua Mayer <josua@solid-run.com>,
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
	Mehmet Fide <mehmet.fide@screeningeagle.com>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Maud Spierings <maudspierings@gocontroll.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH v3 01/12] dt-bindings: arm: fsl: Document Variscite i.MX6UL boards
Date: Sun, 27 Sep 2026 14:46:16 +0200
Message-ID: <a4e262cfb08153c23c80cd3098a684816993f1e9.1790512621.git.stefano.r@variscite.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1790512621.git.stefano.r@variscite.com>
References: <cover.1790512621.git.stefano.r@variscite.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Radaelli <stefano.r@variscite.com>

Document the existing VAR-SOM-6UL Concerto compatibles and the new
VAR-SOM-6UL and DART-6UL board variants based on i.MX6UL, i.MX6ULL
and i.MX6ULZ.

Add specific compatibles for the storage, wireless, audio and
carrier combinations while retaining the legacy Concerto strings.

Signed-off-by: Stefano Radaelli <stefano.r@variscite.com>
---
 .../devicetree/bindings/arm/fsl.yaml          | 148 ++++++++++++++++--
 1 file changed, 138 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 36e28e0e4ad9..726d563d1482 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -688,11 +688,51 @@ properties:
           - const: phytec,imx6ul-pcl063   # PHYTEC phyCORE-i.MX 6UL
           - const: fsl,imx6ul
 
-      - description: i.MX6UL Variscite VAR-SOM-6UL Boards
-        items:
-          - const: variscite,mx6ulconcerto
-          - const: variscite,var-som-imx6ul
-          - const: fsl,imx6ul
+      - description: i.MX6UL Variscite VAR-SOM-6UL and DART-6UL Boards
+        oneOf:
+          - items:
+              - enum:
+                  - variscite,mx6ulconcerto
+                  - variscite,var-som-imx6ul-emmc-sd-card-wm8731-concerto-board
+                  - variscite,var-som-imx6ul-emmc-sd-card-concerto-board
+                  - variscite,var-som-imx6ul-emmc-wifi-brcm-wm8731-concerto-board
+                  - variscite,var-som-imx6ul-emmc-wifi-brcm-concerto-board
+                  - variscite,var-som-imx6ul-emmc-wifi-iw61x-concerto-board
+                  - variscite,var-som-imx6ul-nand-sd-card-wm8731-concerto-board
+                  - variscite,var-som-imx6ul-nand-sd-card-concerto-board
+                  - variscite,var-som-imx6ul-nand-wifi-brcm-wm8731-concerto-board
+                  - variscite,var-som-imx6ul-nand-wifi-brcm-concerto-board
+                  - variscite,var-som-imx6ul-nand-wifi-iw61x-concerto-board
+              - const: variscite,var-som-imx6ul
+              - const: fsl,imx6ul
+          - items:
+              - enum:
+                  - variscite,var-som-imx6ul-emmc-sd-card-wm8731-symphony-board
+                  - variscite,var-som-imx6ul-emmc-sd-card-symphony-board
+                  - variscite,var-som-imx6ul-emmc-wifi-brcm-wm8731-symphony-board
+                  - variscite,var-som-imx6ul-emmc-wifi-brcm-symphony-board
+                  - variscite,var-som-imx6ul-emmc-wifi-iw61x-symphony-board
+                  - variscite,var-som-imx6ul-nand-sd-card-wm8731-symphony-board
+                  - variscite,var-som-imx6ul-nand-sd-card-symphony-board
+                  - variscite,var-som-imx6ul-nand-wifi-brcm-wm8731-symphony-board
+                  - variscite,var-som-imx6ul-nand-wifi-brcm-symphony-board
+                  - variscite,var-som-imx6ul-nand-wifi-iw61x-symphony-board
+              - const: variscite,var-som-imx6ul
+              - const: fsl,imx6ul
+          - items:
+              - enum:
+                  - variscite,dart-6ul-imx6ul-emmc-sd-card-wm8731-6ulcustomboard
+                  - variscite,dart-6ul-imx6ul-emmc-sd-card-6ulcustomboard
+                  - variscite,dart-6ul-imx6ul-emmc-wifi-brcm-wm8731-6ulcustomboard
+                  - variscite,dart-6ul-imx6ul-emmc-wifi-brcm-6ulcustomboard
+                  - variscite,dart-6ul-imx6ul-emmc-wifi-iw61x-6ulcustomboard
+                  - variscite,dart-6ul-imx6ul-nand-sd-card-wm8731-6ulcustomboard
+                  - variscite,dart-6ul-imx6ul-nand-sd-card-6ulcustomboard
+                  - variscite,dart-6ul-imx6ul-nand-wifi-brcm-wm8731-6ulcustomboard
+                  - variscite,dart-6ul-imx6ul-nand-wifi-brcm-6ulcustomboard
+                  - variscite,dart-6ul-imx6ul-nand-wifi-iw61x-6ulcustomboard
+              - const: variscite,dart-6ul-imx6ul
+              - const: fsl,imx6ul
 
       - description: Kontron BL i.MX6UL (N631X S) Board
         items:
@@ -797,11 +837,51 @@ properties:
           - const: phytec,imx6ull-pcl063        # PHYTEC phyCORE-i.MX 6ULL
           - const: fsl,imx6ull
 
-      - description: i.MX6ULL Variscite VAR-SOM-6UL Boards
-        items:
-          - const: variscite,mx6ullconcerto  # Variscite VAR-SOM-6UL dev kit board
-          - const: variscite,var-som-imx6ull # Variscite VAR-SOM-6UL SoM (6ULL variant)
-          - const: fsl,imx6ull
+      - description: i.MX6ULL Variscite VAR-SOM-6UL and DART-6UL Boards
+        oneOf:
+          - items:
+              - enum:
+                  - variscite,mx6ullconcerto
+                  - variscite,var-som-imx6ull-emmc-sd-card-wm8731-concerto-board
+                  - variscite,var-som-imx6ull-emmc-sd-card-concerto-board
+                  - variscite,var-som-imx6ull-emmc-wifi-brcm-wm8731-concerto-board
+                  - variscite,var-som-imx6ull-emmc-wifi-brcm-concerto-board
+                  - variscite,var-som-imx6ull-emmc-wifi-iw61x-concerto-board
+                  - variscite,var-som-imx6ull-nand-sd-card-wm8731-concerto-board
+                  - variscite,var-som-imx6ull-nand-sd-card-concerto-board
+                  - variscite,var-som-imx6ull-nand-wifi-brcm-wm8731-concerto-board
+                  - variscite,var-som-imx6ull-nand-wifi-brcm-concerto-board
+                  - variscite,var-som-imx6ull-nand-wifi-iw61x-concerto-board
+              - const: variscite,var-som-imx6ull
+              - const: fsl,imx6ull
+          - items:
+              - enum:
+                  - variscite,var-som-imx6ull-emmc-sd-card-wm8731-symphony-board
+                  - variscite,var-som-imx6ull-emmc-sd-card-symphony-board
+                  - variscite,var-som-imx6ull-emmc-wifi-brcm-wm8731-symphony-board
+                  - variscite,var-som-imx6ull-emmc-wifi-brcm-symphony-board
+                  - variscite,var-som-imx6ull-emmc-wifi-iw61x-symphony-board
+                  - variscite,var-som-imx6ull-nand-sd-card-wm8731-symphony-board
+                  - variscite,var-som-imx6ull-nand-sd-card-symphony-board
+                  - variscite,var-som-imx6ull-nand-wifi-brcm-wm8731-symphony-board
+                  - variscite,var-som-imx6ull-nand-wifi-brcm-symphony-board
+                  - variscite,var-som-imx6ull-nand-wifi-iw61x-symphony-board
+              - const: variscite,var-som-imx6ull
+              - const: fsl,imx6ull
+          - items:
+              - enum:
+                  - variscite,dart-6ul-imx6ull-emmc-sd-card-wm8731-6ulcustomboard
+                  - variscite,dart-6ul-imx6ull-emmc-sd-card-6ulcustomboard
+                  - variscite,dart-6ul-imx6ull-emmc-wifi-brcm-wm8731-6ulcustomboard
+                  - variscite,dart-6ul-imx6ull-emmc-wifi-brcm-6ulcustomboard
+                  - variscite,dart-6ul-imx6ull-emmc-wifi-iw61x-6ulcustomboard
+                  - variscite,dart-6ul-imx6ull-nand-sd-card-wm8731-6ulcustomboard
+                  - variscite,dart-6ul-imx6ull-nand-sd-card-6ulcustomboard
+                  - variscite,dart-6ul-imx6ull-nand-wifi-brcm-wm8731-6ulcustomboard
+                  - variscite,dart-6ul-imx6ull-nand-wifi-brcm-6ulcustomboard
+                  - variscite,dart-6ul-imx6ull-nand-wifi-iw61x-6ulcustomboard
+              - const: variscite,dart-6ul-imx6ull
+              - const: fsl,imx6ull
 
       - description: i.MX6ULL Boards with Toradex Colibri iMX6ULL Modules
         items:
@@ -870,6 +950,54 @@ properties:
           - const: fsl,imx6ull # This seems odd. Should be last?
           - const: fsl,imx6ulz
 
+      - description: i.MX6ULZ Variscite VAR-SOM-6UL and DART-6UL Boards
+        oneOf:
+          - items:
+              - enum:
+                  - variscite,var-som-imx6ulz-emmc-sd-card-wm8731-concerto-board
+                  - variscite,var-som-imx6ulz-emmc-sd-card-concerto-board
+                  - variscite,var-som-imx6ulz-emmc-wifi-brcm-wm8731-concerto-board
+                  - variscite,var-som-imx6ulz-emmc-wifi-brcm-concerto-board
+                  - variscite,var-som-imx6ulz-emmc-wifi-iw61x-concerto-board
+                  - variscite,var-som-imx6ulz-nand-sd-card-wm8731-concerto-board
+                  - variscite,var-som-imx6ulz-nand-sd-card-concerto-board
+                  - variscite,var-som-imx6ulz-nand-wifi-brcm-wm8731-concerto-board
+                  - variscite,var-som-imx6ulz-nand-wifi-brcm-concerto-board
+                  - variscite,var-som-imx6ulz-nand-wifi-iw61x-concerto-board
+              - const: variscite,var-som-imx6ulz
+              - const: fsl,imx6ull
+              - const: fsl,imx6ulz
+          - items:
+              - enum:
+                  - variscite,var-som-imx6ulz-emmc-sd-card-wm8731-symphony-board
+                  - variscite,var-som-imx6ulz-emmc-sd-card-symphony-board
+                  - variscite,var-som-imx6ulz-emmc-wifi-brcm-wm8731-symphony-board
+                  - variscite,var-som-imx6ulz-emmc-wifi-brcm-symphony-board
+                  - variscite,var-som-imx6ulz-emmc-wifi-iw61x-symphony-board
+                  - variscite,var-som-imx6ulz-nand-sd-card-wm8731-symphony-board
+                  - variscite,var-som-imx6ulz-nand-sd-card-symphony-board
+                  - variscite,var-som-imx6ulz-nand-wifi-brcm-wm8731-symphony-board
+                  - variscite,var-som-imx6ulz-nand-wifi-brcm-symphony-board
+                  - variscite,var-som-imx6ulz-nand-wifi-iw61x-symphony-board
+              - const: variscite,var-som-imx6ulz
+              - const: fsl,imx6ull
+              - const: fsl,imx6ulz
+          - items:
+              - enum:
+                  - variscite,dart-6ul-imx6ulz-emmc-sd-card-wm8731-6ulcustomboard
+                  - variscite,dart-6ul-imx6ulz-emmc-sd-card-6ulcustomboard
+                  - variscite,dart-6ul-imx6ulz-emmc-wifi-brcm-wm8731-6ulcustomboard
+                  - variscite,dart-6ul-imx6ulz-emmc-wifi-brcm-6ulcustomboard
+                  - variscite,dart-6ul-imx6ulz-emmc-wifi-iw61x-6ulcustomboard
+                  - variscite,dart-6ul-imx6ulz-nand-sd-card-wm8731-6ulcustomboard
+                  - variscite,dart-6ul-imx6ulz-nand-sd-card-6ulcustomboard
+                  - variscite,dart-6ul-imx6ulz-nand-wifi-brcm-wm8731-6ulcustomboard
+                  - variscite,dart-6ul-imx6ulz-nand-wifi-brcm-6ulcustomboard
+                  - variscite,dart-6ul-imx6ulz-nand-wifi-iw61x-6ulcustomboard
+              - const: variscite,dart-6ul-imx6ulz
+              - const: fsl,imx6ull
+              - const: fsl,imx6ulz
+
       - description: i.MX7S based Boards
         items:
           - enum:
-- 
2.47.3
