Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A6553B333
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 15:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790695082; cv=none; b=r7L/UKGwlcqrdZ4Njq3ap21Nijs6H0IyLv9owCTMA3dBF5RsPHOYzc/cOmFf4TNJ+uDxtIeqYW39HeclcyDp/GsSVuTb51TKBIcOPbzS0ZSA5PlDoD/CcEsoYimWDHh+QZfzLdNPmubCV1x5gzQ/WjF+75K/H+zMSBG9sqNCNNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790695082; c=relaxed/simple;
	bh=QJ6ftqkZ7IU/DOjo/nO7LuZcGv9YO0v0t3E2bEbCNtg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RwrZIpVtQvM6xx2uJrmZBLgaYNm5REO9KcutjEo55aMPXJEuo5rEVAxuiLmozo2jHP3tfGiSqCH2lU7q3/k1uly0cmKM0wmCUQN2ZMwNKHK6YXKLb4f6RYsZc8c5L6FVm13BKbdHC8F5uux9LbkrtToJNfhpsIfsDu28pbrnuzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXMyRQcE; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXMyRQcE"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffde3cec6so16412615e9.3
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 08:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790695065; x=1791299865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kp0RPrZpJfMyUcc2g781WWpVVcPub6+Oo0D8zUrnTRA=;
        b=kXMyRQcEXOuQMo3Hb/VPgAyAT+LAaYr+LXQngugWWRSZJoHZ6/Ooqlc43O5sY6ahMV
         r/FUwBbXy5fcCAkLakBOYqeoPvFGDnj9kxqpkhw/2bi5iyIxc+qv3cPI48uEZUAblKwp
         q9sn2gAqFeOMryETv5njduWEfxBWtfCK+rgjkSPW7oRjjU+Rcfc98QxF4GY7VuOpuldA
         ofQLnU9rYzXBJ+QMt5jCR/NSNP4py4udNxE7NnMjfOlnnpIbBL9brt3JMHTlKHd6AHO8
         sQHVLAQo4hURCAxwxK2Q3O5ykF4QRc/gJzXcJ/wXkb02GAz4pDrlwsvskjpYbnUBnnrN
         aiBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790695065; x=1791299865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kp0RPrZpJfMyUcc2g781WWpVVcPub6+Oo0D8zUrnTRA=;
        b=OtEYMAVigxHX5cpQeOUEsXtnb0GGmxy8KsYdrO4fT8S0h9piAMNljV4/TrsLSb/Fup
         h6vTP1cJRWovvVe/CFM7e0HW05JATkuMh2YoAW407WV65QKuL79jfhZbO06Xm57N8HPW
         A4vIdwz4EhwaT6Lx5McPSsLUXx++/wlZlNyJTOR7RnoHHRMB/9XPt2As9POr9nB2hlVy
         td1SnY8bRCSRebtczQmPj/YZVWVTOE/cSbrM9WslAjxhcTVOgLsz8D1BUNnASejlIAxh
         N8GKeIV8BqHnXU6v49sEnB+Gbe6fHA+0ROD21zuUJdDaVW3wBwOEgCpbqk8B7dj68wli
         4xnA==
X-Forwarded-Encrypted: i=1; AKwUvByIpU3GNs8GUqDe670KMeH0IhxfjvPe3IdLj4dqd0wEnpX8s3O98k+aXMhXr5zD6FbxWFucE7o=@vger.kernel.org
X-Gm-Message-State: AFuF++mwsmOQrkMGMilhA1aZrpgsoR99oL57ROfu7JRwx47KQxeNsAAp
	utGt7qIvlaOs15PhxKdo8vIwiiJie1gMS2+m5djYljxyk7Jf5J69zdRE
X-Gm-Gg: AYBFou37iA5Ivp3zXfeNtqyT3HXy3EhlEbJmgZDtUF9ZYZerHhXdrA/yRHG9qmp62xj
	SEx3N/k7LYhCIuvC+fSx1ug6NWaeGqCQrJ5gV/oFQ1Ig0BvwyW+cqu7o1+4B2GXr+BUFc930sUe
	3D9Z7BFRfIqVBhApjKxue1HrvX4P+1klzsW4kpOhpCuryaaKccJlU/A84K3MtY4xvy+iWE1Ov7A
	/HMramcV5WR2KRVpW6QgUb15RUZ0B/J6GD/Pki3qhZuutVTTsY9fU4zOu+c8u757eiBH0mCG5JE
	MrNwpgMChXkJiGEOPKpuZm/9sGKKXDbgxQnXog5EqWwpZSiAAk//u0eI8Ro+AyUgTda2/Jndu6c
	JGDmzAoCFk1c2dmhjePKOrJ/kS7GVO9PUyFBa58B7qZVkgcmgduWRFjbVIjfaXpJGZjjxm12XFY
	1dmiLIHE8sgaQS+iY988crkOE0fQ1p7OaYOcq0gb1nh1rSMl+GdYBjVlFXfGoUIc+SZ6dha4DMZ
	+dV0mpGiGOtthrNDxu6ADzXbz8MLzQ6hdcnw8hBxyONeGhTd77NEGSol+tCQkwxejPeFRrJUeif
	5n1fCJ94shassM3i+sax8ZZBC79WNWt3
X-Received: by 2002:a05:600c:630a:b0:49e:719e:e215 with SMTP id 5b1f17b1804b1-49fe66fa3d9mr278435715e9.26.1790695064645;
        Tue, 29 Sep 2026 08:17:44 -0700 (PDT)
Received: from Lord-Beerus.station ([31.27.155.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a013cf8402sm10313705e9.2.2026.09.29.08.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 08:17:44 -0700 (PDT)
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
Subject: [PATCH v4 00/13] ARM: dts: imx6ul: Add Variscite VAR-SOM-6UL and DART-6UL
Date: Tue, 29 Sep 2026 17:17:27 +0200
Message-ID: <cover.1790693249.git.stefano.r@variscite.com>
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

The Micrel binding change in patch 5 is needed by the Ethernet PHY
descriptions in this series. The existing boolean definition of
micrel,rmii-reference-clock-select-25-mhz conflicts with the dt-schema
unit check for properties ending in -mhz. The binding now accepts <1>
for 25 MHz selection and limits the property to the applicable PHYs.
Patch 4 changes the Micrel driver to test for property presence without
warning about the numeric value. This preserves its runtime behavior.

Patches 1-3 document the board compatibles for each SoC, patches 4-5
update the Micrel driver and binding, patches 6-9 add reusable DTSI
files, and patch 10 converts the existing Concerto boards. Patches
11-13 add the new i.MX6UL, i.MX6ULL and i.MX6ULZ board DTS files
together with their Makefile targets.

v3->v4:
 - Split the board binding by SoC, keep the existing Concerto compatibles
   while adding new variants, and use the binding's items/enum style.
 - Drop the redundant -board suffix from new Concerto and Symphony
   compatibles; keep the SoM options before the carrier name.
 - Add each SoC's sorted DTB Makefile targets alongside its board DTS
   files, replacing the separate Makefile patch.

v2->v3:
 - Add a Micrel driver fix before the binding change so the numeric
   RMII clock select property does not cause a warning at PHY probe.
 - Specify the 3.3 V ADC reference supply voltage on both modules.
 - Share identical storage and wireless option DTSI files between the
   VAR-SOM-6UL and DART-6UL, and drop unused address and size cells from
   the IW61x SDIO host.
 - Move the Symphony Type-C interrupt pinctrl to the SoC-appropriate
   IOMUX controller, specify falling-edge interrupts for the Type-C
   controller and touchscreens, and disable the actual backlight node
   on the i.MX6ULZ Concerto-Board.
 - Update board includes for the shared option files and sort the
   Variscite DTB targets in the Makefile.

v1->v2:
 - Share the WM8904 codec description between VAR-SOM-6UL and DART-6UL,
   keeping the DART-specific microphone routing in a small wrapper.
 - Consolidate the identical WM8731 descriptions into one shared DTSI
   and update the board includes.

Stefano Radaelli (13):
  dt-bindings: arm: fsl: Add Variscite i.MX6UL board variants
  dt-bindings: arm: fsl: Add Variscite i.MX6ULL board variants
  dt-bindings: arm: fsl: Add Variscite i.MX6ULZ board variants
  net: phy: micrel: Check RMII clock select property presence
  dt-bindings: net: micrel: Fix RMII clock select property type
  ARM: dts: imx6ul: Add Variscite SoM and DART base files
  ARM: dts: imx6ul: Add Variscite audio codec files
  ARM: dts: imx6ul: Add Variscite storage and wireless files
  ARM: dts: imx6ul: Add Variscite carrier board files
  ARM: dts: imx6ul: Reuse Variscite DTSI files for Concerto
  ARM: dts: imx6ul: Add Variscite i.MX6UL board variants
  ARM: dts: imx6ull: Add Variscite i.MX6ULL board variants
  ARM: dts: imx6ulz: Add Variscite i.MX6ULZ board variants

 .../devicetree/bindings/arm/fsl.yaml          | 122 +++++-
 .../devicetree/bindings/net/micrel.yaml       |  27 +-
 arch/arm/boot/dts/nxp/imx/Makefile            |  92 ++++-
 ...x6ull-var-dart-6ulcustomboard-sd-card.dtsi |  31 ++
 ...mx6ul-imx6ull-var-dart-6ulcustomboard.dtsi | 321 ++++++++++++++++
 .../imx/imx6ul-imx6ull-var-dart-wm8904.dtsi   |  17 +
 .../dts/nxp/imx/imx6ul-imx6ull-var-dart.dtsi  | 207 +++++++++++
 .../dts/nxp/imx/imx6ul-imx6ull-var-emmc.dtsi  |  32 ++
 .../dts/nxp/imx/imx6ul-imx6ull-var-nand.dtsi  |  63 ++++
 ...mx6ull-var-som-concerto-board-sd-card.dtsi |  42 +++
 ...imx6ul-imx6ull-var-som-concerto-board.dtsi | 350 ++++++++++++++++++
 ...imx6ul-imx6ull-var-som-symphony-board.dtsi | 311 ++++++++++++++++
 ...ommon.dtsi => imx6ul-imx6ull-var-som.dtsi} | 222 +++++------
 .../nxp/imx/imx6ul-imx6ull-var-wifi-brcm.dtsi |  42 +++
 .../imx/imx6ul-imx6ull-var-wifi-iw61x.dtsi    |  43 +++
 .../nxp/imx/imx6ul-imx6ull-var-wm8731.dtsi    |  71 ++++
 .../nxp/imx/imx6ul-imx6ull-var-wm8904.dtsi    |  85 +++++
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
 .../imx/imx6ul-var-som-symphony-board.dtsi    |  96 +++++
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
 .../imx/imx6ull-var-som-symphony-board.dtsi   |  96 +++++
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
 .../imx/imx6ulz-var-som-concerto-board.dtsi   |  42 +++
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
 .../imx/imx6ulz-var-som-symphony-board.dtsi   |  32 ++
 .../arm/boot/dts/nxp/imx/imx6ulz-var-som.dtsi |  38 ++
 drivers/net/phy/micrel.c                      |   2 +-
 134 files changed, 4393 insertions(+), 759 deletions(-)
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-dart-6ulcustomboard-sd-card.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-dart-6ulcustomboard.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-dart-wm8904.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-dart.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-emmc.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-nand.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-som-concerto-board-sd-card.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-som-concerto-board.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-som-symphony-board.dtsi
 rename arch/arm/boot/dts/nxp/imx/{imx6ul-var-som-common.dtsi => imx6ul-imx6ull-var-som.dtsi} (50%)
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-wifi-brcm.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-wifi-iw61x.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-wm8731.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-wm8904.dtsi
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


base-commit: 40f1b207d21530e10f05b9eaf892b4358a1f1151
prerequisite-patch-id: 62880c8f7160273c15e5f475f04804d086a9ad1c
prerequisite-patch-id: 3781017f0aa27eb7d57197b467a9d9f81413cbc5
prerequisite-patch-id: 962922a4574df33d18b523748560b1ca3ee585a9
prerequisite-patch-id: 5bf320ed451409bce6cfc3048175851591a5f3dd
prerequisite-patch-id: 3bea4f196ea1526f0cd1ad4337bf9611c87f0555
prerequisite-patch-id: 1ad35198902e1c7ec2611292e9972eb7123a0f90
prerequisite-patch-id: 5b23703c0c731b5f296aaee487e7b577eb61e636
prerequisite-patch-id: 26687fecbd89ceb0dc62f9d9680649689a8c5066
prerequisite-patch-id: 96a89f7a1f14d8fac73a524eba728ba594ed57c8
prerequisite-patch-id: 68ac4290d5853a834aa80539b945f805f4b876e6
prerequisite-patch-id: fde30f2299fa6524df7b8b36b662bc84bac587e9
prerequisite-patch-id: 69642026b477d3cd8ccb4c52e4045450ccc34f46
prerequisite-patch-id: 86729524d0971905b2d22294e2e1a6839de6d5bb
prerequisite-patch-id: 30e7506837377b52e75815b2fc55145b4eec3ede
prerequisite-patch-id: a81285c549c9fdf666075725a5ee38dba340e555
prerequisite-patch-id: 07d9e9852c096ec14d0aee6c607b0434e0abf3ae
prerequisite-patch-id: ef8429c8fec77bcba99b32ac47529597cb2ad9e4
prerequisite-patch-id: ca2bc56305831fd058562952bd488d86cee7f400
prerequisite-patch-id: 43731e74e6aaf848816bf574fdd9be0b01b4b94d
prerequisite-patch-id: dc5229856996362403d6a767ecbbe65c42189219
prerequisite-patch-id: dd6674b31278dd07dd4b455ac08bd0bd5474bc82
prerequisite-patch-id: 4084e9a7ceeda61006b251558204b28dd1a3aa48
prerequisite-patch-id: ccfe25543d430411ec3d900514a5b0a96a5b5cce
prerequisite-patch-id: ef37b3260b07b0dc4f3f4f8dbf18475b91cfb2f1
prerequisite-patch-id: ae2a9b239b640125e7b367137a4eb71aaf468c69
prerequisite-patch-id: bb7c530f09e10d8519ecc72b2245450b432d76bf
prerequisite-patch-id: 8a5077ba68c33a06e3afdec671457d8e635c2e21
prerequisite-patch-id: 49ecd2b6a4a9f08ddb36f02f8fc067a4e93d3494
prerequisite-patch-id: 1fa3df17af62f6daedf2b2eea4c9eee74560f412
prerequisite-patch-id: 95d94068c9fa17f737f9d318e264bcd87cf19485
prerequisite-patch-id: 0afadd49a2b8d8c66452d7669f88937a02cef6f9
prerequisite-patch-id: 8be2b5d331f3172e5ec0f66415faa807ac246d8c
prerequisite-patch-id: accdb7d4195ddb65e169b61e1eebf6b20e876365
prerequisite-patch-id: 99ddad7ca8ba6845bdece45a476065569177111e
prerequisite-patch-id: 885543ce35f74b8a275b8684280353a505ee54a9
prerequisite-patch-id: fd0a58131f90dedc64de3c9a5359f1092adf9792
prerequisite-patch-id: 5b13f0e98ba023c00e766ff7a7bf0dec973cd6fc
prerequisite-patch-id: 5bca98720f574bccedb60842ac22baab17d3853b
prerequisite-patch-id: aea30b0f8becd1d55f2708256e1ea0b4a39c5f32
prerequisite-patch-id: 003af244d659e19eabbc18c831fdb4417ab0aa93
prerequisite-patch-id: cd18912da6f686645dce19acc85f3166fa4d1754
prerequisite-patch-id: 7f3d663b4c8e0bd9453db82a7f04f5b10512d2c4
prerequisite-patch-id: 8173e35500aa727a566ccbb5c1315da48dec0ff2
prerequisite-patch-id: 618bccee5b75da9c7f71b01349661aaa5a62d6b7
prerequisite-patch-id: 2112ea77d9b97a2f535df903164846a3b5c1dccf
prerequisite-patch-id: 4b31796fcd969191f8164763118f852ce9c601b6
prerequisite-patch-id: c366d6181262c19f6cada97b73a93e233415a969
prerequisite-patch-id: 033cf627399f3aa5a29eba3cc28d5fe256e42172
prerequisite-patch-id: d6ca563a70c82c7e78d1d00a283da934a377d06b
prerequisite-patch-id: 5bac5fbf12fc4586308c01207938182cbb96bb4e
prerequisite-patch-id: 69c2859da980e897e77a4756fd47ba34aff82237
prerequisite-patch-id: 07b739d9c50aa49ff684d7b890b0d7e653b712ac
prerequisite-patch-id: 869b64db36883ae2a83fa0ca173719f947c7dee7
prerequisite-patch-id: f45b5a6676093073a3f1a555f0f0b71d1e9df36d
prerequisite-patch-id: cb5c76a5e3d6d17cd181870afa600b544e7de63e
prerequisite-patch-id: 8dde1759cb4fee2fdd640ad1046bd4261385b974
prerequisite-patch-id: dc08cdff0c43809bb0ae4abaea5193fc2fb4492e
prerequisite-patch-id: 8b9097152068bd100c855dd40aa25537424fdb9b
prerequisite-patch-id: 7a3fc276014dc2097ee88188172868dec827aca7
prerequisite-patch-id: 470e45e6f2d773c0a4916ecb346ec053efb4fd47
prerequisite-patch-id: 8004b6d39592fb0cda5e15ec1d15128e0938fefc
prerequisite-patch-id: 04c000171598bf4f2b86a4aaa2c61101bef6a5a3
prerequisite-patch-id: ee9ab371ff54b3ef7111bde1bee8a1bd0ff11c19
prerequisite-patch-id: 802fae1b5f2f683392c781053cd3adc05529d6c6
prerequisite-patch-id: 3682aeceba2fc75bdfc942904646f7bb08712359
prerequisite-patch-id: e03b718882a611f7c280d48868a75c8e1ca1d708
prerequisite-patch-id: 112c1343712e01ad835640897c3c93032a1dc359
prerequisite-patch-id: 73b3ddfdb23233865ec9930c5512167f3124b97c
prerequisite-patch-id: 510185d967cd33fd6c047ae28b840fc5dea3b71a
prerequisite-patch-id: dbed47ecb907f6b7f7e284c5c1a3c325566eafd7
prerequisite-patch-id: f99da6f44457672c2c9b2cc07ef2bf431223c4b9
prerequisite-patch-id: a546073a5b47cc429a61a9aa4e03bef671bc26bf
prerequisite-patch-id: fc920547c252d9cbe133409902d84f17f3eed5b5
prerequisite-patch-id: c145bc21efe0c58c600d250e64d48f43239c5306
prerequisite-patch-id: 46e5613f6463440d7e0a99d90daa170e93ea162b
prerequisite-patch-id: abb2de3b31e12699e6d3b64b7780f86ce5f7fcb2
prerequisite-patch-id: 9551acc715b965ac3e50aea1e8d4bde7bf084c9e
prerequisite-patch-id: 864b87775c334dc222fd449827e02545cb1b710a
prerequisite-patch-id: 4ab2bea80f7aab894db8c0ca177253863e619ac7
prerequisite-patch-id: d1450cb5c986d888af38ce3f8eb375ae2b7b1edd
prerequisite-patch-id: a3a32bd1f429764997bf80c85ba7fdc13650d70c
prerequisite-patch-id: bfcb70843f1109dcc889b4628d9753fd4d6f4169
prerequisite-patch-id: 8a6f763500955fb3fbb340c68c59304956f9fc95
-- 
2.47.3
