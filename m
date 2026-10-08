Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406CA4FECCF
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 19:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791488437; cv=none; b=eq1TfnIdH8N//7BVK7hmNk86y7xCKxgy1M87IJ6ZeH18fNVCVnCBYfLoW9ptG3IspQTVrCcucjNNzZ/7erH4gacV58KBHtu1u6L2aIMPyaElvaVqIovRD/v6l5MlznzgN4FQ1eTTS9wXHcXdpD5jfDtKEe7EzoWo/5YPqcMAfHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791488437; c=relaxed/simple;
	bh=uYnoAlVMzjPf1koqMWb3wOPeMUNPpHGIO7RXL2fZKnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E8GKXR4601mKFbYXHp9RWh0lzEreAhhZvK97/0Wux31SsIyN29tPXe1JDNwmGRFXTYJXydW+Q0vTCTPawU7eg12QdPOexOEGJDw0Iuf0O7Tp5+p07kyKrwQfq3IuUcx5ICpPvBUScCi46YC17o9l0s7IqUIaZaKfClnnskuI03k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1xeIeMF; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1xeIeMF"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a16af2a232so29367285e9.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 12:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791488429; x=1792093229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hRkcPjZLCx4KGQ69YlsYx3CS01joHDVdS8gNEI5i67g=;
        b=i1xeIeMFOaDcs/qDd6ECvx3yo7CACdrr2Pd5y7ll1sFrQNfZEWM0/UXdnVFeeGy65h
         M0J7AmBaTkmaavHSZ2iV5+pXoJwCxroLRXqdEutYsXC4I1Yv3gPzXVHeC+LFEo164QRj
         kbWxUXQ+5qYwtkQzlt82aP8s+bzKm4EuM1ZL7OJPKVZDJWGqQUm1hsYLSbYLGZCCFSsY
         YJLCyziM+Uw19TMZkBFC9aXYneKuRe87JdkKuqWxXOTUYEC6C8qd63BQ51lNA5yJSG/3
         eUfb+NTeCx7u9M7U4q7f6l2CHoEI7ebLQwDJV+PvbpZ1QJ7nlWNHSegmprc3EVVvLGNp
         D/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791488429; x=1792093229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hRkcPjZLCx4KGQ69YlsYx3CS01joHDVdS8gNEI5i67g=;
        b=IKgPfl7P+wdb55ZJdBFm2ufMC/U5lobPDzbL8ex2Z5KEduUqfQ/6ShaBWZ8CWbjJ+f
         TIPl4XbelOyQpZWKyHc21xdSumANYPQhkcWm3iSfoO/EvsIg47oO5aDtIeyQJJijEJwA
         a2qSCAlYBzmhT1dXG2juLuG2fwCFdu4rZ1rHm3ZA92UnSeJ7UdXxk+UTutNCtaOnf3+O
         bHufV6SUeQGj4Vw5GIIHO9LRz3NxUfaFclbA9JmztMsHk1wHTxIlY05/sAlqfBloikhz
         zPqFOvURvdDzx5RrC/rJ30Q6jhc26OXz6Av7o9eoAlJGoQlARoMwV8VSOk4GpKRt+uin
         gxqQ==
X-Forwarded-Encrypted: i=1; AKwUvByLJOP5CAXY3hEwcOpb2bxCxAO3Prw4EGjqRauI9G4VSb2LEmub3EYtnlv7wfShOlU/tJWANlc=@vger.kernel.org
X-Gm-Message-State: AFuF++kC2yMtKt6m1As8MKdBkbYrJGGwIz9AYpddhJ5slAyye/T0Z/GO
	j0UQiTlbTZNnqI19bwQh4rE51WM9owtm7PMeUjLUWmPJyFb9nBhYsb9j
X-Gm-Gg: AYBFou3xR1Wk4/ZgI8YkFhMF17sPSg43vACI5gFepCsT4fX5SfA251rS7R/82kZ5NUC
	1YJBcqFrxffpM1TlP4XZScPFJksllXhXsuyrQxcApRt3cXFRadtwTZwjAVrh1Th0VdKpU1eoZYS
	VrpFpaRUgkTE4cvEivZ8hUG4WLQ8jk7aDo5RtLWgciUeOb4I2mVBU0WTZ67lnnZLjYIxGAlSNl5
	CN83r0rtvXgZKP+fBUfrgvV1f2izciHltf7t+2wgJ5T4ov0ER/hwjKGCGGTKNcxmhu7QXNXiouU
	c0xyuBHmJFTYO7FrJLtujlKo8exFo7OpLzwqRXcNnTjHIlSiKjUR+dScULR7wtdYETmBQLQJNaw
	qRhyIV506Oz/07t4Ai4p7Qm6NwMUeKW1Ylz697+gwfuQd34azvjLSGrDHFcBAtADupJtT4lB8jc
	cXWu+jsz+xCb//y/oEkaLmN+s41VCTB+kL3PtcDfVT673/TTSZK2ddoBpHheICzELFuBVPHNhhx
	BFnrtu4F60bZCxRvTh6wq/fKipL2ehISOoA/oByx7171UA5waWo8V7ZuhDHTX4srXyT6msvJsqw
	Fryd8+i+NqE03jtpBF+yZQ==
X-Received: by 2002:a05:600c:a00d:b0:49f:ce78:356f with SMTP id 5b1f17b1804b1-4a18065f30cmr122465985e9.32.1791488429121;
        Thu, 08 Oct 2026 12:40:29 -0700 (PDT)
Received: from Lord-Beerus.station ([31.27.155.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18c1e33d2sm1419065e9.0.2026.10.08.12.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 12:40:28 -0700 (PDT)
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
Subject: [PATCH v5 07/13] ARM: dts: imx6ul: Add Variscite WM8904 and WM8731 support
Date: Thu,  8 Oct 2026 21:37:47 +0200
Message-ID: <50f74f31925dd5d43d5b6578888c33875d8f2a20.1791487179.git.stefano.r@variscite.com>
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

Add shared WM8904 and WM8731 codec and sound-card descriptions for
VAR-SOM-6UL and DART-6UL. Reuse imx6ul-var-som-audio.dtsi for SAI2
and select the clock setup and audio routes in each codec file.
The DART-6UL WM8904 wrapper adds the IN2L, IN2R and MICBIAS routes.

The existing Concerto DTS files enable SAI2 but do not describe a
codec or sound card. Include the WM8904 option there to connect the
codec on I2C2 to SAI2 with the module's audio configuration.

Signed-off-by: Stefano Radaelli <stefano.r@variscite.com>
---
v4->v5:
 - Reuse imx6ul-var-som-audio.dtsi for SAI2 and its pinctrl, keeping
   codec-specific clock and routing settings in the codec files.
 - Add the WM8904 include to the four existing Concerto DTS files in
   this patch instead of waiting for a later conversion patch.

v1->v2:
 - Share the WM8904 description with a DART-specific microphone
   routing wrapper, and consolidate the identical WM8731 files.

 .../imx/imx6ul-imx6ull-var-dart-wm8904.dtsi   | 17 +++++
 .../nxp/imx/imx6ul-imx6ull-var-wm8731.dtsi    | 50 ++++++++++++++
 .../nxp/imx/imx6ul-imx6ull-var-wm8904.dtsi    | 68 +++++++++++++++++++
 .../nxp/imx/imx6ul-var-som-concerto-full.dts  |  2 +-
 .../dts/nxp/imx/imx6ul-var-som-concerto.dts   |  2 +-
 .../nxp/imx/imx6ull-var-som-concerto-full.dts |  2 +-
 .../dts/nxp/imx/imx6ull-var-som-concerto.dts  |  2 +-
 7 files changed, 139 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-dart-wm8904.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-wm8731.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-wm8904.dtsi

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-dart-wm8904.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-dart-wm8904.dtsi
new file mode 100644
index 000000000000..236022f3da10
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-dart-wm8904.dtsi
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+#include "imx6ul-imx6ull-var-wm8904.dtsi"
+
+&sound_wm8904 {
+	simple-audio-card,routing =
+		"Headphone Jack", "HPOUTL",
+		"Headphone Jack", "HPOUTR",
+		"IN1L", "Line In Jack",
+		"IN1R", "Line In Jack",
+		"IN2L", "Microphone Jack",
+		"IN2R", "Microphone Jack",
+		"Microphone Jack", "MICBIAS";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-wm8731.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-wm8731.dtsi
new file mode 100644
index 000000000000..ed9af0a39714
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-wm8731.dtsi
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+#include "imx6ul-var-som-audio.dtsi"
+
+/ {
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,bitclock-master = <&sound_master>;
+		simple-audio-card,format = "i2s";
+		simple-audio-card,frame-master = <&sound_master>;
+		simple-audio-card,name = "wm8731audio";
+		simple-audio-card,routing =
+			"Headphone Jack", "RHPOUT",
+			"Headphone Jack", "LHPOUT",
+			"LLINEIN", "Line Jack",
+			"RLINEIN", "Line Jack",
+			"MICIN", "Mic Bias",
+			"Mic Bias", "Mic Jack";
+		simple-audio-card,widgets =
+			"Headphone", "Headphone Jack",
+			"Line", "Line Jack",
+			"Microphone", "Mic Jack";
+
+		sound_master: simple-audio-card,cpu {
+			sound-dai = <&sai2>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&codec>;
+			system-clock-frequency = <12288000>;
+		};
+	};
+};
+
+&i2c2 {
+	codec: audio-codec@1a {
+		compatible = "wlf,wm8731";
+		reg = <0x1a>;
+		#sound-dai-cells = <0>;
+		clocks = <&clks IMX6UL_CLK_SAI2>;
+		clock-names = "mclk";
+		AVDD-supply = <&reg_3p3v>;
+		DBVDD-supply = <&reg_3p3v>;
+		DCVDD-supply = <&reg_3p3v>;
+		HPVDD-supply = <&reg_3p3v>;
+	};
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-wm8904.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-wm8904.dtsi
new file mode 100644
index 000000000000..c95dbf3824af
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-wm8904.dtsi
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+#include "imx6ul-var-som-audio.dtsi"
+
+/ {
+	sound_wm8904: sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,bitclock-master = <&sound_master>;
+		simple-audio-card,format = "i2s";
+		simple-audio-card,frame-master = <&sound_master>;
+		simple-audio-card,name = "wm8904audio";
+		simple-audio-card,routing =
+			"Headphone Jack", "HPOUTL",
+			"Headphone Jack", "HPOUTR",
+			"IN1L", "Line In Jack",
+			"IN1R", "Line In Jack";
+		simple-audio-card,widgets =
+			"Microphone", "Microphone Jack",
+			"Headphone", "Headphone Jack",
+			"Line", "Line In Jack";
+		simple-audio-card,mclk-fs = <256>;
+
+		simple-audio-card,cpu {
+			sound-dai = <&sai2>;
+		};
+
+		sound_master: simple-audio-card,codec {
+			sound-dai = <&codec>;
+		};
+	};
+};
+
+&i2c2 {
+	codec: audio-codec@1a {
+		compatible = "wlf,wm8904";
+		reg = <0x1a>;
+		#sound-dai-cells = <0>;
+		clocks = <&clks IMX6UL_CLK_SAI2>;
+		clock-names = "mclk";
+		AVDD-supply = <&reg_3p3v>;
+		CPVDD-supply = <&reg_3p3v>;
+		DBVDD-supply = <&reg_3p3v>;
+		DCVDD-supply = <&reg_3p3v>;
+		MICVDD-supply = <&reg_3p3v>;
+		wlf,drc-cfg-names = "default", "peaklimiter", "tradition",
+				    "soft", "music";
+		/*
+		 * Config registers per name, respectively:
+		 * KNEE_IP = 0,   KNEE_OP = 0,     HI_COMP = 1,   LO_COMP = 1
+		 * KNEE_IP = -24, KNEE_OP = -6,    HI_COMP = 1/4, LO_COMP = 1
+		 * KNEE_IP = -42, KNEE_OP = -3,    HI_COMP = 0,   LO_COMP = 1
+		 * KNEE_IP = -45, KNEE_OP = -9,    HI_COMP = 1/8, LO_COMP = 1
+		 * KNEE_IP = -30, KNEE_OP = -10.5, HI_COMP = 1/4, LO_COMP = 1
+		 */
+		wlf,drc-cfg-regs = /bits/ 16 <0x01af 0x3248 0x0000 0x0000>,
+				   /bits/ 16 <0x04af 0x324b 0x0010 0x0408>,
+				   /bits/ 16 <0x04af 0x324b 0x0028 0x0704>,
+				   /bits/ 16 <0x04af 0x324b 0x0018 0x078c>,
+				   /bits/ 16 <0x04af 0x324b 0x0010 0x050e>;
+	};
+};
+
+&sai2 {
+	assigned-clock-rates = <0>, <11565177>;
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-concerto-full.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-concerto-full.dts
index 725f34d6b7ee..66c9deaea083 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-concerto-full.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-concerto-full.dts
@@ -13,7 +13,7 @@
 #include "imx6ul-var-som-wifi.dtsi"
 #include "imx6ul-var-som-enet2.dtsi"
 #include "imx6ul-var-som-enet1.dtsi"
-#include "imx6ul-var-som-audio.dtsi"
+#include "imx6ul-imx6ull-var-wm8904.dtsi"
 #include "imx6ul-var-som-lvds-panel.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-concerto.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-concerto.dts
index c249e15772b8..4905abf5aa08 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-concerto.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-concerto.dts
@@ -13,7 +13,7 @@
 #include "imx6ul-var-som-concerto-common.dtsi"
 #include "imx6ul-var-som-sd.dtsi"
 #include "imx6ul-var-som-enet2.dtsi"
-#include "imx6ul-var-som-audio.dtsi"
+#include "imx6ul-imx6ull-var-wm8904.dtsi"
 #include "imx6ul-var-som-lvds-panel.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-concerto-full.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-concerto-full.dts
index 1b7c1a3383ee..880b72833091 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-concerto-full.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-concerto-full.dts
@@ -13,7 +13,7 @@
 #include "imx6ul-var-som-wifi.dtsi"
 #include "imx6ul-var-som-enet2.dtsi"
 #include "imx6ul-var-som-enet1.dtsi"
-#include "imx6ul-var-som-audio.dtsi"
+#include "imx6ul-imx6ull-var-wm8904.dtsi"
 #include "imx6ul-var-som-lvds-panel.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-concerto.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-concerto.dts
index 9c9d16eb1a11..c481839a98a5 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-concerto.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-concerto.dts
@@ -12,7 +12,7 @@
 #include "imx6ul-var-som-concerto-common.dtsi"
 #include "imx6ul-var-som-sd.dtsi"
 #include "imx6ul-var-som-enet2.dtsi"
-#include "imx6ul-var-som-audio.dtsi"
+#include "imx6ul-imx6ull-var-wm8904.dtsi"
 #include "imx6ul-var-som-lvds-panel.dtsi"
 
 / {
-- 
2.47.3

