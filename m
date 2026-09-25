Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C141369208
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 14:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790345008; cv=none; b=u0LkKexJzwKBDB/b/Pizg6cDlRBs2rBPeuY8zQDN2KqLzdvw4S9NeeW5ka4n1I0NusIsRS5kZs2hx+CxEqe5v5I1XQlgPDPsmTy17pmosyF9RWK+RvkvUy45L9CJxBs2AAg+dA7AYDaqLIU4A1gkNvMyukMOkmZwb5Ga5m6tMHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790345008; c=relaxed/simple;
	bh=0Lvc0YAQfktcsP2hNxZeXSNKDu3EjenZ+YXP9JY+5IY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VWpPJzZ81WFfhGC9lcgfowRQB7tGGvQmNiIlyWnZcK0kf/SftfbtqWNhj+Vbo7maSPCLYWRqFD//ntXjvmOURXVknxvpf8V/7PGnDjZY25tYgi7BwIxdZFFGtvJ/tyCDq5LgY7QuCIOcBKUSrcxOvcP+vbYe25l2SSe+IovoLqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQjKZGlC; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQjKZGlC"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e8185e037so5432195e9.3
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 07:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790345003; x=1790949803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Cbr96HebueHKLwgESgULT3Lm7N6ntaoX2Ip/x/Wgz0M=;
        b=bQjKZGlCrNCEn/AHNvr4ITpbNkV94W6TXPFR/ueP2AtmeD5tR4ungOGlyGD5okJMj1
         RZIbfPw2BAj9YB2JsfqrdTvmI9g6/uflzeoqLkDSuKyQognWqW8pnR/OWqFF04C9SYU5
         UyPWTt3KEdlyc5wLqucFwebnqjA7+2JSufFTB6NKR9VCfmi9h+vcGibseHoy2ZOg+EnS
         xaejlguGZftTScxQfweA2Udzh3S302cE7c0LwM8ENGsFWUDMxI6xL+MQ184NbB656vhD
         SpSc1L90L4NJ8ng9PSpcCr4IGf8XBNVtAuC3OTTxvMp2f5lf9GVPSw1IKQx8sULOt0w1
         LOvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790345003; x=1790949803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cbr96HebueHKLwgESgULT3Lm7N6ntaoX2Ip/x/Wgz0M=;
        b=I6ukUAkr97B3nLnzUV4//RhZbujqtezZ8uVhQ9jhcVJbsIFPR4JVX2ToaUJzPtyr2m
         gQtjbqHNoet93UX4gh6Ek89bMvWNyXpMIkKZIHvg/W8TChU0chG2N/nM/3mBItkrvAFw
         2UnRNnLHyg/M0psbh7NQW6zWBvSzhU1uphQnoLvdsS7S7Ct8GsThgtR2XQx6hWUUMRGG
         OQ9ppFJDIDUqoyYyC4FAO2U6BKJ2cJc8gT3YQw7z7SITcfbZC+JWFAF74VvWTe61E2PM
         xDyZ+KLcuSAD59rhbu0WP6N5lS4EAyPNHPTQLDPqMyGj1hFqv0BMrcgyeOCsxcV30Dbr
         rmKQ==
X-Forwarded-Encrypted: i=1; AKwUvBzN6RGh2lhIbrBFk35ZwPl3pOMac6M3C0T5DCoqfImQGkMz5WHgnh3XW7sw+l59q3tB1Vzdga8=@vger.kernel.org
X-Gm-Message-State: AFuF++k9jk09D3t+G4Zw7rsEZQhZ/vURx69IqYzp41pfi9d0kioBdqdU
	5pYjcg3tHjRiKZTj3Vh2war/H6W42XnJ47mG/po9Jk2mRgA/2d8IVcpN
X-Gm-Gg: AYBFou0irXX9rt0R3KT7y9Dxkk/Lp74cm9x28/usiXdC/mWbacCbh0FehszpaKL2VQE
	0lbuG3Shur1kP2MPJU+YTjJiBeFEMzRCSj10JTjK6H7bOkhbNrUs/hrAEjOHGaBaf0RrKmE7dR2
	ij/AP5k1+q8bda1CWrRMjy/lo2jQdKTXNd7p0JJtX1rE2wEu3B8EnGqWyvSbQndNAiDz0frf1vg
	+Ld+58IbAOa2w87jh5XPefy6JHTlo1mRR3PfNAP3UnBV3ayEKN3DTr039FGUGzJVx36fEtsvIBI
	VNqM6ISxxU/SVJnrRlodAC4TDKDT7tkvbusswsQK06Qdansja49iq6i8FjH0f/S1vxJ+X4C6coL
	aDhgUTweyytRCgKKBrQBSM/jJf0NOKw9kCz7C6NniMze05uO+S/Rr+6bxDD2NUfiJg+uYWEZiHd
	HBOVuSCA09XeFJZ7iH31ZEDRSLELpBQEaLkJ4U+REF92T+O6xWVZJZSCRreduNhI1WrASO56FyF
	rX7THKYrvntLgCO4EbVmlbHCH8vKKuUuQCoa/q8vXZB3mhtrdaQ1/JtO02yF6XejUbstWNRhiA9
	kfEuLKNsv7/uud2bB+RPKw==
X-Received: by 2002:a05:600c:1d1c:b0:49f:bc43:9e96 with SMTP id 5b1f17b1804b1-49ff06bcd5fmr44328735e9.8.1790345003028;
        Fri, 25 Sep 2026 07:03:23 -0700 (PDT)
Received: from Lord-Beerus.station ([31.27.155.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a355c65sm7522431f8f.19.2026.09.25.07.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 07:03:22 -0700 (PDT)
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
Subject: [PATCH v1 00/11] ARM: dts: imx6ul: Add Variscite VAR-SOM-6UL and DART-6UL
Date: Fri, 25 Sep 2026 16:02:17 +0200
Message-ID: <cover.1790344389.git.stefano.r@variscite.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device trees for Variscite VAR-SOM-6UL and DART-6UL modules based on
i.MX6UL, i.MX6ULL and i.MX6ULZ. VAR-SOM-6UL is supported on the
Concerto-Board and Symphony-Board carriers, and DART-6UL on the
VAR-6ULCustomBoard. The 90 new DTBs cover the supported combinations of
storage, wireless and audio options.

The descriptions use shared module, option and carrier DTSI files with
SoC-specific wrappers. In particular, the WM8904 and WM8731 codecs are
selected explicitly instead of keeping a codec in the module base.
The four existing Concerto DTBs are converted to this layout without
changing their DTB names or compatible strings. This also replaces the
non-working legacy LVDS panel description with the LCDIF configuration
for the Variscite display. Wi-Fi and Bluetooth enable/reset sequencing
on these modules is handled by userspace, so the legacy kernel-managed
power-sequence and Bluetooth nodes are not carried forward.

The Micrel binding change in patch 2 is needed by the Ethernet PHY
descriptions in this series. The existing boolean definition of
micrel,rmii-reference-clock-select-25-mhz conflicts with the dt-schema
unit check for properties ending in -mhz. The binding now accepts <1>
for 25 MHz selection and limits the property to the applicable PHYs.
The Micrel driver tests only whether the property is present, so this
does not change its runtime behavior.

Patches 1-2 update the bindings, patches 3-6 add reusable DTSI files,
patch 7 converts the existing Concerto boards, patches 8-10 add the
new i.MX6UL, i.MX6ULL and i.MX6ULZ board DTS files, and patch 11
enables their DTBs in the Makefile.

Stefano Radaelli (11):
  dt-bindings: arm: fsl: Document Variscite i.MX6UL boards
  dt-bindings: net: micrel: Fix RMII clock select property type
  ARM: dts: imx6ul: Add Variscite SoM and DART base files
  ARM: dts: imx6ul: Add Variscite audio codec files
  ARM: dts: imx6ul: Add Variscite storage and wireless files
  ARM: dts: imx6ul: Add Variscite carrier board files
  ARM: dts: imx6ul: Reuse Variscite DTSI files for Concerto
  ARM: dts: imx6ul: Add Variscite i.MX6UL board variants
  ARM: dts: imx6ull: Add Variscite i.MX6ULL board variants
  ARM: dts: imx6ulz: Add Variscite i.MX6ULZ board variants
  ARM: dts: imx6ul: Enable Variscite i.MX6UL board DTBs

 .../devicetree/bindings/arm/fsl.yaml          | 148 +++++++-
 .../devicetree/bindings/net/micrel.yaml       |  27 +-
 arch/arm/boot/dts/nxp/imx/Makefile            |  92 ++++-
 ...x6ull-var-dart-6ulcustomboard-sd-card.dtsi |  31 ++
 ...mx6ul-imx6ull-var-dart-6ulcustomboard.dtsi | 321 ++++++++++++++++
 .../nxp/imx/imx6ul-imx6ull-var-dart-emmc.dtsi |  32 ++
 .../nxp/imx/imx6ul-imx6ull-var-dart-nand.dtsi |  63 ++++
 .../imx6ul-imx6ull-var-dart-wifi-brcm.dtsi    |  42 +++
 .../imx6ul-imx6ull-var-dart-wifi-iw61x.dtsi   |  45 +++
 .../imx/imx6ul-imx6ull-var-dart-wm8731.dtsi   |  71 ++++
 .../imx/imx6ul-imx6ull-var-dart-wm8904.dtsi   |  88 +++++
 ...mmon.dtsi => imx6ul-imx6ull-var-dart.dtsi} | 224 +++++------
 ...mx6ull-var-som-concerto-board-sd-card.dtsi |  42 +++
 ...imx6ul-imx6ull-var-som-concerto-board.dtsi | 350 ++++++++++++++++++
 .../nxp/imx/imx6ul-imx6ull-var-som-emmc.dtsi  |  32 ++
 .../nxp/imx/imx6ul-imx6ull-var-som-nand.dtsi  |  63 ++++
 ...imx6ul-imx6ull-var-som-symphony-board.dtsi | 317 ++++++++++++++++
 .../imx/imx6ul-imx6ull-var-som-wifi-brcm.dtsi |  42 +++
 .../imx6ul-imx6ull-var-som-wifi-iw61x.dtsi    |  45 +++
 .../imx/imx6ul-imx6ull-var-som-wm8731.dtsi    |  71 ++++
 .../imx/imx6ul-imx6ull-var-som-wm8904.dtsi    |  85 +++++
 .../dts/nxp/imx/imx6ul-imx6ull-var-som.dtsi   | 201 ++++++++++
 .../imx/imx6ul-var-dart-6ulcustomboard.dtsi   |  18 +
 ...l-var-dart-emmc-sd-card-6ulcustomboard.dts |  20 +
 ...art-emmc-sd-card-wm8731-6ulcustomboard.dts |  20 +
 ...var-dart-emmc-wifi-brcm-6ulcustomboard.dts |  20 +
 ...t-emmc-wifi-brcm-wm8731-6ulcustomboard.dts |  20 +
 ...ar-dart-emmc-wifi-iw61x-6ulcustomboard.dts |  20 +
 ...l-var-dart-nand-sd-card-6ulcustomboard.dts |  20 +
 ...art-nand-sd-card-wm8731-6ulcustomboard.dts |  20 +
 ...var-dart-nand-wifi-brcm-6ulcustomboard.dts |  20 +
 ...t-nand-wifi-brcm-wm8731-6ulcustomboard.dts |  20 +
 ...ar-dart-nand-wifi-iw61x-6ulcustomboard.dts |  20 +
 .../arm/boot/dts/nxp/imx/imx6ul-var-dart.dtsi |  31 ++
 .../dts/nxp/imx/imx6ul-var-som-audio.dtsi     |  30 --
 .../imx/imx6ul-var-som-concerto-board.dtsi    |  38 ++
 .../imx/imx6ul-var-som-concerto-common.dtsi   | 215 -----------
 .../nxp/imx/imx6ul-var-som-concerto-full.dts  |  15 +-
 .../dts/nxp/imx/imx6ul-var-som-concerto.dts   |  14 +-
 ...ul-var-som-emmc-sd-card-concerto-board.dts |  20 +
 ...ul-var-som-emmc-sd-card-symphony-board.dts |  20 +
 ...som-emmc-sd-card-wm8731-concerto-board.dts |  20 +
 ...som-emmc-sd-card-wm8731-symphony-board.dts |  20 +
 ...-var-som-emmc-wifi-brcm-concerto-board.dts |  20 +
 ...-var-som-emmc-wifi-brcm-symphony-board.dts |  20 +
 ...m-emmc-wifi-brcm-wm8731-concerto-board.dts |  20 +
 ...m-emmc-wifi-brcm-wm8731-symphony-board.dts |  20 +
 ...var-som-emmc-wifi-iw61x-concerto-board.dts |  20 +
 ...var-som-emmc-wifi-iw61x-symphony-board.dts |  20 +
 .../dts/nxp/imx/imx6ul-var-som-enet1.dtsi     |  44 ---
 .../dts/nxp/imx/imx6ul-var-som-enet2.dtsi     |  79 ----
 .../nxp/imx/imx6ul-var-som-lvds-panel.dtsi    | 112 ------
 ...ul-var-som-nand-sd-card-concerto-board.dts |  20 +
 ...ul-var-som-nand-sd-card-symphony-board.dts |  20 +
 ...som-nand-sd-card-wm8731-concerto-board.dts |  20 +
 ...som-nand-sd-card-wm8731-symphony-board.dts |  20 +
 ...-var-som-nand-wifi-brcm-concerto-board.dts |  20 +
 ...-var-som-nand-wifi-brcm-symphony-board.dts |  20 +
 ...m-nand-wifi-brcm-wm8731-concerto-board.dts |  20 +
 ...m-nand-wifi-brcm-wm8731-symphony-board.dts |  20 +
 ...var-som-nand-wifi-iw61x-concerto-board.dts |  20 +
 ...var-som-nand-wifi-iw61x-symphony-board.dts |  20 +
 .../boot/dts/nxp/imx/imx6ul-var-som-sd.dtsi   |  27 --
 .../imx/imx6ul-var-som-symphony-board.dtsi    |  88 +++++
 .../boot/dts/nxp/imx/imx6ul-var-som-wifi.dtsi |  75 ----
 arch/arm/boot/dts/nxp/imx/imx6ul-var-som.dtsi |  31 +-
 .../imx/imx6ull-var-dart-6ulcustomboard.dtsi  |  18 +
 ...l-var-dart-emmc-sd-card-6ulcustomboard.dts |  20 +
 ...art-emmc-sd-card-wm8731-6ulcustomboard.dts |  20 +
 ...var-dart-emmc-wifi-brcm-6ulcustomboard.dts |  20 +
 ...t-emmc-wifi-brcm-wm8731-6ulcustomboard.dts |  20 +
 ...ar-dart-emmc-wifi-iw61x-6ulcustomboard.dts |  20 +
 ...l-var-dart-nand-sd-card-6ulcustomboard.dts |  20 +
 ...art-nand-sd-card-wm8731-6ulcustomboard.dts |  20 +
 ...var-dart-nand-wifi-brcm-6ulcustomboard.dts |  20 +
 ...t-nand-wifi-brcm-wm8731-6ulcustomboard.dts |  20 +
 ...ar-dart-nand-wifi-iw61x-6ulcustomboard.dts |  20 +
 .../boot/dts/nxp/imx/imx6ull-var-dart.dtsi    |  31 ++
 .../imx/imx6ull-var-som-concerto-board.dtsi   |  38 ++
 .../nxp/imx/imx6ull-var-som-concerto-full.dts |  15 +-
 .../dts/nxp/imx/imx6ull-var-som-concerto.dts  |  14 +-
 ...ll-var-som-emmc-sd-card-concerto-board.dts |  20 +
 ...ll-var-som-emmc-sd-card-symphony-board.dts |  20 +
 ...som-emmc-sd-card-wm8731-concerto-board.dts |  20 +
 ...som-emmc-sd-card-wm8731-symphony-board.dts |  20 +
 ...-var-som-emmc-wifi-brcm-concerto-board.dts |  20 +
 ...-var-som-emmc-wifi-brcm-symphony-board.dts |  20 +
 ...m-emmc-wifi-brcm-wm8731-concerto-board.dts |  20 +
 ...m-emmc-wifi-brcm-wm8731-symphony-board.dts |  20 +
 ...var-som-emmc-wifi-iw61x-concerto-board.dts |  20 +
 ...var-som-emmc-wifi-iw61x-symphony-board.dts |  20 +
 ...ll-var-som-nand-sd-card-concerto-board.dts |  20 +
 ...ll-var-som-nand-sd-card-symphony-board.dts |  20 +
 ...som-nand-sd-card-wm8731-concerto-board.dts |  20 +
 ...som-nand-sd-card-wm8731-symphony-board.dts |  20 +
 ...-var-som-nand-wifi-brcm-concerto-board.dts |  20 +
 ...-var-som-nand-wifi-brcm-symphony-board.dts |  20 +
 ...m-nand-wifi-brcm-wm8731-concerto-board.dts |  20 +
 ...m-nand-wifi-brcm-wm8731-symphony-board.dts |  20 +
 ...var-som-nand-wifi-iw61x-concerto-board.dts |  20 +
 ...var-som-nand-wifi-iw61x-symphony-board.dts |  20 +
 .../imx/imx6ull-var-som-symphony-board.dtsi   |  88 +++++
 .../arm/boot/dts/nxp/imx/imx6ull-var-som.dtsi |  31 +-
 .../imx/imx6ulz-var-dart-6ulcustomboard.dtsi  |  24 ++
 ...z-var-dart-emmc-sd-card-6ulcustomboard.dts |  21 ++
 ...art-emmc-sd-card-wm8731-6ulcustomboard.dts |  21 ++
 ...var-dart-emmc-wifi-brcm-6ulcustomboard.dts |  21 ++
 ...t-emmc-wifi-brcm-wm8731-6ulcustomboard.dts |  21 ++
 ...ar-dart-emmc-wifi-iw61x-6ulcustomboard.dts |  21 ++
 ...z-var-dart-nand-sd-card-6ulcustomboard.dts |  21 ++
 ...art-nand-sd-card-wm8731-6ulcustomboard.dts |  21 ++
 ...var-dart-nand-wifi-brcm-6ulcustomboard.dts |  21 ++
 ...t-nand-wifi-brcm-wm8731-6ulcustomboard.dts |  21 ++
 ...ar-dart-nand-wifi-iw61x-6ulcustomboard.dts |  21 ++
 .../boot/dts/nxp/imx/imx6ulz-var-dart.dtsi    |  38 ++
 .../imx/imx6ulz-var-som-concerto-board.dtsi   |  44 +++
 ...lz-var-som-emmc-sd-card-concerto-board.dts |  21 ++
 ...lz-var-som-emmc-sd-card-symphony-board.dts |  21 ++
 ...som-emmc-sd-card-wm8731-concerto-board.dts |  21 ++
 ...som-emmc-sd-card-wm8731-symphony-board.dts |  21 ++
 ...-var-som-emmc-wifi-brcm-concerto-board.dts |  21 ++
 ...-var-som-emmc-wifi-brcm-symphony-board.dts |  21 ++
 ...m-emmc-wifi-brcm-wm8731-concerto-board.dts |  21 ++
 ...m-emmc-wifi-brcm-wm8731-symphony-board.dts |  21 ++
 ...var-som-emmc-wifi-iw61x-concerto-board.dts |  21 ++
 ...var-som-emmc-wifi-iw61x-symphony-board.dts |  21 ++
 ...lz-var-som-nand-sd-card-concerto-board.dts |  21 ++
 ...lz-var-som-nand-sd-card-symphony-board.dts |  21 ++
 ...som-nand-sd-card-wm8731-concerto-board.dts |  21 ++
 ...som-nand-sd-card-wm8731-symphony-board.dts |  21 ++
 ...-var-som-nand-wifi-brcm-concerto-board.dts |  21 ++
 ...-var-som-nand-wifi-brcm-symphony-board.dts |  21 ++
 ...m-nand-wifi-brcm-wm8731-concerto-board.dts |  21 ++
 ...m-nand-wifi-brcm-wm8731-symphony-board.dts |  21 ++
 ...var-som-nand-wifi-iw61x-concerto-board.dts |  21 ++
 ...var-som-nand-wifi-iw61x-symphony-board.dts |  21 ++
 .../imx/imx6ulz-var-som-symphony-board.dtsi   |  24 ++
 .../arm/boot/dts/nxp/imx/imx6ulz-var-som.dtsi |  38 ++
 138 files changed, 4716 insertions(+), 766 deletions(-)
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-dart-6ulcustomboard-sd-card.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-dart-6ulcustomboard.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-dart-emmc.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-dart-nand.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-dart-wifi-brcm.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-dart-wifi-iw61x.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-dart-wm8731.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-dart-wm8904.dtsi
 rename arch/arm/boot/dts/nxp/imx/{imx6ul-var-som-common.dtsi => imx6ul-imx6ull-var-dart.dtsi} (50%)
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-som-concerto-board-sd-card.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-som-concerto-board.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-som-emmc.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-som-nand.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-som-symphony-board.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-som-wifi-brcm.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-som-wifi-iw61x.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-som-wm8731.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-som-wm8904.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-som.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-dart-6ulcustomboard.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-dart-emmc-sd-card-6ulcustomboard.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-dart-emmc-sd-card-wm8731-6ulcustomboard.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-dart-emmc-wifi-brcm-6ulcustomboard.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-dart-emmc-wifi-brcm-wm8731-6ulcustomboard.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-dart-emmc-wifi-iw61x-6ulcustomboard.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-dart-nand-sd-card-6ulcustomboard.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-dart-nand-sd-card-wm8731-6ulcustomboard.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-dart-nand-wifi-brcm-6ulcustomboard.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-dart-nand-wifi-brcm-wm8731-6ulcustomboard.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-dart-nand-wifi-iw61x-6ulcustomboard.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-dart.dtsi
 delete mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-som-audio.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-som-concerto-board.dtsi
 delete mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-som-concerto-common.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-som-emmc-sd-card-concerto-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-som-emmc-sd-card-symphony-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-som-emmc-sd-card-wm8731-concerto-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-som-emmc-sd-card-wm8731-symphony-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-som-emmc-wifi-brcm-concerto-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-som-emmc-wifi-brcm-symphony-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-som-emmc-wifi-brcm-wm8731-concerto-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-som-emmc-wifi-brcm-wm8731-symphony-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-som-emmc-wifi-iw61x-concerto-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-som-emmc-wifi-iw61x-symphony-board.dts
 delete mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-som-enet1.dtsi
 delete mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-som-enet2.dtsi
 delete mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-som-lvds-panel.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-som-nand-sd-card-concerto-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-som-nand-sd-card-symphony-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-som-nand-sd-card-wm8731-concerto-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-som-nand-sd-card-wm8731-symphony-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-som-nand-wifi-brcm-concerto-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-som-nand-wifi-brcm-symphony-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-som-nand-wifi-brcm-wm8731-concerto-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-som-nand-wifi-brcm-wm8731-symphony-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-som-nand-wifi-iw61x-concerto-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-som-nand-wifi-iw61x-symphony-board.dts
 delete mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-som-sd.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-som-symphony-board.dtsi
 delete mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-som-wifi.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-var-dart-6ulcustomboard.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-var-dart-emmc-sd-card-6ulcustomboard.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-var-dart-emmc-sd-card-wm8731-6ulcustomboard.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-var-dart-emmc-wifi-brcm-6ulcustomboard.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-var-dart-emmc-wifi-brcm-wm8731-6ulcustomboard.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-var-dart-emmc-wifi-iw61x-6ulcustomboard.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-var-dart-nand-sd-card-6ulcustomboard.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-var-dart-nand-sd-card-wm8731-6ulcustomboard.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-var-dart-nand-wifi-brcm-6ulcustomboard.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-var-dart-nand-wifi-brcm-wm8731-6ulcustomboard.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-var-dart-nand-wifi-iw61x-6ulcustomboard.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-var-dart.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-var-som-concerto-board.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-var-som-emmc-sd-card-concerto-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-var-som-emmc-sd-card-symphony-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-var-som-emmc-sd-card-wm8731-concerto-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-var-som-emmc-sd-card-wm8731-symphony-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-var-som-emmc-wifi-brcm-concerto-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-var-som-emmc-wifi-brcm-symphony-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-var-som-emmc-wifi-brcm-wm8731-concerto-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-var-som-emmc-wifi-brcm-wm8731-symphony-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-var-som-emmc-wifi-iw61x-concerto-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-var-som-emmc-wifi-iw61x-symphony-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-var-som-nand-sd-card-concerto-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-var-som-nand-sd-card-symphony-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-var-som-nand-sd-card-wm8731-concerto-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-var-som-nand-sd-card-wm8731-symphony-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-var-som-nand-wifi-brcm-concerto-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-var-som-nand-wifi-brcm-symphony-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-var-som-nand-wifi-brcm-wm8731-concerto-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-var-som-nand-wifi-brcm-wm8731-symphony-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-var-som-nand-wifi-iw61x-concerto-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-var-som-nand-wifi-iw61x-symphony-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-var-som-symphony-board.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-6ulcustomboard.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-emmc-sd-card-6ulcustomboard.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-emmc-sd-card-wm8731-6ulcustomboard.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-emmc-wifi-brcm-6ulcustomboard.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-emmc-wifi-brcm-wm8731-6ulcustomboard.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-emmc-wifi-iw61x-6ulcustomboard.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-nand-sd-card-6ulcustomboard.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-nand-sd-card-wm8731-6ulcustomboard.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-nand-wifi-brcm-6ulcustomboard.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-nand-wifi-brcm-wm8731-6ulcustomboard.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-nand-wifi-iw61x-6ulcustomboard.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-concerto-board.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-emmc-sd-card-concerto-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-emmc-sd-card-symphony-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-emmc-sd-card-wm8731-concerto-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-emmc-sd-card-wm8731-symphony-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-emmc-wifi-brcm-concerto-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-emmc-wifi-brcm-symphony-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-emmc-wifi-brcm-wm8731-concerto-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-emmc-wifi-brcm-wm8731-symphony-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-emmc-wifi-iw61x-concerto-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-emmc-wifi-iw61x-symphony-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-nand-sd-card-concerto-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-nand-sd-card-symphony-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-nand-sd-card-wm8731-concerto-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-nand-sd-card-wm8731-symphony-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-nand-wifi-brcm-concerto-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-nand-wifi-brcm-symphony-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-nand-wifi-brcm-wm8731-concerto-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-nand-wifi-brcm-wm8731-symphony-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-nand-wifi-iw61x-concerto-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-nand-wifi-iw61x-symphony-board.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-symphony-board.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-som.dtsi


base-commit: 49dcf40cf1843c615332c7123508f0bef3ee86ba
-- 
2.47.3
