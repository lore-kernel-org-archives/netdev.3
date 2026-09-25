Received: from mail-wr2-f41.google.com (mail-wr2-f41.google.com [74.125.225.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8949436DA03
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 14:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790345027; cv=none; b=UHQNok1P4CJny8CX56Y6+Ux+698Ll1a1ndwDgxDXVbbeIew/uXW34HtyIzl6SoX+xYeustVpzeykuQ2/Fa/DZWa1BfJ/+ZRHLAWfFOfNxOzUUMydYlnuOjUfcsvGLK+omQktvfsIhdcCDndFEJt80ZGifcBwNoif4vwmQ7q99P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790345027; c=relaxed/simple;
	bh=zP6Gv2Hku5TRgNDhJspei3Kt0G9XDrcRS+UFOXlnCSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SlmviDroSkGSEjIBlDRnGynltixCj894GV3RMh/8eZSYJhCW+KKoDS7wfaGh6p9kijL4oqGVaaWYdfW35JZWuZ5szk3A1tdIeyCRlAlk8cfwKjZrdMi9yawsoUrbgFtJvGvcE3RzaFYEJ19Ie/RWtiaRynU4Jm96DVvu3635Nt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uyq6V2bD; arc=none smtp.client-ip=74.125.225.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uyq6V2bD"
Received: by mail-wr2-f41.google.com with SMTP id ffacd0b85a97d-4834977ae75so550810f8f.3
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 07:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790345020; x=1790949820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tA6YuTlj/hHXsnXQ4mECQmwjSH4aYnwqw+TK2LwAFSY=;
        b=Uyq6V2bDL+5ybMtAkSObHy1Lf1sowbThVY+NoWR5yo2q0TVA5ZLFRbM4EapO+a+H/m
         FcKh4wygW2kMrx6KGQoTRqi2+cf22ADfgivKy1fueg/N+VvRipxiQCGypM8Sr3WE6UcY
         2EAj25hi4R6tox4EcZ41ADvBS6egpa697IZPc69EU86XhNm4EodkCfhBSwBwJfapeQJd
         L/wrZoKJWo8f/NO0lVSHd78Kd9bcp7FbITIqhy7ftgi5c/kLuBLLjD+T3npkliZyvEXh
         BlAiohU1pyesG8NT47tb5jg4W79Kk9yJxlzAxJFbN2OtxL7r+bdfy23cTBpY4dSDpaqb
         ieEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790345021; x=1790949821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tA6YuTlj/hHXsnXQ4mECQmwjSH4aYnwqw+TK2LwAFSY=;
        b=lMe2xe3Zrz2Ah5mVwLq7LTrC5q0yU0EACbSv7o/s6Nfo82l7iG22psqKwhQ1qJhiWB
         TKJsE5nmHGw0dUDph9w5S4QNco5VHSl0wW5IuNQX//GvTP5q0FtglO8eAozIGpTTuBj5
         vrPqaePqi8O3QlNrHPiZ/GFETCT3Ed4CmUecbfZ0VSRjNwUdEE4CzVmWOmbJC+/ZZ8T8
         BBDMSZuCt5o7uUnXMzvceQI20Y/fDSyYDHVFpfz94nVERqYOhE+s08SjJ9WrTW81Akat
         7daCGyioxOHj88ZbHyK3XXZc/JpwUonNiJxrXUF7Gs0EA4/zNjmobMPgaW/Hm4z7tfa1
         5ZqQ==
X-Forwarded-Encrypted: i=1; AKwUvBwRUtD3NQTm25A5uL1iSK/JzwTQth+5PoUXLk6NXBgKehHXOBlMHY5hIoCbvXACxJPsAMHfRPM=@vger.kernel.org
X-Gm-Message-State: AFuF++kIslZ8RwL5Fq/CtMu7uHn4RtPQjX5GMDkRlPUu0dhJdTl7IOV3
	IpVrwO+c+fge3BIvCkWBfOWnfX4qG78OxUrRjwaq8pbVYyTdRvc/lyag
X-Gm-Gg: AYBFou3mnk+0uNFufOoU/7FdUJ/88BgsVBCeT5gy3uD/quVS024gsTayW9PbMDhrldT
	h2MpU9FTACiCYn0C16jjAmRHPk0aPx9yF5qATHFINAi/aKYyELyZ/kEJah27h9bAXut+I3J0GHq
	B8sykgWIa0XLr1askHIC3rp/2B4gamY9URY2HFrbg12v3BOi0RCJvXthZldX8159luYXJMPKkif
	XJ7aatSCnGHtM8h86rOkbBj8DB2EJvoVm76Y8GMFsyr/n5UltbK6+ECS+VAfIqZNq6X9d0/gbsP
	x4LtdJi9ukii1cVCYkDnWF2Ulnh7NOV8XvhK9udLeH1odxIyeadi5PIu2YlYdXKwRqIh1cOavKk
	v/tNAb+Md5jpxu5FIlwsN6AITKrN9z57XcrccXgSHrtdUsIDlL3zNf1TtoNf9FyLJhrtlDES+NO
	leo7i//2Zz9SZd1/qQH1ur/hXdhqrraDaiyvjp6KJ0MqCklxzh4SQvdCRj0doO53ArIL0nIiOeX
	Hfh3kUbxkPZR4fYvpSmxfOHdhBtlr5s4C6ti7dJFJYPA8omxjiIKX1E8bXN/cOLv7FHPx5srvzW
	0HBU17b++qDaUoWhF2Vgsw==
X-Received: by 2002:a05:6000:144b:b0:488:83f7:6352 with SMTP id ffacd0b85a97d-48883f76609mr650687f8f.4.1790345020096;
        Fri, 25 Sep 2026 07:03:40 -0700 (PDT)
Received: from Lord-Beerus.station ([31.27.155.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a355c65sm7522431f8f.19.2026.09.25.07.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 07:03:39 -0700 (PDT)
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
Subject: [PATCH v1 09/11] ARM: dts: imx6ull: Add Variscite i.MX6ULL board variants
Date: Fri, 25 Sep 2026 16:02:26 +0200
Message-ID: <e5ffc6fe5a38dbd9006ee07a496440c4d0e3dafc.1790344389.git.stefano.r@variscite.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1790344389.git.stefano.r@variscite.com>
References: <cover.1790344389.git.stefano.r@variscite.com>
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
index 000000000000..ef75c773a5ee
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
+#include "imx6ul-imx6ull-var-dart-emmc.dtsi"
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
index 000000000000..82a292a0610d
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
+#include "imx6ul-imx6ull-var-dart-emmc.dtsi"
+#include "imx6ul-imx6ull-var-dart-wm8731.dtsi"
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
index 000000000000..ec3eec7682f4
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
+#include "imx6ul-imx6ull-var-dart-emmc.dtsi"
+#include "imx6ul-imx6ull-var-dart-wifi-brcm.dtsi"
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
index 000000000000..9555bac25f2b
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
+#include "imx6ul-imx6ull-var-dart-emmc.dtsi"
+#include "imx6ul-imx6ull-var-dart-wifi-brcm.dtsi"
+#include "imx6ul-imx6ull-var-dart-wm8731.dtsi"
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
index 000000000000..04c79248e7d5
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
+#include "imx6ul-imx6ull-var-dart-emmc.dtsi"
+#include "imx6ul-imx6ull-var-dart-wifi-iw61x.dtsi"
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
index 000000000000..daaa60287a74
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
+#include "imx6ul-imx6ull-var-dart-nand.dtsi"
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
index 000000000000..3ae6192c6aa1
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
+#include "imx6ul-imx6ull-var-dart-nand.dtsi"
+#include "imx6ul-imx6ull-var-dart-wm8731.dtsi"
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
index 000000000000..6d1b7e07f748
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
+#include "imx6ul-imx6ull-var-dart-nand.dtsi"
+#include "imx6ul-imx6ull-var-dart-wifi-brcm.dtsi"
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
index 000000000000..d70e5c21eb70
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
+#include "imx6ul-imx6ull-var-dart-nand.dtsi"
+#include "imx6ul-imx6ull-var-dart-wifi-brcm.dtsi"
+#include "imx6ul-imx6ull-var-dart-wm8731.dtsi"
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
index 000000000000..2906f0ba8b00
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
+#include "imx6ul-imx6ull-var-dart-nand.dtsi"
+#include "imx6ul-imx6ull-var-dart-wifi-iw61x.dtsi"
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
index 000000000000..8b43ab375592
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
+#include "imx6ul-imx6ull-var-som-emmc.dtsi"
+#include "imx6ul-imx6ull-var-som-wm8904.dtsi"
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
index 000000000000..9a58165433f4
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
+#include "imx6ul-imx6ull-var-som-emmc.dtsi"
+#include "imx6ul-imx6ull-var-som-wm8904.dtsi"
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
index 000000000000..726f9d43d41c
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
+#include "imx6ul-imx6ull-var-som-emmc.dtsi"
+#include "imx6ul-imx6ull-var-som-wm8731.dtsi"
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
index 000000000000..0d94b8bd8fa2
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
+#include "imx6ul-imx6ull-var-som-emmc.dtsi"
+#include "imx6ul-imx6ull-var-som-wm8731.dtsi"
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
index 000000000000..5ff001684d4c
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
+#include "imx6ul-imx6ull-var-som-emmc.dtsi"
+#include "imx6ul-imx6ull-var-som-wifi-brcm.dtsi"
+#include "imx6ul-imx6ull-var-som-wm8904.dtsi"
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
index 000000000000..697ef331e30f
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
+#include "imx6ul-imx6ull-var-som-emmc.dtsi"
+#include "imx6ul-imx6ull-var-som-wifi-brcm.dtsi"
+#include "imx6ul-imx6ull-var-som-wm8904.dtsi"
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
index 000000000000..4a381786ce95
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
+#include "imx6ul-imx6ull-var-som-emmc.dtsi"
+#include "imx6ul-imx6ull-var-som-wifi-brcm.dtsi"
+#include "imx6ul-imx6ull-var-som-wm8731.dtsi"
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
index 000000000000..4dbc1c09398b
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
+#include "imx6ul-imx6ull-var-som-emmc.dtsi"
+#include "imx6ul-imx6ull-var-som-wifi-brcm.dtsi"
+#include "imx6ul-imx6ull-var-som-wm8731.dtsi"
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
index 000000000000..f83f58341477
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
+#include "imx6ul-imx6ull-var-som-emmc.dtsi"
+#include "imx6ul-imx6ull-var-som-wifi-iw61x.dtsi"
+#include "imx6ul-imx6ull-var-som-wm8904.dtsi"
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
index 000000000000..8d3eac9eab8e
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
+#include "imx6ul-imx6ull-var-som-emmc.dtsi"
+#include "imx6ul-imx6ull-var-som-wifi-iw61x.dtsi"
+#include "imx6ul-imx6ull-var-som-wm8904.dtsi"
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
index 000000000000..34c72a0000ad
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
+#include "imx6ul-imx6ull-var-som-nand.dtsi"
+#include "imx6ul-imx6ull-var-som-wm8904.dtsi"
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
index 000000000000..d608503850fe
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
+#include "imx6ul-imx6ull-var-som-nand.dtsi"
+#include "imx6ul-imx6ull-var-som-wm8904.dtsi"
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
index 000000000000..68dca782b23b
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
+#include "imx6ul-imx6ull-var-som-nand.dtsi"
+#include "imx6ul-imx6ull-var-som-wm8731.dtsi"
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
index 000000000000..4670d35e3af6
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
+#include "imx6ul-imx6ull-var-som-nand.dtsi"
+#include "imx6ul-imx6ull-var-som-wm8731.dtsi"
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
index 000000000000..d5f4aa65147f
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
+#include "imx6ul-imx6ull-var-som-nand.dtsi"
+#include "imx6ul-imx6ull-var-som-wifi-brcm.dtsi"
+#include "imx6ul-imx6ull-var-som-wm8904.dtsi"
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
index 000000000000..482d91ae107b
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
+#include "imx6ul-imx6ull-var-som-nand.dtsi"
+#include "imx6ul-imx6ull-var-som-wifi-brcm.dtsi"
+#include "imx6ul-imx6ull-var-som-wm8904.dtsi"
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
index 000000000000..983d2f706d1d
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
+#include "imx6ul-imx6ull-var-som-nand.dtsi"
+#include "imx6ul-imx6ull-var-som-wifi-brcm.dtsi"
+#include "imx6ul-imx6ull-var-som-wm8731.dtsi"
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
index 000000000000..897574bfca2e
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
+#include "imx6ul-imx6ull-var-som-nand.dtsi"
+#include "imx6ul-imx6ull-var-som-wifi-brcm.dtsi"
+#include "imx6ul-imx6ull-var-som-wm8731.dtsi"
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
index 000000000000..b097debd7d66
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
+#include "imx6ul-imx6ull-var-som-nand.dtsi"
+#include "imx6ul-imx6ull-var-som-wifi-iw61x.dtsi"
+#include "imx6ul-imx6ull-var-som-wm8904.dtsi"
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
index 000000000000..b0398d94f758
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
+#include "imx6ul-imx6ull-var-som-nand.dtsi"
+#include "imx6ul-imx6ull-var-som-wifi-iw61x.dtsi"
+#include "imx6ul-imx6ull-var-som-wm8904.dtsi"
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

