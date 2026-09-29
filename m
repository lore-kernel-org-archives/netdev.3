Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DBF53F6A9
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 15:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790695077; cv=none; b=JvAVru1kaQXIHskW+MI4z9jB3s1Te2hLe6V60g77ZW7olIqYh6Vus6Q7Zk/4aO9u0x+AJacgHk0HfEfMEOKhaF6wkaGWfjAVUAffQ454oxS9chq6gibMNSppieGUVdzEdytNoSNr6l7WKwNnqwEliOcx/OOwDyGlhGLPVXl/Xps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790695077; c=relaxed/simple;
	bh=cgkMSwM4juxySH5oXoW3O7eWRh40ogW9zBygalx6hnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qmqcr4M9MJxVaJjaHFyZ3/RhDaX7ABkKYTorlpZquFGjat0OaO+ZbQuNOHj5dAfsyxdbhD1XX0ZeHll0vSSG1IwwKpTg9X+1GoAF4QHfjIcHUKAzldUWVvoE3H35riIOA+1mmdgCSA9QPV36/Fdm40v8g5Awuk9vJyehNTuVge8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0uPNRmE; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0uPNRmE"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccf3ca626so26980095e9.0
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 08:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790695066; x=1791299866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=74RUEBvytcfICQALEQDWbpTlzpkzH2p8RRgKPqwsI10=;
        b=G0uPNRmEJkVsxUnU3QrmSFDCNF1h/pQ4Rqil4bB5YLfwdT45nTOzeH4XYZeTIsEy2y
         qLgBqZKYBmXmYkRkcz+JmqFv65jXvUtPRT5kcXbDmSw1UFmI6uLKf6FeUUOq/jmbyzx6
         YVXONTNPK7WxFaKj4fBRUi2pqXuAVGtFEN40qsRkcf2j7KzoT4H+BSQU5JSGAnIuq8pJ
         H7ePfbD41s1FEUfzB/bR+ARQ6FujmY60YTFrtTaW8nuVGSooNgLTs3yiI7faSsrxePBp
         uS0wC/jlyvmhXzLkveEeWzssJiQDzSzNRQXPK1mluUs8DaR075S7h1V98PkZa1JLL+lH
         6hRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790695066; x=1791299866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=74RUEBvytcfICQALEQDWbpTlzpkzH2p8RRgKPqwsI10=;
        b=v3VJAY678fvYPTgRxUS4A/UY7PkNSpA88MLmgzgHM/2Cw4L6/WTTvRb/wWr0Xef7ng
         f4eDF+izP4cXGU/txXr95FhxYqVWs4jWm9dHiAGiDsQsHz/8qFondwdoS6RaVwV5Ztz/
         TOTfeVt20D5FdImPMv8BTY7m0Ge7kKJAyJzIx0bti6S0vULCsa/HihEDQzfU5ADAk5Th
         9crLT+axvPyvgVQUdf1s0lWThILrBO8Ptjw7JlzQGX7RJwKM6BjbS/H+1qVg0eyd2rx5
         3YW0gAaN+udou0zH3jLmQgiyJNp1XqPmGp3RDNJfuSYvdephvML5gqJ73tNItUlTOUNu
         pvrA==
X-Forwarded-Encrypted: i=1; AKwUvBwAgvzIl2RdP0BToRF1HSJsV6bfBX0DCZIYiPglaiJfETdfWC2be/kr16xB1tfjhwEgjEJ+3Lw=@vger.kernel.org
X-Gm-Message-State: AFuF++k0NC7bs3pSCTOHeqOjkJdqo4QzqpE1BgOifp5VQecbXmW+qK3c
	LxVSOMfZ+nrDR8aSDNvqhgtUvZm5Oq6gji6Te6S6NOnw2MSOHOTSKuPD
X-Gm-Gg: AYBFou2Ppo/H27HIumThjCW+5uUBYCRemihnGR0vqQEMD7z7Bn5G98L65cQ40yxQGiU
	ZLCYm8N38ou6MCjlZ2bNlOGf+vid0AqYK6b5wKQv+z7cUeXEDPNhbzkYARl2h5cIg5Gwfr7JJKg
	b54i1ueqxR3xynJUJLTPi7KDI4aWNdvjRy3NUfYm1bdNqtmAG4v23f6Hzl5PU1v1U92rt5g3DrV
	DrbGkCXapXxWJ/gHfUFmiMOUC07O3TUsgDrqJ4xabtZhae5fZ//sNgAu2rDK8OyEwHM98sScXfZ
	+xQNG73epGAuyAJGAEV3Vc0Q72ahd8L4CDYe4aX60AnLey9CRP3bsmcrjy5NgfkP2L8Q9hcK3Bt
	uunvA6eh2Fh8joZuv7l7ZWLbUB110zNBkGWE6ZY19eMR/eKvbg3/3z1njW8j5Dim8u0VuGvHATi
	DYAcNhoN1lXor6hzzCJ2Ifh3fR2vGihOwMqgs7QD3sEsznTtBoimAPmbgcMw2j+Jox+9Rx3rU8C
	bEDmBpFwDZ0YCbjFfBE9a6RroxuCDqxSSfgYq4xWDtfaqMnvbdwUjnUuV5leiDOFtOzzIuN0Tgg
	dAnd6DzQ2uJM/Q4kFQ7IUg==
X-Received: by 2002:a05:600c:1c2a:b0:4a0:c2a:485e with SMTP id 5b1f17b1804b1-4a00c2a48cdmr69280265e9.33.1790695066289;
        Tue, 29 Sep 2026 08:17:46 -0700 (PDT)
Received: from Lord-Beerus.station ([31.27.155.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a013cf8402sm10313705e9.2.2026.09.29.08.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 08:17:45 -0700 (PDT)
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
Subject: [PATCH v4 01/13] dt-bindings: arm: fsl: Add Variscite i.MX6UL board variants
Date: Tue, 29 Sep 2026 17:17:28 +0200
Message-ID: <c547995bcb14779a5883d855137148ebddb7ef8d.1790693249.git.stefano.r@variscite.com>
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

Document new VAR-SOM-6UL configurations on the already supported
Concerto carrier while retaining its legacy compatible. Add
VAR-SOM-6UL variants on Symphony and DART-6UL variants on
VAR-6ULCustomBoard.

The new compatibles identify the SoM storage, wireless and audio
options followed by the carrier, module and SoC compatibles.

Signed-off-by: Stefano Radaelli <stefano.r@variscite.com>
---
v3->v4:
 - Split the board binding by SoC, extend the existing VAR-SOM-6UL
   entry with new Concerto and Symphony variants, and add DART-6UL.
 - Drop the redundant -board suffix from the new carrier compatibles
   and use sorted items/enum lists.

 .../devicetree/bindings/arm/fsl.yaml          | 39 ++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 36e28e0e4ad9..233687131adb 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -688,9 +688,46 @@ properties:
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
