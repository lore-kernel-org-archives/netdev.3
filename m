Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCC941D131
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 11:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790420755; cv=none; b=s+zzYOLagUrKj7sL3ziD4c7udCxWSgk9qpLaKDU4REsGTBtsxVX5PVcNBBkDlq0XvZojjg6BWV4nFsgLb8qeCkhIJP7gsmUDPNJTHj+/Osq0zb5U/BtHNl4OlST6QYnzCp1zG7FTJC5N5DYHeBWGqVr5RNWfZXZRwTZzNCFV5Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790420755; c=relaxed/simple;
	bh=0KV6yZrMOb34HddcsQaySZL3qBeGcHkwL/KjgerzBiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I7fuhBob/IyJsvUW/U8XwPnnC4KX45zCft8jEb39OzZCiHcZaZzzqQukTz+xuHMpRCdgdFctNCE6qLWHlGKGH3GWje9Pe51ZoCxMaevq2Jl02+eP8FcBTUR6tIBzeXPT0JLWlCC2e8p6DhGhEbbXTCHs2H5xgVSwwimjtN6bV5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SPgs0FXC; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPgs0FXC"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4887f6cf16bso909784f8f.0
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 04:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790420752; x=1791025552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A49IC4jwcPtvEVxNEJzMAk93sgVIidkdmlhwkTx4aBc=;
        b=SPgs0FXC5t7ll3OBwUqk9OiFqUFpZLg9zFOmtHIOtQbgjC+D3AfZtqtYw/HQRlziVa
         wusYstZp3wjqtXTVrcBDYjyiWknpJ6vF6K5sztuOGkTzyoQw8u+UtTKFwSoNOrLjBnW5
         SkgQchNsk2pPu86XeWAL4+Am7nWZ8MBMz+55zqiW+eX9zoFAvxRw0eBxRTCN44W7vmfZ
         EX7qBmJxdZnafmLbfQ5PreH9W6Od9KIDfAm22o4oobKiKwrZxuHSInqPsqODkC19pZHN
         kwhr9MIpM/CEfYfAOIWBKttwdr2UPgSyVWYMQeQITPIiDuNFnSoeh3cmgaEI/JGOCiu0
         /FEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790420752; x=1791025552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A49IC4jwcPtvEVxNEJzMAk93sgVIidkdmlhwkTx4aBc=;
        b=WAvbhc+wRYC9pi4Cfl9Guw9PL+KnX0v+Rc/GuSKBMsb2GZ5d5tW9jJmwQb1o3Jj/s1
         jB/couC7g4iRDcLWZIUBRD7mdRPKaRWhsF/NOvEOSvAUGlyAjqdMGZIQDALcLXSYTAeA
         jM7RrxyeIkP6rlTTkZZOIV7qU30qkpY6mpSuZtfBFOUvoUzYlb1zcf4SdLidBit6Z291
         Uf43LXjke1NCKlBKwsKHlzSN+/ueMcgLGS679efbtPYRKhTQx39+RmsW0ZQoUG6T7uCL
         N+QXbPpP0vPU+9d/rbPneh3kHx35ByI3IouxfpZhw2KRWM3bRBMlyGRhd7d2gc/g/Q5g
         SDJg==
X-Forwarded-Encrypted: i=1; AKwUvBwlzQDwkzKtHMmCIOI8+yDZoieQirncJylce3hcoVs7uaUlbn9P0ODDWVta+o8BNt2gYAhL6Cs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIWykeqi0DVGMzg3/EqiT99Y6sglcRgbIQZFYTQVEL9MRMknQaB
	n6F3p6PQsGVTpHfGnjetknqgglV8T23ALPrya/LPY+XRzTXoo4/ecZjT
X-Gm-Gg: AYBFou3VMKup53MAFLs9LmwCKwJkeopEvM8ukOJ1jBupAjyYfAR2g7iFt4h99pHjxOu
	M32XtHubzd4Txt7tkcs+2z4EYyCrqnUQcJQ0qJX+BLc7b976hyXFPpJPmR6QOpTIV7UoqS7ZBeO
	4QFacOuMDH2KrQSoMRI1/bOGfor/JXnj8WSZTLcze/X1GHV8ypQC1GlYTEK3wpV4vWANy5EO0z3
	wka1O8dSmDN7/McMJrFFqPo2bYpZ1VKMrw3T2OuiDB+dlo94psteGctFRKuXxvZ4J6Sv1mzjyiN
	7Ln7Ii/jjxrJawNjuNUxnj5IzFXrnOOA5vXrR4V+biZuQ8ZqJdlXG00pTz8Y2Nlpyzmn1KTj7uh
	2qVHn4NdgZWxlupGaB/bmpb8Cz+pA5k6UkjkfsPhWtd80FI8tBub1+QpMZQHfZJIG42FFJTBTPO
	nII9yzcbW22VfK1IT3GCFQRXCHhyw4eD/b4/+hhzgx6J57Hmb+FRSHRKNkX1mU4quIowByMIZWD
	ZfL7RBsy2D4FxT2sDqXP4BC/yKmO7XGXTxlVUfklmnQQ9U7I1MlM3a2OcVIyRi2Z8axI5FiR9sP
	wX84tdImTrW7Ldgo6TJhpQ==
X-Received: by 2002:adf:e192:0:b0:485:8c17:9764 with SMTP id ffacd0b85a97d-4887db39ab3mr8077508f8f.38.1790420752005;
        Sat, 26 Sep 2026 04:05:52 -0700 (PDT)
Received: from Lord-Beerus.station ([31.27.155.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a64f795sm12124664f8f.31.2026.09.26.04.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 04:05:51 -0700 (PDT)
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
	Shawn Guo <shawnguo@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Joseph Guo <qijian.guo@nxp.com>,
	Josua Mayer <josua@solid-run.com>,
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
	Mehmet Fide <mehmet.fide@screeningeagle.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Maud Spierings <maudspierings@gocontroll.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH v2 01/11] dt-bindings: arm: fsl: Document Variscite i.MX6UL boards
Date: Sat, 26 Sep 2026 13:05:29 +0200
Message-ID: <2174558b519394111c2cdb7986aafcd6f151c5f3.1790413032.git.stefano.r@variscite.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1790413032.git.stefano.r@variscite.com>
References: <cover.1790413032.git.stefano.r@variscite.com>
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
v1->v2:
 - 

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

