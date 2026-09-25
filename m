Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457234A92F9
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 14:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790345027; cv=none; b=PX2fyC0w01+Oh+QJaRIQWqylnaygRlEzg1IEEjoOPFr8nXhXFNPDbJr7mcucWZKKAIl85/ZXIPqsGunDykFQ1uFhKHBubzWITCw4EyjcPaxX2TbV7KjqQVDGviR8xAOmkrpTRyITPKehw+wa7DOa2cyvWl0ATsS2VuZpqB3yPa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790345027; c=relaxed/simple;
	bh=vBM+lbGepIEIF2zcOXimxVLs0HY9ZfVkWEEt8MSIQxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VayLeuzzgvD13fp6IMU3EWVm6rThqpHPeOpPw/U3djqtEpoDXlJz1X+ZnmMmUftk/Qp6cbLIo4sVv8UM2n0HrOh17X1xdzZl7d4FU91h5BSmT/3CFDP4ygX+e0yDMISIawEiW9mzkZpL/QudQdtGRdz5l0/fKrXV5UL2UN9iW3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fggvIW9M; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fggvIW9M"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843796e373so576726f8f.1
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 07:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790345019; x=1790949819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2cXzW+9u6KUJ5We3SNRVJk0BBwo7Oh2qQU7wFfl05rY=;
        b=fggvIW9M6QzkDwrFndou1DIlzIwxYaObN8NDZDAgWDk3F/r+AjvNX4D+bZx72zI/O3
         ybrXnCPV+vjvmVPW+SpTLY4+6cGAN14rfvcEAHwh7sWLjLQvm38GyiN1/IGu+6cDQemR
         fpvKkSkmPYUnDDlUfR6jWtopQSYrwoKPexS+xr7ri2s/DX4pDi4Azfs6EyTDrRDsOQNt
         IjKojA8d5tWp0Ht5yhNLxz5U5rqXRSayfMNqY5jnLB/30ppW6SVTy1I55+UG4MwP7Fla
         0sgGrrzyJk19E4y7f0YXOokrWG9/ItWscAsjOBZEUiOElUJYuXJVQMrxp/ANsIdEEpn+
         6BRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790345019; x=1790949819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2cXzW+9u6KUJ5We3SNRVJk0BBwo7Oh2qQU7wFfl05rY=;
        b=gX55PFvXS6usr0vAJ6SR78e26cHwQHnOUl+BiFduc7K3H2FdossZga4Lgxymzljd9E
         3BH62z/2HdWzsFGSYYpEePZB15+VnEyPhE+CfiSPSEG3DxhlShKxvNzjbPGjMU0b4+6Z
         3rVcXW+Zrm2G7SfPRo/RB2UXmtKzaousIvPPlUrUWIecwjbJvCbqkRDyLK04SQDp1+ds
         wkMsMimi6Dl12xlvoO6pACtMVCN5T6BexLaK1DXE6Fh3F5sIiVsAu2owzkFeW+Bc4qCU
         YyWfK2Jb2Dx/X/SgSaD1wTXrxK2wzf1yLf52bvZ5chscjWZRpzS7ydi+cQBcxYSO6v1x
         h1pg==
X-Forwarded-Encrypted: i=1; AKwUvBw4Bg52CPknx3/jyvvCPKC9YBuv0aDIMbft2EEYDp8RcAgv6dlV5gUxFdxDLkmqHgJoSWC8wkY=@vger.kernel.org
X-Gm-Message-State: AFuF++lNHvk7GW1JGhMGtyxRUfZGWg5/l9v2CC0TYjeCsYv9TpExHAq4
	O/jtu2AvdupVR9gYdXyleBnPo0tTQDtGMINzf2cff8+s3ufs2NpVLU5X
X-Gm-Gg: AYBFou2U5lYu3oMGtKpcB11Mp/YIFVpTX882pNPV+q0gOpy5FlRElk1vF9fEzt1fSJv
	Opat5YtD+lEkq3661MBmB6P3/sRuKX9wZtYXhwflWXgWJ8OVjEsIX5TkXR7mT+W0MxwOgD5Wx9F
	WKsTM+NxDPA0rhMMdT90ElOLlSbhgZ+SMHIBaS2K4ObZq6zIexAF6uXh9F1J1Khx1lg4Pa99u04
	66DbcOctbKMXK0hRNLvjWokLdvpx+HNHBwV3XM9bCRtBTB19hU0qnKmVOYhoME8OxBl8sbqRw60
	1s0o2C8mHsnsUxN7qArIN63h0eNjtFIklWHztJMGEh/UD6WQkg/fBSTNAXLDZ1erLn6Dk8fy7he
	wYEn3eByTmiQ/+vEf0Nzp75PGzKMr5Pjvmf7fRy5n7raWImFAQDg3p/DJu3kS/FmXl6S8pHS7M/
	HZtwhvUGhjQ14xjQo4zjjmlFftuUKRX8AXJvAO0yK83zI1scZ+/CFqOom5yhx3NnPcA52hi7wQU
	zUwPIcKUzaHDkE3xk1Y0wgs7hguNPINM/1f+3SlzW8dut9O2ItvxFNzcHWQnb7+TWbbYzh/JVGL
	oA+bFlYarvw9fqZaLK187A==
X-Received: by 2002:a05:6000:24c4:b0:487:233d:beff with SMTP id ffacd0b85a97d-488716c0695mr10805316f8f.16.1790345018359;
        Fri, 25 Sep 2026 07:03:38 -0700 (PDT)
Received: from Lord-Beerus.station ([31.27.155.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a355c65sm7522431f8f.19.2026.09.25.07.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 07:03:37 -0700 (PDT)
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
Subject: [PATCH v1 08/11] ARM: dts: imx6ul: Add Variscite i.MX6UL board variants
Date: Fri, 25 Sep 2026 16:02:25 +0200
Message-ID: <ab21cb908314149a794f4bd42811a90560b1ce4a.1790344389.git.stefano.r@variscite.com>
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

Add i.MX6UL board DTS files for VAR-SOM-6UL and DART-6UL with their
carrier, storage, wireless and audio options.

Compose each board description from the shared module, option and
carrier DTSI files added earlier in the series.

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
 ...ul-var-som-emmc-sd-card-concerto-board.dts | 20 +++++++++++++++++++
 ...ul-var-som-emmc-sd-card-symphony-board.dts | 20 +++++++++++++++++++
 ...som-emmc-sd-card-wm8731-concerto-board.dts | 20 +++++++++++++++++++
 ...som-emmc-sd-card-wm8731-symphony-board.dts | 20 +++++++++++++++++++
 ...-var-som-emmc-wifi-brcm-concerto-board.dts | 20 +++++++++++++++++++
 ...-var-som-emmc-wifi-brcm-symphony-board.dts | 20 +++++++++++++++++++
 ...m-emmc-wifi-brcm-wm8731-concerto-board.dts | 20 +++++++++++++++++++
 ...m-emmc-wifi-brcm-wm8731-symphony-board.dts | 20 +++++++++++++++++++
 ...var-som-emmc-wifi-iw61x-concerto-board.dts | 20 +++++++++++++++++++
 ...var-som-emmc-wifi-iw61x-symphony-board.dts | 20 +++++++++++++++++++
 ...ul-var-som-nand-sd-card-concerto-board.dts | 20 +++++++++++++++++++
 ...ul-var-som-nand-sd-card-symphony-board.dts | 20 +++++++++++++++++++
 ...som-nand-sd-card-wm8731-concerto-board.dts | 20 +++++++++++++++++++
 ...som-nand-sd-card-wm8731-symphony-board.dts | 20 +++++++++++++++++++
 ...-var-som-nand-wifi-brcm-concerto-board.dts | 20 +++++++++++++++++++
 ...-var-som-nand-wifi-brcm-symphony-board.dts | 20 +++++++++++++++++++
 ...m-nand-wifi-brcm-wm8731-concerto-board.dts | 20 +++++++++++++++++++
 ...m-nand-wifi-brcm-wm8731-symphony-board.dts | 20 +++++++++++++++++++
 ...var-som-nand-wifi-iw61x-concerto-board.dts | 20 +++++++++++++++++++
 ...var-som-nand-wifi-iw61x-symphony-board.dts | 20 +++++++++++++++++++
 30 files changed, 600 insertions(+)
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

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-dart-emmc-sd-card-6ulcustomboard.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-var-dart-emmc-sd-card-6ulcustomboard.dts
new file mode 100644
index 000000000000..74b2ca1895c2
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-var-dart-emmc-sd-card-6ulcustomboard.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ul.dtsi"
+#include "imx6ul-var-dart.dtsi"
+#include "imx6ul-imx6ull-var-dart-emmc.dtsi"
+#include "imx6ul-imx6ull-var-dart-wm8904.dtsi"
+#include "imx6ul-var-dart-6ulcustomboard.dtsi"
+#include "imx6ul-imx6ull-var-dart-6ulcustomboard-sd-card.dtsi"
+
+/ {
+	model = "Variscite DART-6UL with i.MX6UL, eMMC, SD card & WM8904 support on VAR-6ULCustomBoard";
+	compatible = "variscite,dart-6ul-imx6ul-emmc-sd-card-6ulcustomboard",
+		     "variscite,dart-6ul-imx6ul",
+		     "fsl,imx6ul";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-dart-emmc-sd-card-wm8731-6ulcustomboard.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-var-dart-emmc-sd-card-wm8731-6ulcustomboard.dts
new file mode 100644
index 000000000000..726776e2a1a8
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-var-dart-emmc-sd-card-wm8731-6ulcustomboard.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ul.dtsi"
+#include "imx6ul-var-dart.dtsi"
+#include "imx6ul-imx6ull-var-dart-emmc.dtsi"
+#include "imx6ul-imx6ull-var-dart-wm8731.dtsi"
+#include "imx6ul-var-dart-6ulcustomboard.dtsi"
+#include "imx6ul-imx6ull-var-dart-6ulcustomboard-sd-card.dtsi"
+
+/ {
+	model = "Variscite DART-6UL with i.MX6UL, eMMC, SD card & WM8731 support on VAR-6ULCustomBoard";
+	compatible = "variscite,dart-6ul-imx6ul-emmc-sd-card-wm8731-6ulcustomboard",
+		     "variscite,dart-6ul-imx6ul",
+		     "fsl,imx6ul";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-dart-emmc-wifi-brcm-6ulcustomboard.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-var-dart-emmc-wifi-brcm-6ulcustomboard.dts
new file mode 100644
index 000000000000..6bcb3e9e92c6
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-var-dart-emmc-wifi-brcm-6ulcustomboard.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ul.dtsi"
+#include "imx6ul-var-dart.dtsi"
+#include "imx6ul-imx6ull-var-dart-emmc.dtsi"
+#include "imx6ul-imx6ull-var-dart-wifi-brcm.dtsi"
+#include "imx6ul-imx6ull-var-dart-wm8904.dtsi"
+#include "imx6ul-var-dart-6ulcustomboard.dtsi"
+
+/ {
+	model = "Variscite DART-6UL with i.MX6UL, eMMC, WiFi BRCM & WM8904 support on VAR-6ULCustomBoard";
+	compatible = "variscite,dart-6ul-imx6ul-emmc-wifi-brcm-6ulcustomboard",
+		     "variscite,dart-6ul-imx6ul",
+		     "fsl,imx6ul";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-dart-emmc-wifi-brcm-wm8731-6ulcustomboard.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-var-dart-emmc-wifi-brcm-wm8731-6ulcustomboard.dts
new file mode 100644
index 000000000000..8131c5a914b3
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-var-dart-emmc-wifi-brcm-wm8731-6ulcustomboard.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ul.dtsi"
+#include "imx6ul-var-dart.dtsi"
+#include "imx6ul-imx6ull-var-dart-emmc.dtsi"
+#include "imx6ul-imx6ull-var-dart-wifi-brcm.dtsi"
+#include "imx6ul-imx6ull-var-dart-wm8731.dtsi"
+#include "imx6ul-var-dart-6ulcustomboard.dtsi"
+
+/ {
+	model = "Variscite DART-6UL with i.MX6UL, eMMC, WiFi BRCM & WM8731 support on VAR-6ULCustomBoard";
+	compatible = "variscite,dart-6ul-imx6ul-emmc-wifi-brcm-wm8731-6ulcustomboard",
+		     "variscite,dart-6ul-imx6ul",
+		     "fsl,imx6ul";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-dart-emmc-wifi-iw61x-6ulcustomboard.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-var-dart-emmc-wifi-iw61x-6ulcustomboard.dts
new file mode 100644
index 000000000000..2c951e02f5b0
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-var-dart-emmc-wifi-iw61x-6ulcustomboard.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ul.dtsi"
+#include "imx6ul-var-dart.dtsi"
+#include "imx6ul-imx6ull-var-dart-emmc.dtsi"
+#include "imx6ul-imx6ull-var-dart-wifi-iw61x.dtsi"
+#include "imx6ul-imx6ull-var-dart-wm8904.dtsi"
+#include "imx6ul-var-dart-6ulcustomboard.dtsi"
+
+/ {
+	model = "Variscite DART-6UL with i.MX6UL, eMMC, WiFi IW61x & WM8904 support on VAR-6ULCustomBoard";
+	compatible = "variscite,dart-6ul-imx6ul-emmc-wifi-iw61x-6ulcustomboard",
+		     "variscite,dart-6ul-imx6ul",
+		     "fsl,imx6ul";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-dart-nand-sd-card-6ulcustomboard.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-var-dart-nand-sd-card-6ulcustomboard.dts
new file mode 100644
index 000000000000..da2316906bca
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-var-dart-nand-sd-card-6ulcustomboard.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ul.dtsi"
+#include "imx6ul-var-dart.dtsi"
+#include "imx6ul-imx6ull-var-dart-nand.dtsi"
+#include "imx6ul-imx6ull-var-dart-wm8904.dtsi"
+#include "imx6ul-var-dart-6ulcustomboard.dtsi"
+#include "imx6ul-imx6ull-var-dart-6ulcustomboard-sd-card.dtsi"
+
+/ {
+	model = "Variscite DART-6UL with i.MX6UL, NAND flash, SD card & WM8904 support on VAR-6ULCustomBoard";
+	compatible = "variscite,dart-6ul-imx6ul-nand-sd-card-6ulcustomboard",
+		     "variscite,dart-6ul-imx6ul",
+		     "fsl,imx6ul";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-dart-nand-sd-card-wm8731-6ulcustomboard.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-var-dart-nand-sd-card-wm8731-6ulcustomboard.dts
new file mode 100644
index 000000000000..23f0bb5dc6e3
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-var-dart-nand-sd-card-wm8731-6ulcustomboard.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ul.dtsi"
+#include "imx6ul-var-dart.dtsi"
+#include "imx6ul-imx6ull-var-dart-nand.dtsi"
+#include "imx6ul-imx6ull-var-dart-wm8731.dtsi"
+#include "imx6ul-var-dart-6ulcustomboard.dtsi"
+#include "imx6ul-imx6ull-var-dart-6ulcustomboard-sd-card.dtsi"
+
+/ {
+	model = "Variscite DART-6UL with i.MX6UL, NAND flash, SD card & WM8731 support on VAR-6ULCustomBoard";
+	compatible = "variscite,dart-6ul-imx6ul-nand-sd-card-wm8731-6ulcustomboard",
+		     "variscite,dart-6ul-imx6ul",
+		     "fsl,imx6ul";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-dart-nand-wifi-brcm-6ulcustomboard.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-var-dart-nand-wifi-brcm-6ulcustomboard.dts
new file mode 100644
index 000000000000..fc4bd2ca3820
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-var-dart-nand-wifi-brcm-6ulcustomboard.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ul.dtsi"
+#include "imx6ul-var-dart.dtsi"
+#include "imx6ul-imx6ull-var-dart-nand.dtsi"
+#include "imx6ul-imx6ull-var-dart-wifi-brcm.dtsi"
+#include "imx6ul-imx6ull-var-dart-wm8904.dtsi"
+#include "imx6ul-var-dart-6ulcustomboard.dtsi"
+
+/ {
+	model = "Variscite DART-6UL with i.MX6UL, NAND flash, WiFi BRCM & WM8904 support on VAR-6ULCustomBoard";
+	compatible = "variscite,dart-6ul-imx6ul-nand-wifi-brcm-6ulcustomboard",
+		     "variscite,dart-6ul-imx6ul",
+		     "fsl,imx6ul";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-dart-nand-wifi-brcm-wm8731-6ulcustomboard.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-var-dart-nand-wifi-brcm-wm8731-6ulcustomboard.dts
new file mode 100644
index 000000000000..d2df469f53d8
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-var-dart-nand-wifi-brcm-wm8731-6ulcustomboard.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ul.dtsi"
+#include "imx6ul-var-dart.dtsi"
+#include "imx6ul-imx6ull-var-dart-nand.dtsi"
+#include "imx6ul-imx6ull-var-dart-wifi-brcm.dtsi"
+#include "imx6ul-imx6ull-var-dart-wm8731.dtsi"
+#include "imx6ul-var-dart-6ulcustomboard.dtsi"
+
+/ {
+	model = "Variscite DART-6UL with i.MX6UL, NAND flash, WiFi BRCM & WM8731 support on VAR-6ULCustomBoard";
+	compatible = "variscite,dart-6ul-imx6ul-nand-wifi-brcm-wm8731-6ulcustomboard",
+		     "variscite,dart-6ul-imx6ul",
+		     "fsl,imx6ul";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-dart-nand-wifi-iw61x-6ulcustomboard.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-var-dart-nand-wifi-iw61x-6ulcustomboard.dts
new file mode 100644
index 000000000000..7eb6f1a1274f
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-var-dart-nand-wifi-iw61x-6ulcustomboard.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ul.dtsi"
+#include "imx6ul-var-dart.dtsi"
+#include "imx6ul-imx6ull-var-dart-nand.dtsi"
+#include "imx6ul-imx6ull-var-dart-wifi-iw61x.dtsi"
+#include "imx6ul-imx6ull-var-dart-wm8904.dtsi"
+#include "imx6ul-var-dart-6ulcustomboard.dtsi"
+
+/ {
+	model = "Variscite DART-6UL with i.MX6UL, NAND flash, WiFi IW61x & WM8904 support on VAR-6ULCustomBoard";
+	compatible = "variscite,dart-6ul-imx6ul-nand-wifi-iw61x-6ulcustomboard",
+		     "variscite,dart-6ul-imx6ul",
+		     "fsl,imx6ul";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-emmc-sd-card-concerto-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-emmc-sd-card-concerto-board.dts
new file mode 100644
index 000000000000..1e8c4ca82f38
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-emmc-sd-card-concerto-board.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ul.dtsi"
+#include "imx6ul-var-som.dtsi"
+#include "imx6ul-imx6ull-var-som-emmc.dtsi"
+#include "imx6ul-imx6ull-var-som-wm8904.dtsi"
+#include "imx6ul-var-som-concerto-board.dtsi"
+#include "imx6ul-imx6ull-var-som-concerto-board-sd-card.dtsi"
+
+/ {
+	model = "Variscite VAR-SOM-6UL with i.MX6UL, eMMC, SD card & WM8904 support on Concerto-Board";
+	compatible = "variscite,var-som-imx6ul-emmc-sd-card-concerto-board",
+		     "variscite,var-som-imx6ul",
+		     "fsl,imx6ul";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-emmc-sd-card-symphony-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-emmc-sd-card-symphony-board.dts
new file mode 100644
index 000000000000..1e4eb3e083f0
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-emmc-sd-card-symphony-board.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ul.dtsi"
+#include "imx6ul-var-som.dtsi"
+#include "imx6ul-imx6ull-var-som-emmc.dtsi"
+#include "imx6ul-imx6ull-var-som-wm8904.dtsi"
+#include "imx6ul-var-som-symphony-board.dtsi"
+#include "imx6ul-imx6ull-var-som-concerto-board-sd-card.dtsi"
+
+/ {
+	model = "Variscite VAR-SOM-6UL with i.MX6UL, eMMC, SD card & WM8904 support on Symphony-Board";
+	compatible = "variscite,var-som-imx6ul-emmc-sd-card-symphony-board",
+		     "variscite,var-som-imx6ul",
+		     "fsl,imx6ul";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-emmc-sd-card-wm8731-concerto-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-emmc-sd-card-wm8731-concerto-board.dts
new file mode 100644
index 000000000000..d2a1cb11b22f
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-emmc-sd-card-wm8731-concerto-board.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ul.dtsi"
+#include "imx6ul-var-som.dtsi"
+#include "imx6ul-imx6ull-var-som-emmc.dtsi"
+#include "imx6ul-imx6ull-var-som-wm8731.dtsi"
+#include "imx6ul-var-som-concerto-board.dtsi"
+#include "imx6ul-imx6ull-var-som-concerto-board-sd-card.dtsi"
+
+/ {
+	model = "Variscite VAR-SOM-6UL with i.MX6UL, eMMC, SD card & WM8731 support on Concerto-Board";
+	compatible = "variscite,var-som-imx6ul-emmc-sd-card-wm8731-concerto-board",
+		     "variscite,var-som-imx6ul",
+		     "fsl,imx6ul";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-emmc-sd-card-wm8731-symphony-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-emmc-sd-card-wm8731-symphony-board.dts
new file mode 100644
index 000000000000..e16f520ab309
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-emmc-sd-card-wm8731-symphony-board.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ul.dtsi"
+#include "imx6ul-var-som.dtsi"
+#include "imx6ul-imx6ull-var-som-emmc.dtsi"
+#include "imx6ul-imx6ull-var-som-wm8731.dtsi"
+#include "imx6ul-var-som-symphony-board.dtsi"
+#include "imx6ul-imx6ull-var-som-concerto-board-sd-card.dtsi"
+
+/ {
+	model = "Variscite VAR-SOM-6UL with i.MX6UL, eMMC, SD card & WM8731 support on Symphony-Board";
+	compatible = "variscite,var-som-imx6ul-emmc-sd-card-wm8731-symphony-board",
+		     "variscite,var-som-imx6ul",
+		     "fsl,imx6ul";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-emmc-wifi-brcm-concerto-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-emmc-wifi-brcm-concerto-board.dts
new file mode 100644
index 000000000000..db69fabca702
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-emmc-wifi-brcm-concerto-board.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ul.dtsi"
+#include "imx6ul-var-som.dtsi"
+#include "imx6ul-imx6ull-var-som-emmc.dtsi"
+#include "imx6ul-imx6ull-var-som-wifi-brcm.dtsi"
+#include "imx6ul-imx6ull-var-som-wm8904.dtsi"
+#include "imx6ul-var-som-concerto-board.dtsi"
+
+/ {
+	model = "Variscite VAR-SOM-6UL with i.MX6UL, eMMC, WiFi BRCM & WM8904 support on Concerto-Board";
+	compatible = "variscite,var-som-imx6ul-emmc-wifi-brcm-concerto-board",
+		     "variscite,var-som-imx6ul",
+		     "fsl,imx6ul";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-emmc-wifi-brcm-symphony-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-emmc-wifi-brcm-symphony-board.dts
new file mode 100644
index 000000000000..55f8857518c8
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-emmc-wifi-brcm-symphony-board.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ul.dtsi"
+#include "imx6ul-var-som.dtsi"
+#include "imx6ul-imx6ull-var-som-emmc.dtsi"
+#include "imx6ul-imx6ull-var-som-wifi-brcm.dtsi"
+#include "imx6ul-imx6ull-var-som-wm8904.dtsi"
+#include "imx6ul-var-som-symphony-board.dtsi"
+
+/ {
+	model = "Variscite VAR-SOM-6UL with i.MX6UL, eMMC, WiFi BRCM & WM8904 support on Symphony-Board";
+	compatible = "variscite,var-som-imx6ul-emmc-wifi-brcm-symphony-board",
+		     "variscite,var-som-imx6ul",
+		     "fsl,imx6ul";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-emmc-wifi-brcm-wm8731-concerto-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-emmc-wifi-brcm-wm8731-concerto-board.dts
new file mode 100644
index 000000000000..ff2b94c54b4b
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-emmc-wifi-brcm-wm8731-concerto-board.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ul.dtsi"
+#include "imx6ul-var-som.dtsi"
+#include "imx6ul-imx6ull-var-som-emmc.dtsi"
+#include "imx6ul-imx6ull-var-som-wifi-brcm.dtsi"
+#include "imx6ul-imx6ull-var-som-wm8731.dtsi"
+#include "imx6ul-var-som-concerto-board.dtsi"
+
+/ {
+	model = "Variscite VAR-SOM-6UL with i.MX6UL, eMMC, WiFi BRCM & WM8731 support on Concerto-Board";
+	compatible = "variscite,var-som-imx6ul-emmc-wifi-brcm-wm8731-concerto-board",
+		     "variscite,var-som-imx6ul",
+		     "fsl,imx6ul";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-emmc-wifi-brcm-wm8731-symphony-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-emmc-wifi-brcm-wm8731-symphony-board.dts
new file mode 100644
index 000000000000..bdd4f6b537c8
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-emmc-wifi-brcm-wm8731-symphony-board.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ul.dtsi"
+#include "imx6ul-var-som.dtsi"
+#include "imx6ul-imx6ull-var-som-emmc.dtsi"
+#include "imx6ul-imx6ull-var-som-wifi-brcm.dtsi"
+#include "imx6ul-imx6ull-var-som-wm8731.dtsi"
+#include "imx6ul-var-som-symphony-board.dtsi"
+
+/ {
+	model = "Variscite VAR-SOM-6UL with i.MX6UL, eMMC, WiFi BRCM & WM8731 support on Symphony-Board";
+	compatible = "variscite,var-som-imx6ul-emmc-wifi-brcm-wm8731-symphony-board",
+		     "variscite,var-som-imx6ul",
+		     "fsl,imx6ul";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-emmc-wifi-iw61x-concerto-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-emmc-wifi-iw61x-concerto-board.dts
new file mode 100644
index 000000000000..bdaa17b6e1ed
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-emmc-wifi-iw61x-concerto-board.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ul.dtsi"
+#include "imx6ul-var-som.dtsi"
+#include "imx6ul-imx6ull-var-som-emmc.dtsi"
+#include "imx6ul-imx6ull-var-som-wifi-iw61x.dtsi"
+#include "imx6ul-imx6ull-var-som-wm8904.dtsi"
+#include "imx6ul-var-som-concerto-board.dtsi"
+
+/ {
+	model = "Variscite VAR-SOM-6UL with i.MX6UL, eMMC, WiFi IW61x & WM8904 support on Concerto-Board";
+	compatible = "variscite,var-som-imx6ul-emmc-wifi-iw61x-concerto-board",
+		     "variscite,var-som-imx6ul",
+		     "fsl,imx6ul";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-emmc-wifi-iw61x-symphony-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-emmc-wifi-iw61x-symphony-board.dts
new file mode 100644
index 000000000000..165a33e59ff4
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-emmc-wifi-iw61x-symphony-board.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ul.dtsi"
+#include "imx6ul-var-som.dtsi"
+#include "imx6ul-imx6ull-var-som-emmc.dtsi"
+#include "imx6ul-imx6ull-var-som-wifi-iw61x.dtsi"
+#include "imx6ul-imx6ull-var-som-wm8904.dtsi"
+#include "imx6ul-var-som-symphony-board.dtsi"
+
+/ {
+	model = "Variscite VAR-SOM-6UL with i.MX6UL, eMMC, WiFi IW61x & WM8904 support on Symphony-Board";
+	compatible = "variscite,var-som-imx6ul-emmc-wifi-iw61x-symphony-board",
+		     "variscite,var-som-imx6ul",
+		     "fsl,imx6ul";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-nand-sd-card-concerto-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-nand-sd-card-concerto-board.dts
new file mode 100644
index 000000000000..425f8189259f
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-nand-sd-card-concerto-board.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ul.dtsi"
+#include "imx6ul-var-som.dtsi"
+#include "imx6ul-imx6ull-var-som-nand.dtsi"
+#include "imx6ul-imx6ull-var-som-wm8904.dtsi"
+#include "imx6ul-var-som-concerto-board.dtsi"
+#include "imx6ul-imx6ull-var-som-concerto-board-sd-card.dtsi"
+
+/ {
+	model = "Variscite VAR-SOM-6UL with i.MX6UL, NAND flash, SD card & WM8904 support on Concerto-Board";
+	compatible = "variscite,var-som-imx6ul-nand-sd-card-concerto-board",
+		     "variscite,var-som-imx6ul",
+		     "fsl,imx6ul";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-nand-sd-card-symphony-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-nand-sd-card-symphony-board.dts
new file mode 100644
index 000000000000..f0e91abf2027
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-nand-sd-card-symphony-board.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ul.dtsi"
+#include "imx6ul-var-som.dtsi"
+#include "imx6ul-imx6ull-var-som-nand.dtsi"
+#include "imx6ul-imx6ull-var-som-wm8904.dtsi"
+#include "imx6ul-var-som-symphony-board.dtsi"
+#include "imx6ul-imx6ull-var-som-concerto-board-sd-card.dtsi"
+
+/ {
+	model = "Variscite VAR-SOM-6UL with i.MX6UL, NAND flash, SD card & WM8904 support on Symphony-Board";
+	compatible = "variscite,var-som-imx6ul-nand-sd-card-symphony-board",
+		     "variscite,var-som-imx6ul",
+		     "fsl,imx6ul";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-nand-sd-card-wm8731-concerto-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-nand-sd-card-wm8731-concerto-board.dts
new file mode 100644
index 000000000000..0b734aa1b577
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-nand-sd-card-wm8731-concerto-board.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ul.dtsi"
+#include "imx6ul-var-som.dtsi"
+#include "imx6ul-imx6ull-var-som-nand.dtsi"
+#include "imx6ul-imx6ull-var-som-wm8731.dtsi"
+#include "imx6ul-var-som-concerto-board.dtsi"
+#include "imx6ul-imx6ull-var-som-concerto-board-sd-card.dtsi"
+
+/ {
+	model = "Variscite VAR-SOM-6UL with i.MX6UL, NAND flash, SD card & WM8731 support on Concerto-Board";
+	compatible = "variscite,var-som-imx6ul-nand-sd-card-wm8731-concerto-board",
+		     "variscite,var-som-imx6ul",
+		     "fsl,imx6ul";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-nand-sd-card-wm8731-symphony-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-nand-sd-card-wm8731-symphony-board.dts
new file mode 100644
index 000000000000..e4d34ff20bf1
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-nand-sd-card-wm8731-symphony-board.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ul.dtsi"
+#include "imx6ul-var-som.dtsi"
+#include "imx6ul-imx6ull-var-som-nand.dtsi"
+#include "imx6ul-imx6ull-var-som-wm8731.dtsi"
+#include "imx6ul-var-som-symphony-board.dtsi"
+#include "imx6ul-imx6ull-var-som-concerto-board-sd-card.dtsi"
+
+/ {
+	model = "Variscite VAR-SOM-6UL with i.MX6UL, NAND flash, SD card & WM8731 support on Symphony-Board";
+	compatible = "variscite,var-som-imx6ul-nand-sd-card-wm8731-symphony-board",
+		     "variscite,var-som-imx6ul",
+		     "fsl,imx6ul";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-nand-wifi-brcm-concerto-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-nand-wifi-brcm-concerto-board.dts
new file mode 100644
index 000000000000..c7377c87b55a
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-nand-wifi-brcm-concerto-board.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ul.dtsi"
+#include "imx6ul-var-som.dtsi"
+#include "imx6ul-imx6ull-var-som-nand.dtsi"
+#include "imx6ul-imx6ull-var-som-wifi-brcm.dtsi"
+#include "imx6ul-imx6ull-var-som-wm8904.dtsi"
+#include "imx6ul-var-som-concerto-board.dtsi"
+
+/ {
+	model = "Variscite VAR-SOM-6UL with i.MX6UL, NAND flash, WiFi BRCM & WM8904 support on Concerto-Board";
+	compatible = "variscite,var-som-imx6ul-nand-wifi-brcm-concerto-board",
+		     "variscite,var-som-imx6ul",
+		     "fsl,imx6ul";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-nand-wifi-brcm-symphony-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-nand-wifi-brcm-symphony-board.dts
new file mode 100644
index 000000000000..2bfc5ac32bb5
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-nand-wifi-brcm-symphony-board.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ul.dtsi"
+#include "imx6ul-var-som.dtsi"
+#include "imx6ul-imx6ull-var-som-nand.dtsi"
+#include "imx6ul-imx6ull-var-som-wifi-brcm.dtsi"
+#include "imx6ul-imx6ull-var-som-wm8904.dtsi"
+#include "imx6ul-var-som-symphony-board.dtsi"
+
+/ {
+	model = "Variscite VAR-SOM-6UL with i.MX6UL, NAND flash, WiFi BRCM & WM8904 support on Symphony-Board";
+	compatible = "variscite,var-som-imx6ul-nand-wifi-brcm-symphony-board",
+		     "variscite,var-som-imx6ul",
+		     "fsl,imx6ul";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-nand-wifi-brcm-wm8731-concerto-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-nand-wifi-brcm-wm8731-concerto-board.dts
new file mode 100644
index 000000000000..6250b80bd112
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-nand-wifi-brcm-wm8731-concerto-board.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ul.dtsi"
+#include "imx6ul-var-som.dtsi"
+#include "imx6ul-imx6ull-var-som-nand.dtsi"
+#include "imx6ul-imx6ull-var-som-wifi-brcm.dtsi"
+#include "imx6ul-imx6ull-var-som-wm8731.dtsi"
+#include "imx6ul-var-som-concerto-board.dtsi"
+
+/ {
+	model = "Variscite VAR-SOM-6UL with i.MX6UL, NAND flash, WiFi BRCM & WM8731 support on Concerto-Board";
+	compatible = "variscite,var-som-imx6ul-nand-wifi-brcm-wm8731-concerto-board",
+		     "variscite,var-som-imx6ul",
+		     "fsl,imx6ul";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-nand-wifi-brcm-wm8731-symphony-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-nand-wifi-brcm-wm8731-symphony-board.dts
new file mode 100644
index 000000000000..b526fd971471
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-nand-wifi-brcm-wm8731-symphony-board.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ul.dtsi"
+#include "imx6ul-var-som.dtsi"
+#include "imx6ul-imx6ull-var-som-nand.dtsi"
+#include "imx6ul-imx6ull-var-som-wifi-brcm.dtsi"
+#include "imx6ul-imx6ull-var-som-wm8731.dtsi"
+#include "imx6ul-var-som-symphony-board.dtsi"
+
+/ {
+	model = "Variscite VAR-SOM-6UL with i.MX6UL, NAND flash, WiFi BRCM & WM8731 support on Symphony-Board";
+	compatible = "variscite,var-som-imx6ul-nand-wifi-brcm-wm8731-symphony-board",
+		     "variscite,var-som-imx6ul",
+		     "fsl,imx6ul";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-nand-wifi-iw61x-concerto-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-nand-wifi-iw61x-concerto-board.dts
new file mode 100644
index 000000000000..cdba8a5d6141
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-nand-wifi-iw61x-concerto-board.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ul.dtsi"
+#include "imx6ul-var-som.dtsi"
+#include "imx6ul-imx6ull-var-som-nand.dtsi"
+#include "imx6ul-imx6ull-var-som-wifi-iw61x.dtsi"
+#include "imx6ul-imx6ull-var-som-wm8904.dtsi"
+#include "imx6ul-var-som-concerto-board.dtsi"
+
+/ {
+	model = "Variscite VAR-SOM-6UL with i.MX6UL, NAND flash, WiFi IW61x & WM8904 support on Concerto-Board";
+	compatible = "variscite,var-som-imx6ul-nand-wifi-iw61x-concerto-board",
+		     "variscite,var-som-imx6ul",
+		     "fsl,imx6ul";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-nand-wifi-iw61x-symphony-board.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-nand-wifi-iw61x-symphony-board.dts
new file mode 100644
index 000000000000..88630bd12611
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-nand-wifi-iw61x-symphony-board.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/dts-v1/;
+
+#include "imx6ul.dtsi"
+#include "imx6ul-var-som.dtsi"
+#include "imx6ul-imx6ull-var-som-nand.dtsi"
+#include "imx6ul-imx6ull-var-som-wifi-iw61x.dtsi"
+#include "imx6ul-imx6ull-var-som-wm8904.dtsi"
+#include "imx6ul-var-som-symphony-board.dtsi"
+
+/ {
+	model = "Variscite VAR-SOM-6UL with i.MX6UL, NAND flash, WiFi IW61x & WM8904 support on Symphony-Board";
+	compatible = "variscite,var-som-imx6ul-nand-wifi-iw61x-symphony-board",
+		     "variscite,var-som-imx6ul",
+		     "fsl,imx6ul";
+};
-- 
2.47.3

