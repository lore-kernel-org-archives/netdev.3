Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0007553FD30
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 15:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790695079; cv=none; b=t5QBzhWwljd27AbPSseZAmHAMow0bSPXLK96IUdF6RlGSL2uf0yCGDhfxkpNmorKM9sKgwQGPuDuTagk6N60/+ummA2sx7/a0H/dS6THlRhipdGNv+RRd9uIPNzzgqd87ACHYX0fpYqrfdB9Uvl9lVeiLkeSPZ0x2n3fjEptALA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790695079; c=relaxed/simple;
	bh=G6XcWLt9W/5WDaZoUK2UZH2AziJLt/KqfJMUg1KtHrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TuRb6H/YCOWwmHAzNuLujK7hfY6xX+Y0DzApTPfTZ23r7AC509l5BgZbRsTVLlvQqdx6RFo2huxzdvI7HPETpq48oezxGrfiPC8IggdncWXuAvzpgfG7J3N5IYGLUhvkEl7lduEa6To+4lH/YpZUQCMqeIJibcBQBDmpKVaSfmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dKYBcH43; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKYBcH43"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-4a003bd18e5so13161245e9.0
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 08:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790695070; x=1791299870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X/wcOHMEVWVR3p6oq6xv8OGP6miSv6dtFwXxohtxDzw=;
        b=dKYBcH430Ni41p7Orn0RKODRmn/vH/LezrNZhO5anMA3JEXtmCWTkyxCq3X2kC/eiW
         /IAqGxe04orBxsBV7V3lsIUyHc3d5njREPWxSfWpi+8Xld2XF1V9/8HQSeFnmTIpdWz2
         CGC9JQUBufzzHc1XABjYqvrRrU22TrG58VOkYX18Qzn1lEqOqtI18GLSpkLi9Xx+zT3J
         62aNM0Pb1xKlbhP46w9g6HqFA5Ks3OQ12vETEnhXI5pgMKVlCpOVBN4M3U/5UnIQu/Jz
         hLsj6+kXFFRs/IdS2Osd2XsxJ4cuhb5rXqakLjIHL0l2YvE/N9CmhFKEdhE1XR79Dcc8
         V9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790695070; x=1791299870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=X/wcOHMEVWVR3p6oq6xv8OGP6miSv6dtFwXxohtxDzw=;
        b=xGdibra3M2Uu9157ICtBH7LBSxsEVO0w86aAZo0WMjTU48tpNG/2YYZ5luGJqWC9jX
         U/A8nCDxdQMOp4mz+tTM6I/s5dVdiMrwSpkpKfzQ0tCS6votAvllZF7iowlm0h5t1mL3
         QC0rczZobRZs67LtDSGRU4Lf8kS3tSXBQK2SH65dGYJz5D0mWDKJbmw9/0e7/85V8Ymn
         bj8exc8faHozrh46RrS/YHGOfQ0eT/UyClO0Gp/GGJRPCcO5bF5mYn5795/6BEbzE9eF
         ughmPq7NFIjN7EKy7VERUEwhWynmiuZnpwKWhjXLe4eSfIK1Gqqb8HD2NQ60wiNwJM/R
         1uqA==
X-Forwarded-Encrypted: i=1; AKwUvBxbFJcmNVAxyc6fM6BMc3b7SdcJit8Q4XKXZ36rPt4plpV5NZey7khT+BQCs8ZImXimg47eTyo=@vger.kernel.org
X-Gm-Message-State: AFuF++nWHDLttqIHQ24PP8BXo4Kty/TUsPMek/t7/HVLkdSF099hOncq
	Jsy0rhrXKLQq1CToEeZBeUmWZ+j1hcE28pHpaUXM7KEL/5ZAx1EMrbyr
X-Gm-Gg: AYBFou1VAseAADU6axFkNlM2Bokvdvi4eT74viM6rGHiBF2BTCtwwBplRvwbbTKUBdI
	5xRJpl23kldpHhOEjnBV4jE1J5ffVyZRH2ndWs0VxAlg7vwL1cP+bTdpAaaMesLcCljIsidAg+G
	DarpMl18XFd1BCGWFn90BxTdhkz1pfEL9O4VKuhfK8f+P5n5hLWrOpR/VSZiQxrlE67wJqkHsh3
	sSabROogG83+M5JA30Dv7XBWC1OEHrpapBHBxHgHELJdld7eIAlzAPWdssxPC17d16hBNNeb7/k
	sgjg5IPfyNsZ6sdszzN+Id7+S18jY0krDD1pUsf3gpgVqlYL/vQvFWdzTuFDYlg6fo/4XDq1OUd
	v6RK+nwcUHuB/7P0r7g61sgPQdfZ3TmlYiQ874Z4L1mUS6UD4RTxvZOBGifZz6TMREIbsR6fX9t
	UMfzqkcdmwha/moN+67x2QkxDHN8RFEEHzyqvBEIgWFXFZRzqu7NiqVqRdrwhXOyMeAPTwLkODM
	ho+tcCNO1uUbDyL4W+aqrFmjbxPJcl2MQse+Hfoo8W0chEAKZV9islrRVjaS0ENTxrkn/h1dtN9
	rtwVMwv7uIs1wvbWAPPc/9UiWpXS1YE+
X-Received: by 2002:a05:600c:8518:b0:49f:d325:9912 with SMTP id 5b1f17b1804b1-49ff06bcd79mr215836965e9.10.1790695069866;
        Tue, 29 Sep 2026 08:17:49 -0700 (PDT)
Received: from Lord-Beerus.station ([31.27.155.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a013cf8402sm10313705e9.2.2026.09.29.08.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 08:17:49 -0700 (PDT)
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
	Josua Mayer <josua@solid-run.com>,
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
	Mehmet Fide <mehmet.fide@screeningeagle.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH v4 03/13] dt-bindings: arm: fsl: Add Variscite i.MX6ULZ board variants
Date: Tue, 29 Sep 2026 17:17:30 +0200
Message-ID: <1e6f9e01bd9e0e0801b18ddc9eb44bde200ea984.1790693249.git.stefano.r@variscite.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1790693249.git.stefano.r@variscite.com>
References: <cover.1790693249.git.stefano.r@variscite.com>
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
v3->v4:
 - Split the board binding by SoC and add separate VAR-SOM-6UL and
   DART-6UL entries for i.MX6ULZ.
 - Drop the redundant -board suffix from new Concerto and Symphony
   compatibles and use sorted items/enum lists.

 .../devicetree/bindings/arm/fsl.yaml          | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 9b1224091e01..42d12624c1db 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -944,6 +944,50 @@ properties:
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
+          - const: fsl,imx6ull
+          - const: fsl,imx6ulz
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
+          - const: fsl,imx6ull
+          - const: fsl,imx6ulz
+
       - description: i.MX7S based Boards
         items:
           - enum:
-- 
2.47.3
