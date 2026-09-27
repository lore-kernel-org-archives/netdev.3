Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD983EC83F
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 12:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790513223; cv=none; b=eckav8znC39rnucIqENza8DergASvg0CjkME6w0aRffZOLbqWhTlikECeJ7rglIKV3p+lJnf6Igu/oeRmeXtcsPOD7e0w5L5WYiJOgPLd93Jx10uIcJ3xxhd2Cs+vylZGjdzIxDer1OzbPQVm+2HIaMuyLulLG1ypuFDhjk8pAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790513223; c=relaxed/simple;
	bh=XIXZf4f4ZYq+IcvRrJKmve5uw6vcjrjP6N+s9X21ehM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ghDojr9vR/oOMxGDIzAX+3h07UZZVKk5J99OBv49poYAQEtXPdrQk1w7c33VofoeRg0L/T/wFCDtgRpX4+q9b0k4uwR/yFCrKltfUwjdiE6MZiW5bs5U/sT/78QkF+UlFXSeEp0+6VNVAAQJTXOFcWtRYALUTARcEBarNVzRG50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o5zTv+ZX; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o5zTv+ZX"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffde3cec6so3825195e9.3
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 05:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790513214; x=1791118014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=us7fHF9BNlmKtu8l+ybnXkWYHXTgCcMVeTvTiMnpwU4=;
        b=o5zTv+ZXXOYA9+NCoeVVTB9sw0M7htFgw1+a7ZxVdDxvyBjBI4+jUAvLVB7xBnana8
         gAO3/Ws0KVJo2f9XmSTeMZaTEcTyA1YVAOHoSGFK6XJUPXeRBK/CMz5FR1ZZBn0+tIlJ
         uTI5Iz2sFra/gc1WtpjduX5u283WO9X2vhsfwY6MtrfFvlMXY6vFH3M3j4KhLBwgxV03
         XWFUggb1gEnNZESbumGezDNpED4dVkFJhLn0Njkgpl/LSx6wUdNfAzcmgTXuPwQb17pT
         OEAkDqxZrOt2Pk2XSQISRsKyMLjgHYxqlCRkruq5vq1p/founv8RgSVFmAaGOWn+a23M
         8cLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790513214; x=1791118014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=us7fHF9BNlmKtu8l+ybnXkWYHXTgCcMVeTvTiMnpwU4=;
        b=E1VgKU8gC2Uco+kSnin51Hc/gq/ie+6LeZ1KLE/Nrb/l3BUOUFCGslHFw+mkhZ1j7H
         tfm89DzSnDxBafXLwMaewGPDHVC23kEhMPNrAHgCXqDkNlTMobuaVA2DU5hL2y6j5kP+
         CxGwp9QdgEMnDSekK4yZVK7awYF3rP+XY0n5q9AlBKjPlPFOS84PH6l1r7q+kclaLOuP
         tWBR+67gVdt69Dsjh6Pkl0F+F6qtT9hBkuxhQ35vDHHPXuRBYZJk8mapep9IUO3Q+Uxf
         v113DtspCtDt1F8txw1o+jR6M3md6GOj7JupcxqgBGYX5J6All2wUTxTVuAPjWn7U4v3
         uYrg==
X-Forwarded-Encrypted: i=1; AKwUvBzPZp4yn+yMonE3w6SDlH7QQ9vmpV8YjcsIUcDmCjcuHKd04MqvqsE3LHD7zU+NrjuVYbO480g=@vger.kernel.org
X-Gm-Message-State: AFuF++lNjVoxHvoK+wqlrS6A2FS5nqR/uuJ3y6LSUGePk+kBb/eA2G24
	50O8nyl0GEr3o03by6cE8nDU3L2bWe8UfV2sAwoFVz+x5RKgEKzAhE7z
X-Gm-Gg: AYBFou2Tpa7vN8ene+X/5YCH+3ULV1A2o1bMrU8v24q8BUPy0eFQDRMmUR4Cb+HPai2
	A5jT0RGfYg8DGV2WfSukZZkO2tAYpdzCJtiGtHCY2HerXkYVOzlVGRKE0l2QcDk6BgR3lhwuhrG
	52VxeRLdgcaKDZ3Wu/HY7rvrQanZfFHehBizrI8Icrre5zb0VyFlgsxmRulJ3UvxzsgvP3D+Nst
	WYv48X7TF4jQCmfZi/hAYRTypIo4wkqe5iA6QyzTndmluYkWEZsoGvQ5XL6TnZUGevqcSyHArRM
	DqbB58lLAPt8gFYhEKAPpUHxIKJz9cF3vNYXPuLE9eP+LsN4t0cWASB996XQOrRJS+LgSnTCAo7
	KEXxoICOXtzbn3qDUc/6eFMd1vlMJ+HcYe4nQwT5DyEyS0X8L7ZZQYhOOYku1KS9kWRdp8ApQbC
	FvK34qaSky04Ufg6/2fb/nczr3bFLFtDokbhbigGQ5jVSvEsmU6E6M1K3yZaGY+F1YGCENKhtv8
	PGDabRA9Jz4Ts16l04sKtfLQq9JmYSht6YaguXTVjgQep235YZU0IlzfNQJEnA0rheNVYzvDleN
	GVGQtVgADfZpSLQlytTaMg==
X-Received: by 2002:a05:600c:a08:b0:49e:73e7:888c with SMTP id 5b1f17b1804b1-49fe66c8a3emr199937725e9.4.1790513214281;
        Sun, 27 Sep 2026 05:46:54 -0700 (PDT)
Received: from Lord-Beerus.station ([31.27.155.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fef60da94sm148440605e9.4.2026.09.27.05.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 05:46:52 -0700 (PDT)
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
Subject: [PATCH v3 10/12] ARM: dts: imx6ull: Add Variscite i.MX6ULL board variants
Date: Sun, 27 Sep 2026 14:46:25 +0200
Message-ID: <a9c46d096a221302c3a775ec456f104acffc161c.1790512621.git.stefano.r@variscite.com>
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

Add i.MX6ULL board DTS files for VAR-SOM-6UL and DART-6UL with their
carrier, storage, wireless and audio options.

Reuse the shared option and carrier descriptions with the i.MX6ULL
SoC and module wrappers.

Signed-off-by: Stefano Radaelli <stefano.r@variscite.com>
---
v2->v3:
 - Use the shared storage and wireless option DTSI files.

v1->v2:
 - Update audio includes for the shared WM8904 and WM8731 files.

 ...l-var-dart-emmc-sd-card-6ulcustomboard.dts | 20 +++++++++++++++++++
 ...art-emmc-sd-card-wm8731-6ulcustomboard.dts | 20 +++++++++++++++++++
 ...var-dart-emmc-wifi-brcm-6ulcustomboard.dts | 20 +++++++++++++++++++
 ...t-emmc-wifi-brcm-wm8731-6ulcustomboard.dts | 20 +++++++++++++++++++
 ...ar-dart-emmc-wifi-iw61x-6ulcustomboard.dts | 20 +++++++++++++++++++
 ...l-var-dart-nand-sd-card-6ulcustomboard.dts | 20 +++++++++++++++++++
 ...art-nand-sd-card-wm8731-6ulcustomboard.dts | 20 +++++++++++++++++++
 ...var-dart-nand-wifi-brcm-6ulcustomboard.dts | 20 +++++++++++++++++++
 ...t-nand-wifi-brcm-wm8731-6ulcustomboard.dts | 20 +++++++++++++++++++
 ...ar-dart-nand-wifi-iw61x-6ulcustomboard.dts | 20 +++++++++++++++++++
 ...ll-var-som-emmc-sd-card-concerto-board.dts | 20 +++++++++++++++++++
 ...ll-var-som-emmc-sd-card-symphony-board.dts | 20 +++++++++++++++++++
 ...som-emmc-sd-card-wm8731-concerto-board.dts | 20 +++++++++++++++++++
 ...som-emmc-sd-card-wm8731-symphony-board.dts | 20 +++++++++++++++++++
 ...-var-som-emmc-wifi-brcm-concerto-board.dts | 20 +++++++++++++++++++
 ...-var-som-emmc-wifi-brcm-symphony-board.dts | 20 +++++++++++++++++++
 ...m-emmc-wifi-brcm-wm8731-concerto-board.dts | 20 +++++++++++++++++++
 ...m-emmc-wifi-brcm-wm8731-symphony-board.dts | 20 +++++++++++++++++++
 ...var-som-emmc-wifi-iw61x-concerto-board.dts | 20 +++++++++++++++++++
 ...var-som-emmc-wifi-iw61x-symphony-board.dts | 20 +++++++++++++++++++
 ...ll-var-som-nand-sd-card-concerto-board.dts | 20 +++++++++++++++++++
 ...ll-var-som-nand-sd-card-symphony-board.dts | 20 +++++++++++++++++++
 ...som-nand-sd-card-wm8731-concerto-board.dts | 20 +++++++++++++++++++
 ...som-nand-sd-card-wm8731-symphony-board.dts | 20 +++++++++++++++++++
 ...-var-som-nand-wifi-brcm-concerto-board.dts | 20 +++++++++++++++++++
 ...-var-som-nand-wifi-brcm-symphony-board.dts | 20 +++++++++++++++++++
 ...m-nand-wifi-brcm-wm8731-concerto-board.dts | 20 +++++++++++++++++++
 ...m-nand-wifi-brcm-wm8731-symphony-board.dts | 20 +++++++++++++++++++
 ...var-som-nand-wifi-iw61x-concerto-board.dts | 20 +++++++++++++++++++
 ...var-som-nand-wifi-iw61x-symphony-board.dts | 20 +++++++++++++++++++
 30 files changed, 600 insertions(+)
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

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-var-dart-emmc-sd-card-6ulcustomboard.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-var-dart-emmc-sd-card-6ulcustomboard.dts
new file mode 100644
index 000000000000..ea8bf022744c
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-var-dart-emmc-sd-card-6ulcustomboard.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ull.dtsi"
+#include "imx6ull-var-dart.dtsi"
+#include "imx6ul-imx6ull-var-emmc.dtsi"
+#include "imx6ul-imx6ull-var-dart-wm8904.dtsi"
+#include "imx6ull-var-dart-6ulcustomboard.dtsi"
+#include "imx6ul-imx6ull-var-dart-6ulcustomboard-sd-card.dtsi"
+
+/ {
+	model = "Variscite DART-6UL with i.MX6ULL, eMMC, SD card & WM8904 support on VAR-6ULCustomBoard";
+	compatible = "variscite,dart-6ul-imx6ull-emmc-sd-card-6ulcustomboard",
+		     "variscite,dart-6ul-imx6ull",
+		     "fsl,imx6ull";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-var-dart-emmc-sd-card-wm8731-6ulcustomboard.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-var-dart-emmc-sd-card-wm8731-6ulcustomboard.dts
new file mode 100644
index 000000000000..b0f02ebf158c
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-var-dart-emmc-sd-card-wm8731-6ulcustomboard.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ull.dtsi"
+#include "imx6ull-var-dart.dtsi"
+#include "imx6ul-imx6ull-var-emmc.dtsi"
+#include "imx6ul-imx6ull-var-wm8731.dtsi"
+#include "imx6ull-var-dart-6ulcustomboard.dtsi"
+#include "imx6ul-imx6ull-var-dart-6ulcustomboard-sd-card.dtsi"
+
+/ {
+	model = "Variscite DART-6UL with i.MX6ULL, eMMC, SD card & WM8731 support on VAR-6ULCustomBoard";
+	compatible = "variscite,dart-6ul-imx6ull-emmc-sd-card-wm8731-6ulcustomboard",
+		     "variscite,dart-6ul-imx6ull",
+		     "fsl,imx6ull";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-var-dart-emmc-wifi-brcm-6ulcustomboard.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-var-dart-emmc-wifi-brcm-6ulcustomboard.dts
new file mode 100644
index 000000000000..6e6a2c8ca180
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-var-dart-emmc-wifi-brcm-6ulcustomboard.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ull.dtsi"
+#include "imx6ull-var-dart.dtsi"
+#include "imx6ul-imx6ull-var-emmc.dtsi"
+#include "imx6ul-imx6ull-var-wifi-brcm.dtsi"
+#include "imx6ul-imx6ull-var-dart-wm8904.dtsi"
+#include "imx6ull-var-dart-6ulcustomboard.dtsi"
+
+/ {
+	model = "Variscite DART-6UL with i.MX6ULL, eMMC, WiFi BRCM & WM8904 support on VAR-6ULCustomBoard";
+	compatible = "variscite,dart-6ul-imx6ull-emmc-wifi-brcm-6ulcustomboard",
+		     "variscite,dart-6ul-imx6ull",
+		     "fsl,imx6ull";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-var-dart-emmc-wifi-brcm-wm8731-6ulcustomboard.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-var-dart-emmc-wifi-brcm-wm8731-6ulcustomboard.dts
new file mode 100644
index 000000000000..7af5fe7dc1fb
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-var-dart-emmc-wifi-brcm-wm8731-6ulcustomboard.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ull.dtsi"
+#include "imx6ull-var-dart.dtsi"
+#include "imx6ul-imx6ull-var-emmc.dtsi"
+#include "imx6ul-imx6ull-var-wifi-brcm.dtsi"
+#include "imx6ul-imx6ull-var-wm8731.dtsi"
+#include "imx6ull-var-dart-6ulcustomboard.dtsi"
+
+/ {
+	model = "Variscite DART-6UL with i.MX6ULL, eMMC, WiFi BRCM & WM8731 support on VAR-6ULCustomBoard";
+	compatible = "variscite,dart-6ul-imx6ull-emmc-wifi-brcm-wm8731-6ulcustomboard",
+		     "variscite,dart-6ul-imx6ull",
+		     "fsl,imx6ull";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-var-dart-emmc-wifi-iw61x-6ulcustomboard.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-var-dart-emmc-wifi-iw61x-6ulcustomboard.dts
new file mode 100644
index 000000000000..26d266d731fb
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-var-dart-emmc-wifi-iw61x-6ulcustomboard.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ull.dtsi"
+#include "imx6ull-var-dart.dtsi"
+#include "imx6ul-imx6ull-var-emmc.dtsi"
+#include "imx6ul-imx6ull-var-wifi-iw61x.dtsi"
+#include "imx6ul-imx6ull-var-dart-wm8904.dtsi"
+#include "imx6ull-var-dart-6ulcustomboard.dtsi"
+
+/ {
+	model = "Variscite DART-6UL with i.MX6ULL, eMMC, WiFi IW61x & WM8904 support on VAR-6ULCustomBoard";
+	compatible = "variscite,dart-6ul-imx6ull-emmc-wifi-iw61x-6ulcustomboard",
+		     "variscite,dart-6ul-imx6ull",
+		     "fsl,imx6ull";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-var-dart-nand-sd-card-6ulcustomboard.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-var-dart-nand-sd-card-6ulcustomboard.dts
new file mode 100644
index 000000000000..617bccd11457
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-var-dart-nand-sd-card-6ulcustomboard.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ull.dtsi"
+#include "imx6ull-var-dart.dtsi"
+#include "imx6ul-imx6ull-var-nand.dtsi"
+#include "imx6ul-imx6ull-var-dart-wm8904.dtsi"
+#include "imx6ull-var-dart-6ulcustomboard.dtsi"
+#include "imx6ul-imx6ull-var-dart-6ulcustomboard-sd-card.dtsi"
+
+/ {
+	model = "Variscite DART-6UL with i.MX6ULL, NAND flash, SD card & WM8904 support on VAR-6ULCustomBoard";
+	compatible = "variscite,dart-6ul-imx6ull-nand-sd-card-6ulcustomboard",
+		     "variscite,dart-6ul-imx6ull",
+		     "fsl,imx6ull";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-var-dart-nand-sd-card-wm8731-6ulcustomboard.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-var-dart-nand-sd-card-wm8731-6ulcustomboard.dts
new file mode 100644
index 000000000000..d983c60015af
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-var-dart-nand-sd-card-wm8731-6ulcustomboard.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ull.dtsi"
+#include "imx6ull-var-dart.dtsi"
+#include "imx6ul-imx6ull-var-nand.dtsi"
+#include "imx6ul-imx6ull-var-wm8731.dtsi"
+#include "imx6ull-var-dart-6ulcustomboard.dtsi"
+#include "imx6ul-imx6ull-var-dart-6ulcustomboard-sd-card.dtsi"
+
+/ {
+	model = "Variscite DART-6UL with i.MX6ULL, NAND flash, SD card & WM8731 support on VAR-6ULCustomBoard";
+	compatible = "variscite,dart-6ul-imx6ull-nand-sd-card-wm8731-6ulcustomboard",
+		     "variscite,dart-6ul-imx6ull",
+		     "fsl,imx6ull";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-var-dart-nand-wifi-brcm-6ulcustomboard.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-var-dart-nand-wifi-brcm-6ulcustomboard.dts
new file mode 100644
index 000000000000..8d1620bc1209
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-var-dart-nand-wifi-brcm-6ulcustomboard.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ull.dtsi"
+#include "imx6ull-var-dart.dtsi"
+#include "imx6ul-imx6ull-var-nand.dtsi"
+#include "imx6ul-imx6ull-var-wifi-brcm.dtsi"
+#include "imx6ul-imx6ull-var-dart-wm8904.dtsi"
+#include "imx6ull-var-dart-6ulcustomboard.dtsi"
+
+/ {
+	model = "Variscite DART-6UL with i.MX6ULL, NAND flash, WiFi BRCM & WM8904 support on VAR-6ULCustomBoard";
+	compatible = "variscite,dart-6ul-imx6ull-nand-wifi-brcm-6ulcustomboard",
+		     "variscite,dart-6ul-imx6ull",
+		     "fsl,imx6ull";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-var-dart-nand-wifi-brcm-wm8731-6ulcustomboard.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-var-dart-nand-wifi-brcm-wm8731-6ulcustomboard.dts
new file mode 100644
index 000000000000..3c33aff6687e
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-var-dart-nand-wifi-brcm-wm8731-6ulcustomboard.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ull.dtsi"
+#include "imx6ull-var-dart.dtsi"
+#include "imx6ul-imx6ull-var-nand.dtsi"
+#include "imx6ul-imx6ull-var-wifi-brcm.dtsi"
+#include "imx6ul-imx6ull-var-wm8731.dtsi"
+#include "imx6ull-var-dart-6ulcustomboard.dtsi"
+
+/ {
+	model = "Variscite DART-6UL with i.MX6ULL, NAND flash, WiFi BRCM & WM8731 support on VAR-6ULCustomBoard";
+	compatible = "variscite,dart-6ul-imx6ull-nand-wifi-brcm-wm8731-6ulcustomboard",
+		     "variscite,dart-6ul-imx6ull",
+		     "fsl,imx6ull";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-var-dart-nand-wifi-iw61x-6ulcustomboard.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-var-dart-nand-wifi-iw61x-6ulcustomboard.dts
new file mode 100644
index 000000000000..061b427be774
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-var-dart-nand-wifi-iw61x-6ulcustomboard.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ull.dtsi"
+#include "imx6ull-var-dart.dtsi"
+#include "imx6ul-imx6ull-var-nand.dtsi"
+#include "imx6ul-imx6ull-var-wifi-iw61x.dtsi"
+#include "imx6ul-imx6ull-var-dart-wm8904.dtsi"
+#include "imx6ull-var-dart-6ulcustomboard.dtsi"
+
+/ {
+	model = "Variscite DART-6UL with i.MX6ULL, NAND flash, WiFi IW61x & WM8904 support on VAR-6ULCustomBoard";
+	compatible = "variscite,dart-6ul-imx6ull-nand-wifi-iw61x-6ulcustomboard",
+		     "variscite,dart-6ul-imx6ull",
+		     "fsl,imx6ull";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-emmc-sd-card-concerto-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-emmc-sd-card-concerto-board.dts
new file mode 100644
index 000000000000..5c992800d4df
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-emmc-sd-card-concerto-board.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ull.dtsi"
+#include "imx6ull-var-som.dtsi"
+#include "imx6ul-imx6ull-var-emmc.dtsi"
+#include "imx6ul-imx6ull-var-wm8904.dtsi"
+#include "imx6ull-var-som-concerto-board.dtsi"
+#include "imx6ul-imx6ull-var-som-concerto-board-sd-card.dtsi"
+
+/ {
+	model = "Variscite VAR-SOM-6UL with i.MX6ULL, eMMC, SD card & WM8904 support on Concerto-Board";
+	compatible = "variscite,var-som-imx6ull-emmc-sd-card-concerto-board",
+		     "variscite,var-som-imx6ull",
+		     "fsl,imx6ull";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-emmc-sd-card-symphony-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-emmc-sd-card-symphony-board.dts
new file mode 100644
index 000000000000..0460994a88ec
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-emmc-sd-card-symphony-board.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ull.dtsi"
+#include "imx6ull-var-som.dtsi"
+#include "imx6ul-imx6ull-var-emmc.dtsi"
+#include "imx6ul-imx6ull-var-wm8904.dtsi"
+#include "imx6ull-var-som-symphony-board.dtsi"
+#include "imx6ul-imx6ull-var-som-concerto-board-sd-card.dtsi"
+
+/ {
+	model = "Variscite VAR-SOM-6UL with i.MX6ULL, eMMC, SD card & WM8904 support on Symphony-Board";
+	compatible = "variscite,var-som-imx6ull-emmc-sd-card-symphony-board",
+		     "variscite,var-som-imx6ull",
+		     "fsl,imx6ull";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-emmc-sd-card-wm8731-concerto-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-emmc-sd-card-wm8731-concerto-board.dts
new file mode 100644
index 000000000000..341252c08697
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-emmc-sd-card-wm8731-concerto-board.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ull.dtsi"
+#include "imx6ull-var-som.dtsi"
+#include "imx6ul-imx6ull-var-emmc.dtsi"
+#include "imx6ul-imx6ull-var-wm8731.dtsi"
+#include "imx6ull-var-som-concerto-board.dtsi"
+#include "imx6ul-imx6ull-var-som-concerto-board-sd-card.dtsi"
+
+/ {
+	model = "Variscite VAR-SOM-6UL with i.MX6ULL, eMMC, SD card & WM8731 support on Concerto-Board";
+	compatible = "variscite,var-som-imx6ull-emmc-sd-card-wm8731-concerto-board",
+		     "variscite,var-som-imx6ull",
+		     "fsl,imx6ull";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-emmc-sd-card-wm8731-symphony-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-emmc-sd-card-wm8731-symphony-board.dts
new file mode 100644
index 000000000000..8f88432262b4
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-emmc-sd-card-wm8731-symphony-board.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ull.dtsi"
+#include "imx6ull-var-som.dtsi"
+#include "imx6ul-imx6ull-var-emmc.dtsi"
+#include "imx6ul-imx6ull-var-wm8731.dtsi"
+#include "imx6ull-var-som-symphony-board.dtsi"
+#include "imx6ul-imx6ull-var-som-concerto-board-sd-card.dtsi"
+
+/ {
+	model = "Variscite VAR-SOM-6UL with i.MX6ULL, eMMC, SD card & WM8731 support on Symphony-Board";
+	compatible = "variscite,var-som-imx6ull-emmc-sd-card-wm8731-symphony-board",
+		     "variscite,var-som-imx6ull",
+		     "fsl,imx6ull";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-emmc-wifi-brcm-concerto-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-emmc-wifi-brcm-concerto-board.dts
new file mode 100644
index 000000000000..a7085c837adf
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-emmc-wifi-brcm-concerto-board.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ull.dtsi"
+#include "imx6ull-var-som.dtsi"
+#include "imx6ul-imx6ull-var-emmc.dtsi"
+#include "imx6ul-imx6ull-var-wifi-brcm.dtsi"
+#include "imx6ul-imx6ull-var-wm8904.dtsi"
+#include "imx6ull-var-som-concerto-board.dtsi"
+
+/ {
+	model = "Variscite VAR-SOM-6UL with i.MX6ULL, eMMC, WiFi BRCM & WM8904 support on Concerto-Board";
+	compatible = "variscite,var-som-imx6ull-emmc-wifi-brcm-concerto-board",
+		     "variscite,var-som-imx6ull",
+		     "fsl,imx6ull";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-emmc-wifi-brcm-symphony-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-emmc-wifi-brcm-symphony-board.dts
new file mode 100644
index 000000000000..6794d727c533
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-emmc-wifi-brcm-symphony-board.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ull.dtsi"
+#include "imx6ull-var-som.dtsi"
+#include "imx6ul-imx6ull-var-emmc.dtsi"
+#include "imx6ul-imx6ull-var-wifi-brcm.dtsi"
+#include "imx6ul-imx6ull-var-wm8904.dtsi"
+#include "imx6ull-var-som-symphony-board.dtsi"
+
+/ {
+	model = "Variscite VAR-SOM-6UL with i.MX6ULL, eMMC, WiFi BRCM & WM8904 support on Symphony-Board";
+	compatible = "variscite,var-som-imx6ull-emmc-wifi-brcm-symphony-board",
+		     "variscite,var-som-imx6ull",
+		     "fsl,imx6ull";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-emmc-wifi-brcm-wm8731-concerto-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-emmc-wifi-brcm-wm8731-concerto-board.dts
new file mode 100644
index 000000000000..4987dc60be40
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-emmc-wifi-brcm-wm8731-concerto-board.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ull.dtsi"
+#include "imx6ull-var-som.dtsi"
+#include "imx6ul-imx6ull-var-emmc.dtsi"
+#include "imx6ul-imx6ull-var-wifi-brcm.dtsi"
+#include "imx6ul-imx6ull-var-wm8731.dtsi"
+#include "imx6ull-var-som-concerto-board.dtsi"
+
+/ {
+	model = "Variscite VAR-SOM-6UL with i.MX6ULL, eMMC, WiFi BRCM & WM8731 support on Concerto-Board";
+	compatible = "variscite,var-som-imx6ull-emmc-wifi-brcm-wm8731-concerto-board",
+		     "variscite,var-som-imx6ull",
+		     "fsl,imx6ull";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-emmc-wifi-brcm-wm8731-symphony-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-emmc-wifi-brcm-wm8731-symphony-board.dts
new file mode 100644
index 000000000000..2222bbefa2b9
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-emmc-wifi-brcm-wm8731-symphony-board.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ull.dtsi"
+#include "imx6ull-var-som.dtsi"
+#include "imx6ul-imx6ull-var-emmc.dtsi"
+#include "imx6ul-imx6ull-var-wifi-brcm.dtsi"
+#include "imx6ul-imx6ull-var-wm8731.dtsi"
+#include "imx6ull-var-som-symphony-board.dtsi"
+
+/ {
+	model = "Variscite VAR-SOM-6UL with i.MX6ULL, eMMC, WiFi BRCM & WM8731 support on Symphony-Board";
+	compatible = "variscite,var-som-imx6ull-emmc-wifi-brcm-wm8731-symphony-board",
+		     "variscite,var-som-imx6ull",
+		     "fsl,imx6ull";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-emmc-wifi-iw61x-concerto-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-emmc-wifi-iw61x-concerto-board.dts
new file mode 100644
index 000000000000..9b81aef2f618
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-emmc-wifi-iw61x-concerto-board.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ull.dtsi"
+#include "imx6ull-var-som.dtsi"
+#include "imx6ul-imx6ull-var-emmc.dtsi"
+#include "imx6ul-imx6ull-var-wifi-iw61x.dtsi"
+#include "imx6ul-imx6ull-var-wm8904.dtsi"
+#include "imx6ull-var-som-concerto-board.dtsi"
+
+/ {
+	model = "Variscite VAR-SOM-6UL with i.MX6ULL, eMMC, WiFi IW61x & WM8904 support on Concerto-Board";
+	compatible = "variscite,var-som-imx6ull-emmc-wifi-iw61x-concerto-board",
+		     "variscite,var-som-imx6ull",
+		     "fsl,imx6ull";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-emmc-wifi-iw61x-symphony-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-emmc-wifi-iw61x-symphony-board.dts
new file mode 100644
index 000000000000..6269d432a846
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-emmc-wifi-iw61x-symphony-board.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ull.dtsi"
+#include "imx6ull-var-som.dtsi"
+#include "imx6ul-imx6ull-var-emmc.dtsi"
+#include "imx6ul-imx6ull-var-wifi-iw61x.dtsi"
+#include "imx6ul-imx6ull-var-wm8904.dtsi"
+#include "imx6ull-var-som-symphony-board.dtsi"
+
+/ {
+	model = "Variscite VAR-SOM-6UL with i.MX6ULL, eMMC, WiFi IW61x & WM8904 support on Symphony-Board";
+	compatible = "variscite,var-som-imx6ull-emmc-wifi-iw61x-symphony-board",
+		     "variscite,var-som-imx6ull",
+		     "fsl,imx6ull";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-nand-sd-card-concerto-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-nand-sd-card-concerto-board.dts
new file mode 100644
index 000000000000..5ff9f360b7f2
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-nand-sd-card-concerto-board.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ull.dtsi"
+#include "imx6ull-var-som.dtsi"
+#include "imx6ul-imx6ull-var-nand.dtsi"
+#include "imx6ul-imx6ull-var-wm8904.dtsi"
+#include "imx6ull-var-som-concerto-board.dtsi"
+#include "imx6ul-imx6ull-var-som-concerto-board-sd-card.dtsi"
+
+/ {
+	model = "Variscite VAR-SOM-6UL with i.MX6ULL, NAND flash, SD card & WM8904 support on Concerto-Board";
+	compatible = "variscite,var-som-imx6ull-nand-sd-card-concerto-board",
+		     "variscite,var-som-imx6ull",
+		     "fsl,imx6ull";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-nand-sd-card-symphony-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-nand-sd-card-symphony-board.dts
new file mode 100644
index 000000000000..4afac86bad23
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-nand-sd-card-symphony-board.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ull.dtsi"
+#include "imx6ull-var-som.dtsi"
+#include "imx6ul-imx6ull-var-nand.dtsi"
+#include "imx6ul-imx6ull-var-wm8904.dtsi"
+#include "imx6ull-var-som-symphony-board.dtsi"
+#include "imx6ul-imx6ull-var-som-concerto-board-sd-card.dtsi"
+
+/ {
+	model = "Variscite VAR-SOM-6UL with i.MX6ULL, NAND flash, SD card & WM8904 support on Symphony-Board";
+	compatible = "variscite,var-som-imx6ull-nand-sd-card-symphony-board",
+		     "variscite,var-som-imx6ull",
+		     "fsl,imx6ull";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-nand-sd-card-wm8731-concerto-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-nand-sd-card-wm8731-concerto-board.dts
new file mode 100644
index 000000000000..9f8b8ac9f9ee
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-nand-sd-card-wm8731-concerto-board.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ull.dtsi"
+#include "imx6ull-var-som.dtsi"
+#include "imx6ul-imx6ull-var-nand.dtsi"
+#include "imx6ul-imx6ull-var-wm8731.dtsi"
+#include "imx6ull-var-som-concerto-board.dtsi"
+#include "imx6ul-imx6ull-var-som-concerto-board-sd-card.dtsi"
+
+/ {
+	model = "Variscite VAR-SOM-6UL with i.MX6ULL, NAND flash, SD card & WM8731 support on Concerto-Board";
+	compatible = "variscite,var-som-imx6ull-nand-sd-card-wm8731-concerto-board",
+		     "variscite,var-som-imx6ull",
+		     "fsl,imx6ull";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-nand-sd-card-wm8731-symphony-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-nand-sd-card-wm8731-symphony-board.dts
new file mode 100644
index 000000000000..c496e014fe31
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-nand-sd-card-wm8731-symphony-board.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ull.dtsi"
+#include "imx6ull-var-som.dtsi"
+#include "imx6ul-imx6ull-var-nand.dtsi"
+#include "imx6ul-imx6ull-var-wm8731.dtsi"
+#include "imx6ull-var-som-symphony-board.dtsi"
+#include "imx6ul-imx6ull-var-som-concerto-board-sd-card.dtsi"
+
+/ {
+	model = "Variscite VAR-SOM-6UL with i.MX6ULL, NAND flash, SD card & WM8731 support on Symphony-Board";
+	compatible = "variscite,var-som-imx6ull-nand-sd-card-wm8731-symphony-board",
+		     "variscite,var-som-imx6ull",
+		     "fsl,imx6ull";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-nand-wifi-brcm-concerto-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-nand-wifi-brcm-concerto-board.dts
new file mode 100644
index 000000000000..2e9c22da94e6
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-nand-wifi-brcm-concerto-board.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ull.dtsi"
+#include "imx6ull-var-som.dtsi"
+#include "imx6ul-imx6ull-var-nand.dtsi"
+#include "imx6ul-imx6ull-var-wifi-brcm.dtsi"
+#include "imx6ul-imx6ull-var-wm8904.dtsi"
+#include "imx6ull-var-som-concerto-board.dtsi"
+
+/ {
+	model = "Variscite VAR-SOM-6UL with i.MX6ULL, NAND flash, WiFi BRCM & WM8904 support on Concerto-Board";
+	compatible = "variscite,var-som-imx6ull-nand-wifi-brcm-concerto-board",
+		     "variscite,var-som-imx6ull",
+		     "fsl,imx6ull";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-nand-wifi-brcm-symphony-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-nand-wifi-brcm-symphony-board.dts
new file mode 100644
index 000000000000..6045c936c56e
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-nand-wifi-brcm-symphony-board.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ull.dtsi"
+#include "imx6ull-var-som.dtsi"
+#include "imx6ul-imx6ull-var-nand.dtsi"
+#include "imx6ul-imx6ull-var-wifi-brcm.dtsi"
+#include "imx6ul-imx6ull-var-wm8904.dtsi"
+#include "imx6ull-var-som-symphony-board.dtsi"
+
+/ {
+	model = "Variscite VAR-SOM-6UL with i.MX6ULL, NAND flash, WiFi BRCM & WM8904 support on Symphony-Board";
+	compatible = "variscite,var-som-imx6ull-nand-wifi-brcm-symphony-board",
+		     "variscite,var-som-imx6ull",
+		     "fsl,imx6ull";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-nand-wifi-brcm-wm8731-concerto-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-nand-wifi-brcm-wm8731-concerto-board.dts
new file mode 100644
index 000000000000..6bad17ce5d03
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-nand-wifi-brcm-wm8731-concerto-board.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ull.dtsi"
+#include "imx6ull-var-som.dtsi"
+#include "imx6ul-imx6ull-var-nand.dtsi"
+#include "imx6ul-imx6ull-var-wifi-brcm.dtsi"
+#include "imx6ul-imx6ull-var-wm8731.dtsi"
+#include "imx6ull-var-som-concerto-board.dtsi"
+
+/ {
+	model = "Variscite VAR-SOM-6UL with i.MX6ULL, NAND flash, WiFi BRCM & WM8731 support on Concerto-Board";
+	compatible = "variscite,var-som-imx6ull-nand-wifi-brcm-wm8731-concerto-board",
+		     "variscite,var-som-imx6ull",
+		     "fsl,imx6ull";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-nand-wifi-brcm-wm8731-symphony-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-nand-wifi-brcm-wm8731-symphony-board.dts
new file mode 100644
index 000000000000..d8f55c62dcf7
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-nand-wifi-brcm-wm8731-symphony-board.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ull.dtsi"
+#include "imx6ull-var-som.dtsi"
+#include "imx6ul-imx6ull-var-nand.dtsi"
+#include "imx6ul-imx6ull-var-wifi-brcm.dtsi"
+#include "imx6ul-imx6ull-var-wm8731.dtsi"
+#include "imx6ull-var-som-symphony-board.dtsi"
+
+/ {
+	model = "Variscite VAR-SOM-6UL with i.MX6ULL, NAND flash, WiFi BRCM & WM8731 support on Symphony-Board";
+	compatible = "variscite,var-som-imx6ull-nand-wifi-brcm-wm8731-symphony-board",
+		     "variscite,var-som-imx6ull",
+		     "fsl,imx6ull";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-nand-wifi-iw61x-concerto-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-nand-wifi-iw61x-concerto-board.dts
new file mode 100644
index 000000000000..7152317d89c0
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-nand-wifi-iw61x-concerto-board.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ull.dtsi"
+#include "imx6ull-var-som.dtsi"
+#include "imx6ul-imx6ull-var-nand.dtsi"
+#include "imx6ul-imx6ull-var-wifi-iw61x.dtsi"
+#include "imx6ul-imx6ull-var-wm8904.dtsi"
+#include "imx6ull-var-som-concerto-board.dtsi"
+
+/ {
+	model = "Variscite VAR-SOM-6UL with i.MX6ULL, NAND flash, WiFi IW61x & WM8904 support on Concerto-Board";
+	compatible = "variscite,var-som-imx6ull-nand-wifi-iw61x-concerto-board",
+		     "variscite,var-som-imx6ull",
+		     "fsl,imx6ull";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-nand-wifi-iw61x-symphony-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-nand-wifi-iw61x-symphony-board.dts
new file mode 100644
index 000000000000..aa34127052ea
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-nand-wifi-iw61x-symphony-board.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ull.dtsi"
+#include "imx6ull-var-som.dtsi"
+#include "imx6ul-imx6ull-var-nand.dtsi"
+#include "imx6ul-imx6ull-var-wifi-iw61x.dtsi"
+#include "imx6ul-imx6ull-var-wm8904.dtsi"
+#include "imx6ull-var-som-symphony-board.dtsi"
+
+/ {
+	model = "Variscite VAR-SOM-6UL with i.MX6ULL, NAND flash, WiFi IW61x & WM8904 support on Symphony-Board";
+	compatible = "variscite,var-som-imx6ull-nand-wifi-iw61x-symphony-board",
+		     "variscite,var-som-imx6ull",
+		     "fsl,imx6ull";
+};
-- 
2.47.3
