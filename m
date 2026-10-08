Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51043D0910
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 19:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791488422; cv=none; b=Ak2M+73gUmKmrv8bFqYOm15lAi4NzrlxZIukaqaClvTrwzk/dq/ULYvyryUApP46MyMiVGcKWC4ZUtx4HX5XPWqHpo7RfxMtD4e1m2tI7aKpgeewFViXBJWOExoylkJzQON5guZAw288DFyWdYz3IKTsBoeFZfFuSuasAeabQOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791488422; c=relaxed/simple;
	bh=XjUNeeMRC2ts5MdmKtrm3eVb5N5Z36fM2sJ8EfZSQaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qmRBUIO8bSAs1lcLDUrFdG1R4tEDApIquF5o3M8nCCRvk81e7o3jLRKt0BrfsslHuBBFHm7Mprwe/Rpa1NnLsCvZSvAvzmqGpdRtHzrxqB1z7Jay8gkqYQxxDnawOG3tOFrkplT5A+KAGyN5XSyfqJ//zQD/i1Gt6b9sPbWygak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sUvRH08f; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sUvRH08f"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso58241995e9.3
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 12:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791488416; x=1792093216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jf168IjSFgOfzHnEoVof5QzOtPwLIXW0PLzbFbqRkiE=;
        b=sUvRH08fjMys9bYnFAMAAN7wMBwgH7EPTZC+tIaqL3HGTrB/ptx3r3BT/DTvOO92fV
         u6IZW9n0/7YMONgNqjMR1p1pK2G9z7sVfDrjoHhJ5rlwnk+xR5EeShIEFbd2pKoSurA2
         nbeBlOpr1rZ8QrwsdH2pxlQFXh4kQAjSV0t2AW9tQAdizSOVThuY6iCB9Tmapez2Fkd0
         IfchSmE5mAA+cU4Sfu9OG7sttyLgLvS8XBp+tFl86u84JekAuu4QpasU58e14zCtp8oe
         cHkQM8DldEUZbgBkmb/EP409lpNVfLLOu09M02IQJE9qUlbA0AnVefYSNRyVH3F7SjYy
         cR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791488416; x=1792093216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jf168IjSFgOfzHnEoVof5QzOtPwLIXW0PLzbFbqRkiE=;
        b=xXPVUfkQE9tEY13JkCfe+6IFzYvLZD8RQJJn/JWiWEfBKNLIV+Nsn5jZeurFsE9DrU
         WPSGVNk+kYCJzu1cxMwc1bqotKX9i/9x+frOzMR9dEQXJKKHImGzYPPLrWBNJYknFrX2
         jk0eFCxLok3KRAHLU8Df+jmkSB+9Ly4D+EoOgUCmVkuKm9pNJAeN2bfsRtgOOWYdzOd4
         W8oP3cRAz4g80Q1Be/6G8R4hnSuMPMsGiJxyHOZ6D7xtB86qTYWjdUQPdI7/kwkApD2h
         sUJnyjIGW70OU7s3c3l2EOk/BfCq6CUMq/5QtlCGkGNOxfMwSRYmMXg932mpZFOPCidI
         zD8g==
X-Forwarded-Encrypted: i=1; AKwUvBxmshAumJZVMEpTzcXuuQzp75f5iDmxCS3HGvrSUNawhew/ej6epGWlzpDdm9lAsOczq8G31Dk=@vger.kernel.org
X-Gm-Message-State: AFuF++nZOlgM+7Hg+bU4wdXd8k8A2+kY4d826AqCkE7FPsDZUc+aVRAA
	kBzq/UXw+rCSC+Da+4iz4IRaQLWl+RI2gOkPVL4fi7h/dQQM5fN6qo2N
X-Gm-Gg: AYBFou1Jt23Ji2mFzbsqpyox9Ved9AhbYNlwMjTGJCzy4+xfxsr2PY+xJ/HEmbrvwqx
	NnSRUsWjCV3EehJOPeNAS6SQMqVKz64BQbGw9yj+OFDlZjzGu5rp6W6+YrA9lnsOE9EGsOjl/w6
	Ieohw2GrqU4EfGeFHlZMeXQJ/C6O09fVsJuaNQoCpyFBb1wjZZAc8QnjZTZxxu9+pxwBOXKZyQ9
	zjXedB0lxzc8qLyLZzRuszNigaLbgzDdBJwsGV2JdX4DcqEgYhOWgXnSQWwWd6heE5ypK3cJzar
	LDqi7vODGEcWhH57MZL5e5KvO9HkFa/na7WeSV5oTmVFfCaB/r1BEOK1eQn1RImD/e/4udlEztq
	bHcYPdmi8ZUMiBYDGJ8so7x6nFcRkCL/5zEvWtPRIobJoSdfjj3ltEatFqgsDPkjjllrW+rV2G1
	qLpm8xX+N3Jgz4DmxIFDFU542iuLa5Dx7pILbxvNFR9aOqLLMsLXTO96WNO4e9OaqgugPByXT/O
	4hF9qjrR3XPR8RWNVWeJX5QlZuq273kDNn5c+HuDbLtYNlISKYAprg9zRmZtCdcsF6/wPZOlxl8
	UCuSHpkiOvclU+KDmXTHkw==
X-Received: by 2002:a05:600c:8b09:b0:4a1:7ce1:2eaf with SMTP id 5b1f17b1804b1-4a180682d24mr123505435e9.34.1791488415898;
        Thu, 08 Oct 2026 12:40:15 -0700 (PDT)
Received: from Lord-Beerus.station ([31.27.155.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18c1e33d2sm1419065e9.0.2026.10.08.12.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 12:40:15 -0700 (PDT)
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
	Joseph Guo <qijian.guo@nxp.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Josua Mayer <josua@solid-run.com>,
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
	Mehmet Fide <mehmet.fide@screeningeagle.com>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Maud Spierings <maudspierings@gocontroll.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	netdev@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v5 01/13] dt-bindings: arm: fsl: Add Variscite i.MX6UL board variants
Date: Thu,  8 Oct 2026 21:37:41 +0200
Message-ID: <4ea26fb755799e279e195b3f8b8669c394a7f7b1.1791487179.git.stefano.r@variscite.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1791487179.git.stefano.r@variscite.com>
References: <cover.1791487179.git.stefano.r@variscite.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Radaelli <stefano.r@variscite.com>

Document new VAR-SOM-6UL configurations on the already supported
Concerto carrier while retaining its legacy compatible. Add
VAR-SOM-6UL variants on Symphony and DART-6UL variants on
VAR-6ULCustomBoard.

The new compatibles identify the SoM storage, wireless and audio
options followed by the carrier, module and SoC compatibles.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Stefano Radaelli <stefano.r@variscite.com>
---
v4->v5:
 - Collect Krzysztof Kozlowski's Reviewed-by; no binding changes.

v3->v4:
 - Split the board binding by SoC, extend the existing VAR-SOM-6UL
   entry with new Concerto and Symphony variants, and add DART-6UL.
 - Drop the redundant -board suffix from the new carrier compatibles
   and use sorted items/enum lists.

 .../devicetree/bindings/arm/fsl.yaml          | 39 ++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index c8290a83205b..f044f6fce51f 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -689,9 +689,46 @@ properties:
           - const: phytec,imx6ul-pcl063   # PHYTEC phyCORE-i.MX 6UL
           - const: fsl,imx6ul
 
+      - description: i.MX6UL Variscite DART-6UL board variants
+        items:
+          - enum:
+              - variscite,dart-6ul-imx6ul-emmc-sd-card-6ulcustomboard
+              - variscite,dart-6ul-imx6ul-emmc-sd-card-wm8731-6ulcustomboard
+              - variscite,dart-6ul-imx6ul-emmc-wifi-brcm-6ulcustomboard
+              - variscite,dart-6ul-imx6ul-emmc-wifi-brcm-wm8731-6ulcustomboard
+              - variscite,dart-6ul-imx6ul-emmc-wifi-iw61x-6ulcustomboard
+              - variscite,dart-6ul-imx6ul-nand-sd-card-6ulcustomboard
+              - variscite,dart-6ul-imx6ul-nand-sd-card-wm8731-6ulcustomboard
+              - variscite,dart-6ul-imx6ul-nand-wifi-brcm-6ulcustomboard
+              - variscite,dart-6ul-imx6ul-nand-wifi-brcm-wm8731-6ulcustomboard
+              - variscite,dart-6ul-imx6ul-nand-wifi-iw61x-6ulcustomboard
+          - const: variscite,dart-6ul-imx6ul
+          - const: fsl,imx6ul
+
       - description: i.MX6UL Variscite VAR-SOM-6UL Boards
         items:
-          - const: variscite,mx6ulconcerto
+          - enum:
+              - variscite,mx6ulconcerto
+              - variscite,var-som-imx6ul-emmc-sd-card-concerto
+              - variscite,var-som-imx6ul-emmc-sd-card-symphony
+              - variscite,var-som-imx6ul-emmc-sd-card-wm8731-concerto
+              - variscite,var-som-imx6ul-emmc-sd-card-wm8731-symphony
+              - variscite,var-som-imx6ul-emmc-wifi-brcm-concerto
+              - variscite,var-som-imx6ul-emmc-wifi-brcm-symphony
+              - variscite,var-som-imx6ul-emmc-wifi-brcm-wm8731-concerto
+              - variscite,var-som-imx6ul-emmc-wifi-brcm-wm8731-symphony
+              - variscite,var-som-imx6ul-emmc-wifi-iw61x-concerto
+              - variscite,var-som-imx6ul-emmc-wifi-iw61x-symphony
+              - variscite,var-som-imx6ul-nand-sd-card-concerto
+              - variscite,var-som-imx6ul-nand-sd-card-symphony
+              - variscite,var-som-imx6ul-nand-sd-card-wm8731-concerto
+              - variscite,var-som-imx6ul-nand-sd-card-wm8731-symphony
+              - variscite,var-som-imx6ul-nand-wifi-brcm-concerto
+              - variscite,var-som-imx6ul-nand-wifi-brcm-symphony
+              - variscite,var-som-imx6ul-nand-wifi-brcm-wm8731-concerto
+              - variscite,var-som-imx6ul-nand-wifi-brcm-wm8731-symphony
+              - variscite,var-som-imx6ul-nand-wifi-iw61x-concerto
+              - variscite,var-som-imx6ul-nand-wifi-iw61x-symphony
           - const: variscite,var-som-imx6ul
           - const: fsl,imx6ul
 
-- 
2.47.3

