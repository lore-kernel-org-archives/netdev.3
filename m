Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B094EFFDD
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 19:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791488427; cv=none; b=Q3Rq856UZ+yBYel4pBW6LvQh2WHu7biNT95RkI7kypuh6/mA/csoUa1AmiiaQlt4IKHsy9iBpT7fs0L2F7C3beo7zW9sNSOLKbpnwB43qAdmaQlkUit6BrnHocfoWGwDnATe0GtMgt8MX3GXKzyAmlt12kXupWpBjisQ2if6iko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791488427; c=relaxed/simple;
	bh=JAOMxI61QC8KPKmV82fMgcEzMe1b7vaB9yj/4Lg5yhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o1UBrxJ+JcG4LuZRKwRQ3U0HfwP93ioSZcOOjV004I//UzNNsEEwgOtCIKNGItdCn79OmuoeI+rnov0ShecXLHslNzB5bv5PQp+q8YI+kLQrWqVlVZ3HfleA/RSL3GWsSNPTCDOd5hRHiIKG+FV20nCgsMZwc/+MLe1lYMgU/Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1Ba1GLg; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1Ba1GLg"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a16aaf2067so65008565e9.0
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 12:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791488420; x=1792093220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=23uKYxmoySlp6REJxlYJvE+Uk9Vl3V7y8fMNqG3cHos=;
        b=P1Ba1GLgTDRNMSdoAxRlDdOy6+mzuwKV5EhN0DzYSHvtDYgW3DAQD2CBd6UBhc9MZk
         QnzeeftQTaAJ0x1WUtZ8ia9/oyBaqFAK2OxpV4sJxJov+t6+li2Asg/cAyeaIs9U5rpx
         NCcJ0Cg1vDIeJo04nCLtJt7c3bpiiEcfL2Z3/G47SnUl9FNP5OfwJK41i7ynOqzzIyyl
         5F/XkB2Hq4JRg02aet9LimRIYe8pFyQvHRpzNO4CSfxb2s4Uwy3+cfNvUQVqmo6bRFfy
         9jZIe1ddsjTanN/FKu8WXbYd5k/dyFDbXhDO0rEPLek/qBGwXm81KWHWjUV4GyfanWi6
         leww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791488420; x=1792093220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=23uKYxmoySlp6REJxlYJvE+Uk9Vl3V7y8fMNqG3cHos=;
        b=CyHCMQBs/edlEjMbze8x6yFn+OzLIHUr1qLUo73JiBKqU3ye88/iEENEN/k2ciW7Oo
         misOxAmzoS2vNFKyGdXY2D8lNyFYGoZv8/FtCQ9jUqOGaom3d4OhIE1PHymhOLS7O308
         rVQC4bvoNDg2MQb4K1cHXQz8QoPfjJYyI0BYdhXu0X6XHfzUfNqPJ+guJ2iHdXPzXte8
         IwNKqWCvaYMg1QZkY/+rMO/gRqPscqf8HvidPtNf7MI4AOGBB9VXB23wckfvp+0BjRV9
         3WuszzbVGs5sguNBYmY8Q1e48uxyC5PCobMqfSpjVC1q7RcngiOOX+sj1uUNIR87VY/l
         KcTw==
X-Forwarded-Encrypted: i=1; AKwUvBwWAWkALKCUByH4ysUg0RfLIeP+hdo2dXUbh8YyBT5hfbB433LMoo9/IYSa1TzKeSvCu/7u9Lc=@vger.kernel.org
X-Gm-Message-State: AFuF++ktcr48WbZUBqmouOuo9y6Vvf//I1i2bNXhWV/P1iIBW2VQ+2B+
	3zkBDwIP6WYBKCJjwoUm3dtesl+8ryVHmmjZmnqBTvjOnSWX5H2NjXlO
X-Gm-Gg: AYBFou3XgXG6R1C1RNLcuoeZH4JAJBnyJiNavTBIh4VoV6ogw9/ukzIFO9ik+V1tkC9
	0VI1nPNZJ7cHMyRgF0fX7bIZBd6iBaJ7A54Q+m9t/vyPB+OV0HDBhFotC7eBcH8zBaTPZTPm39I
	aGzXm7U1aCINeqhYu7XGbNeUSZoIHykgthHQyCbNlVECNRuHM9XyO08HoN8arlzdPzTi3TIaMKO
	uf31CFoQGwDEk+aAF4yhR53oBhUncXS9CO54t+T6kA534fU85QwJonUMcgLA2LYwIhYg/JTiES3
	yNjUdNMyCfqJ4RC0F6qYlPDFz2VpuPHSt/fD3u0T4eh/MsbFG4HuxE5aHCHACBC979IjMBr6hBz
	/BhnFcuQ6EUos4e6fcIFCXlrLr9cs1pAx04Al0Qm+FTPHPOtV+mPHJy0TrJVm1am18+exs+xxZe
	oBckvAgcRjnp8AMKskzkOoZ/s5OC6HSY1IKXVyckCnomtw6m+zmxVorz31xPDSS8flpyMrz26QQ
	5fdtTQtUKYc8UT7D5vrHNmuBOBqxobIVJCoqc6t/F4a/06AnsZ8VXrDb+QkDnrJBqX8+IlgJYpt
	8q7WNzqXTlUCflsiGdG68aQBTrmQV6KyKA==
X-Received: by 2002:a05:600c:609a:b0:4a0:2540:b46 with SMTP id 5b1f17b1804b1-4a18031130emr114964675e9.12.1791488419663;
        Thu, 08 Oct 2026 12:40:19 -0700 (PDT)
Received: from Lord-Beerus.station ([31.27.155.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18c1e33d2sm1419065e9.0.2026.10.08.12.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 12:40:19 -0700 (PDT)
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
	netdev@vger.kernel.org
Subject: [PATCH v5 03/13] dt-bindings: arm: fsl: Add Variscite i.MX6ULZ board variants
Date: Thu,  8 Oct 2026 21:37:43 +0200
Message-ID: <cb2311ceda0efe83d2a05d2d0488d547043b1d47.1791487179.git.stefano.r@variscite.com>
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

Document VAR-SOM-6UL configurations on the Concerto and Symphony
carriers and DART-6UL configurations on VAR-6ULCustomBoard with
i.MX6ULZ.

The compatibles identify the SoM storage, wireless and audio options
followed by the carrier, module and SoC compatibles.

Signed-off-by: Stefano Radaelli <stefano.r@variscite.com>
---
v4->v5:
 - Put fsl,imx6ulz before the fsl,imx6ull fallback in the new Variscite
   entries. Leave the existing EVK and BSH compatible order unchanged.

v3->v4:
 - Split the board binding by SoC and add separate VAR-SOM-6UL and
   DART-6UL entries for i.MX6ULZ.
 - Drop the redundant -board suffix from new Concerto and Symphony
   compatibles and use sorted items/enum lists.

 .../devicetree/bindings/arm/fsl.yaml          | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index ca6778b8777f..d75a08cc11cf 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -945,6 +945,50 @@ properties:
           - const: fsl,imx6ull # This seems odd. Should be last?
           - const: fsl,imx6ulz
 
+      - description: i.MX6ULZ Variscite DART-6UL board variants
+        items:
+          - enum:
+              - variscite,dart-6ul-imx6ulz-emmc-sd-card-6ulcustomboard
+              - variscite,dart-6ul-imx6ulz-emmc-sd-card-wm8731-6ulcustomboard
+              - variscite,dart-6ul-imx6ulz-emmc-wifi-brcm-6ulcustomboard
+              - variscite,dart-6ul-imx6ulz-emmc-wifi-brcm-wm8731-6ulcustomboard
+              - variscite,dart-6ul-imx6ulz-emmc-wifi-iw61x-6ulcustomboard
+              - variscite,dart-6ul-imx6ulz-nand-sd-card-6ulcustomboard
+              - variscite,dart-6ul-imx6ulz-nand-sd-card-wm8731-6ulcustomboard
+              - variscite,dart-6ul-imx6ulz-nand-wifi-brcm-6ulcustomboard
+              - variscite,dart-6ul-imx6ulz-nand-wifi-brcm-wm8731-6ulcustomboard
+              - variscite,dart-6ul-imx6ulz-nand-wifi-iw61x-6ulcustomboard
+          - const: variscite,dart-6ul-imx6ulz
+          - const: fsl,imx6ulz
+          - const: fsl,imx6ull
+
+      - description: i.MX6ULZ Variscite VAR-SOM-6UL board variants
+        items:
+          - enum:
+              - variscite,var-som-imx6ulz-emmc-sd-card-concerto
+              - variscite,var-som-imx6ulz-emmc-sd-card-symphony
+              - variscite,var-som-imx6ulz-emmc-sd-card-wm8731-concerto
+              - variscite,var-som-imx6ulz-emmc-sd-card-wm8731-symphony
+              - variscite,var-som-imx6ulz-emmc-wifi-brcm-concerto
+              - variscite,var-som-imx6ulz-emmc-wifi-brcm-symphony
+              - variscite,var-som-imx6ulz-emmc-wifi-brcm-wm8731-concerto
+              - variscite,var-som-imx6ulz-emmc-wifi-brcm-wm8731-symphony
+              - variscite,var-som-imx6ulz-emmc-wifi-iw61x-concerto
+              - variscite,var-som-imx6ulz-emmc-wifi-iw61x-symphony
+              - variscite,var-som-imx6ulz-nand-sd-card-concerto
+              - variscite,var-som-imx6ulz-nand-sd-card-symphony
+              - variscite,var-som-imx6ulz-nand-sd-card-wm8731-concerto
+              - variscite,var-som-imx6ulz-nand-sd-card-wm8731-symphony
+              - variscite,var-som-imx6ulz-nand-wifi-brcm-concerto
+              - variscite,var-som-imx6ulz-nand-wifi-brcm-symphony
+              - variscite,var-som-imx6ulz-nand-wifi-brcm-wm8731-concerto
+              - variscite,var-som-imx6ulz-nand-wifi-brcm-wm8731-symphony
+              - variscite,var-som-imx6ulz-nand-wifi-iw61x-concerto
+              - variscite,var-som-imx6ulz-nand-wifi-iw61x-symphony
+          - const: variscite,var-som-imx6ulz
+          - const: fsl,imx6ulz
+          - const: fsl,imx6ull
+
       - description: i.MX7S based Boards
         items:
           - enum:
-- 
2.47.3

