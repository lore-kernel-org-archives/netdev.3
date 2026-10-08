Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B6B4756B2
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 19:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791488423; cv=none; b=p4UGsZ3cnWu+/XupSYh5GdPxl1n6kbhzK1ufQPnYoemzZaWzDvwmr04Jx6dBqHJzu1EN5TOVctIeE1D7ypW4FZQHNlhWri0BTSc/rPpfyAkmPtNQeKY4kUr3C6H+Q3KxBDtzxR7eTjjFwDX8scoNVcVRvyQ4cL4X6jhTrS1TdhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791488423; c=relaxed/simple;
	bh=yeElXe5PuqMK9cXSg0q/mdekpBfVZljUalhMY591reQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NO2Hn4BqplPKZCl3HCp10gdw/U9DPwW0lzN7mtf1dJIYO/2NwVIB/jCKRTe/ZXRPtR52qXgnrSEpDb1NCob13cMcPpRfGzk0Vhh6GZNLwcMwibQ0SsvlU0PocPDdkAsYXJV1p6v4VDYb5eMut5tw98/NTHVMQPx5hU4uz4tSOwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pyd/4jSa; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pyd/4jSa"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a1880e1bf1so6685335e9.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 12:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791488418; x=1792093218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1ne6jQNHZSute3MOl6uhvR02t4ZAiYz3hjPWK7wQg7Q=;
        b=pyd/4jSaZHAySJcbaHbEyrsbhAurgXUMUiMctnQ35u+yeR5aaD+KRIf1Hp2KqsHwsF
         MP+1m9O9TtqfrlkLg66y+jj8Hj8oD+z6hMugo6YbcjO1RIJHOvbbBhQK+xkgEGfas3QS
         8XxoRuZZWieZWdPyzdvx/PcUkWYjTTepEMBD4mYP5skwUWHjUGm/2fDXff8DxOHLLC4i
         LaRGzwq/Ogej9mwpN8jFmZgqNsIaW6YNu0OQrhOQy47VXTe0PGjbpTIUEJS0cTQY+b2A
         zrjD44ilFdKlpOJuvKF6XH2kA6OVCGADDPMZVc7tewyhzSOvXOoUY5GyfrlVErJ5cJTS
         7Rtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791488418; x=1792093218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1ne6jQNHZSute3MOl6uhvR02t4ZAiYz3hjPWK7wQg7Q=;
        b=AeDmxRsU+ciyHtR9n+ey5nVtHEAuuuJxYUxjoFVr24iS1DcQKun8pjImYqnYF2XTv1
         QZTAhEx9kntiLgojRqx4CwKMJ3RkWBRu8BLw5fCj4jF/E9w30T3buLCRTNPSZ4PZGZVl
         Jk/XTF1jjlT5sG9xO1WDKk77O4+lTbdHRLw1BrxUCwJhPO7ycUp/1qrRI3PpMKGVbzmx
         Fpix9kkm32VJZtH3Bx3Hw+IHeOeSWJojwYMJHEcI/VQ2vNDaQA//m0pbtg9bOfOpwpBi
         px5tBQZwA3AfX1tHAmOqG+S7I8LTD4icXV9GChw1tAL0af70iUnDiSvT6s3R0IBTQ9Vs
         7WQA==
X-Forwarded-Encrypted: i=1; AKwUvBzqS5Xv07tefQEJQ5LzZBgPlJ9SNDVcEQp0tyaJpJpsRKz5fyZ1/1az91nRz7w/7W7plsTmdXM=@vger.kernel.org
X-Gm-Message-State: AFuF++lI9QdFlDCWZyy9eaQeK6rBd3ojbhmodZEctIwxCduocMbDsbbO
	zuO5mUwLjWjVwX1pwA1gN3M0hOaYR4XChYBOvPrsghclhtqqJAJ1bAk+
X-Gm-Gg: AYBFou2l8/Pb774WATdglesCg+8QH3G8YoqtoIF5O9NjF3elCLkBzLQ2iR5b/wUf5dP
	O0ye46Soi8dte6YkaqyW1B9R4ZMIN++YZoVqNZeO8w6dpk45F+ScSPbbzGm4PPVNJIrLHmHOz8B
	2ykMW7ywt5OhpeLPMTW/hEqrj5QiDVkgTzOygQZSB713AGNh4KXRuC7/oNXgwFL+/CuiHPNQKUG
	JgASiJJ/jXhHAdqJwhg9uvV/H4v5P0T9qL8YQoiSyAGmVXAg/q1GCmz8kfT/QKtq5D7QpNL1F33
	kQG5bPJaDlvoNGM9GkoL+NSI+jo3GubKt9XaDjIZM+dqF6IrhatYmQqsCkVgsphIZGWibgyq93U
	+rZ/kqQQZNZcNxeH3T1TR5iqHqc7aJfx7HamsZQAhSAiOKQ4t/hxJwwW+vpmVJcEF91+6kYLtAe
	YoqrRe6H26qtfK3hH886IXQzwo6l5Gmyf9wYtExaqxeCSKzt23w94GFpPGp+NewFfGrWXAKBcJY
	fPXD0Ubp+G/wSa2qIH5vx6xTtSTwzb0B2Bl//jE10kFY8pD86W6u8dowMcOn/x/dXafz9C9kPHo
	rJqkSe43znpxgfWghwSPtA==
X-Received: by 2002:a05:600c:5391:b0:49f:cbf1:e77b with SMTP id 5b1f17b1804b1-4a1802eab67mr140228155e9.10.1791488417829;
        Thu, 08 Oct 2026 12:40:17 -0700 (PDT)
Received: from Lord-Beerus.station ([31.27.155.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18c1e33d2sm1419065e9.0.2026.10.08.12.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 12:40:17 -0700 (PDT)
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
Subject: [PATCH v5 02/13] dt-bindings: arm: fsl: Add Variscite i.MX6ULL board variants
Date: Thu,  8 Oct 2026 21:37:42 +0200
Message-ID: <e5f0dc2bdf5574c907c0efdc8b5b9974a32e2cbf.1791487179.git.stefano.r@variscite.com>
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
index f044f6fce51f..ca6778b8777f 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -835,9 +835,46 @@ properties:
           - const: phytec,imx6ull-pcl063        # PHYTEC phyCORE-i.MX 6ULL
           - const: fsl,imx6ull
 
+      - description: i.MX6ULL Variscite DART-6UL board variants
+        items:
+          - enum:
+              - variscite,dart-6ul-imx6ull-emmc-sd-card-6ulcustomboard
+              - variscite,dart-6ul-imx6ull-emmc-sd-card-wm8731-6ulcustomboard
+              - variscite,dart-6ul-imx6ull-emmc-wifi-brcm-6ulcustomboard
+              - variscite,dart-6ul-imx6ull-emmc-wifi-brcm-wm8731-6ulcustomboard
+              - variscite,dart-6ul-imx6ull-emmc-wifi-iw61x-6ulcustomboard
+              - variscite,dart-6ul-imx6ull-nand-sd-card-6ulcustomboard
+              - variscite,dart-6ul-imx6ull-nand-sd-card-wm8731-6ulcustomboard
+              - variscite,dart-6ul-imx6ull-nand-wifi-brcm-6ulcustomboard
+              - variscite,dart-6ul-imx6ull-nand-wifi-brcm-wm8731-6ulcustomboard
+              - variscite,dart-6ul-imx6ull-nand-wifi-iw61x-6ulcustomboard
+          - const: variscite,dart-6ul-imx6ull
+          - const: fsl,imx6ull
+
       - description: i.MX6ULL Variscite VAR-SOM-6UL Boards
         items:
-          - const: variscite,mx6ullconcerto  # Variscite VAR-SOM-6UL dev kit board
+          - enum:
+              - variscite,mx6ullconcerto  # Variscite VAR-SOM-6UL dev kit board
+              - variscite,var-som-imx6ull-emmc-sd-card-concerto
+              - variscite,var-som-imx6ull-emmc-sd-card-symphony
+              - variscite,var-som-imx6ull-emmc-sd-card-wm8731-concerto
+              - variscite,var-som-imx6ull-emmc-sd-card-wm8731-symphony
+              - variscite,var-som-imx6ull-emmc-wifi-brcm-concerto
+              - variscite,var-som-imx6ull-emmc-wifi-brcm-symphony
+              - variscite,var-som-imx6ull-emmc-wifi-brcm-wm8731-concerto
+              - variscite,var-som-imx6ull-emmc-wifi-brcm-wm8731-symphony
+              - variscite,var-som-imx6ull-emmc-wifi-iw61x-concerto
+              - variscite,var-som-imx6ull-emmc-wifi-iw61x-symphony
+              - variscite,var-som-imx6ull-nand-sd-card-concerto
+              - variscite,var-som-imx6ull-nand-sd-card-symphony
+              - variscite,var-som-imx6ull-nand-sd-card-wm8731-concerto
+              - variscite,var-som-imx6ull-nand-sd-card-wm8731-symphony
+              - variscite,var-som-imx6ull-nand-wifi-brcm-concerto
+              - variscite,var-som-imx6ull-nand-wifi-brcm-symphony
+              - variscite,var-som-imx6ull-nand-wifi-brcm-wm8731-concerto
+              - variscite,var-som-imx6ull-nand-wifi-brcm-wm8731-symphony
+              - variscite,var-som-imx6ull-nand-wifi-iw61x-concerto
+              - variscite,var-som-imx6ull-nand-wifi-iw61x-symphony
           - const: variscite,var-som-imx6ull # Variscite VAR-SOM-6UL SoM (6ULL variant)
           - const: fsl,imx6ull
 
-- 
2.47.3

