Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9B2397923
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 05:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785734153; cv=none; b=pDf9ehKWPl0SZ87vnNc8pghrbL/byiTE8n7K37haaWlfV4Me3AaMEjP+DBNjU1JsZrdov034604qfeowTGfRi2S935OusuVF8++0Ht39SJLifH1im9hZSp7fQzuSefw1IwlM9o7ctU3GiZSRD/SlJ4bJJB7JGDLjBohOAi334IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785734153; c=relaxed/simple;
	bh=ZUVZReuwX6u+VOoUVGjsuCMz/MOgQoewZH495TiPLJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mfpqCgBSnQQSidlEAnUYCnS/R5adEugf/IhfJI6ziayecfBDCo81fBtcWVqyyq4+t0pBqSU3F69wbUvbn6bnD64k1DVdaaqC96baV8kGw9yM2r1V6ZC/KpYWrpEhyIkA2PwW4Yftgqsfq0YbcWJQJSZAowwoXSVsrk/Yh04NkL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2YZX1LQ; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2YZX1LQ"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7e9d7464b71so1367534a34.0
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 22:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785734150; x=1786338950; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OJn8bgDlexj3pTLFD/TVKu44xwgcekcV50vMMBDdgSo=;
        b=Y2YZX1LQVBjsbzcaecmpbQH5pP2HHE4QV5cE/AUREBPl/XM05rojqrphqrxNigbLhb
         WeKfmbp96L9mk3atpyrL3XHTZURyxFW5/ycMVe0ZSe319RmS5ssdfY95QCtpaarCs6/f
         +IkDyMRoGQvxo6JAbuHDhX0VJYeSd5rofIc3reptOyghmLmHROXLQHb++id/Wvp0Td0T
         ddpSgW3biBRuvMNhLwWWPieoFAWgYji0Dc9BtbAZPEDsUFxnUIGcJVRROoG6Fh0e4+rZ
         wRBs6+xJjxOfDBI9BhiIDBPNhLKMqK4H4Lk6nxYuyiorg5TuFGjOZ4+PTZJg4PqugkzL
         YnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785734150; x=1786338950;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OJn8bgDlexj3pTLFD/TVKu44xwgcekcV50vMMBDdgSo=;
        b=ipu8VmMY5uP1naiuXIqALbN5WyeHbztqsAlObavq2EH3SM1LnDifr0O8q3Nxx8rm6Y
         mimWR/C6OtVtlwNirLuhUVAK17oj0TSvnxgKT7JaXAGlsdbhc43ySFlkuE4kWIavxF1R
         QOHye1elelgS7PdrlapifiVkuaDckamgnnakiLSawY6lq43vzbVuzlt46XRBwVwjZJBN
         /ANx5rGF/zaPCJxUjt/uumHz1Sdza799skhXc23NMEjgIKlC087VEo/u0Y9NnU2i4g9j
         DrIB4p23hke16SL9yvdnlNCutBTYUedaYX8dXV1b+KixjKVbFNNRp545Rf7LoCpuVKGy
         He3w==
X-Gm-Message-State: AOJu0YxJ9cRp4Nyrvshp71fGgV5/13aGJmVYsRgN9841cQk4pIFpZFfd
	rV+rnHlW7sdVdRDQdXZh+EIxNdRnBMuwRiN0gaPbfRq4L3tFTw62I0C9
X-Gm-Gg: AR+sD11AAhnNUFlBCOpeSESofLLSiw/jAneEb/2LwTiCZcFo+UPAh5LTBY87g1n+0hr
	roehO+P1E0IKpD3yXkONZ6BEG3HJn9OYdtkUPAxHLMoNrlV51SIeAp8kOMcgXbu4Qcm+vevYYND
	/Bsyj1w6KHHgbHKwxYKPAf22x3Eu+beDqqjAFq3KILbMir2jKlj1FUdFeF+sz5iyqtZdZZT6luF
	jsgrO8yXwZqnwO8afSGsVjk9JcBenX+c+vezDWcuS0DUMU01VQjBvrTijPmiMiIsQnEARFWbyvg
	KlJUzyOrKPdXaFghNU3gcWeiXMlK4TL5bupyzUAVj51lcYpiiexBkm9QgyHIBGnyMKWwqjtqY4Q
	AftJNd/28d6NQNtVbbCqoy3f/M74GuPmXaUbAsRJ86owaclIkAM/YX8Y31o9yOc4oYqZSw6azRd
	TCjKT8c1b0dIp6Jyv0QN3+/KBMwPEwKkQW6bGloto2K8wUW/5x9ML7tjRTvxG9QZslKxnE0MlW8
	RDfM0KxWXpj/bk5KWyvuCvSXWlfXhsKhg/p6CkcA2H7qEFCRHWr/fEoCyKx+rlZqFovFJhL7JAv
	EwOdT434hh5+BvQQqXCZQt4Jk+ufaOpfttEENdJxsMisz1ESi+qxTmCNMICXJUCsUnmGBHvSOgj
	pw4b2debaJHLj/C6w
X-Received: by 2002:a05:6830:82eb:b0:7eb:c933:eff7 with SMTP id 46e09a7af769-7f196f0d0e1mr13285248a34.9.1785734150243;
        Sun, 02 Aug 2026 22:15:50 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f18f07a5e3sm6787108a34.15.2026.08.02.22.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 22:15:49 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 02 Aug 2026 23:14:28 -0600
Subject: [PATCH 18/21] arm64: dts: allwinner: orangepi-zero2w: enable
 Ethernet expansion
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-submit-acx00-of-dynamic-v1-v1-18-0a53cd9e21cc@gmail.com>
References: <20260802-submit-acx00-of-dynamic-v1-v1-0-0a53cd9e21cc@gmail.com>
In-Reply-To: <20260802-submit-acx00-of-dynamic-v1-v1-0-0a53cd9e21cc@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Maxime Ripard <mripard@kernel.org>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Saravana Kannan <saravanak@kernel.org>, Lee Jones <lee@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 mfd@lists.linux.dev, linux-rockchip@lists.infradead.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

The optional Orange Pi Zero 2W expansion board exposes H618 EMAC1 through
a 100 Mbit Ethernet jack.

Add a reusable H616-family description of the AC200/AC300 EPHY wiring
alongside its first board user. The forced-ID link PHY selects the
populated control path and AC300 tuning range from the logical SID
configuration field. Keep the AC200 I2C controller and AC300 MDIO control
node at status fail-needs-probe so only the selected path claims its pins.

Enable EMAC1 and its PWM clock provider through the common include,
provide the board's 3.3 V rail to either companion variant, and make EMAC1
the board Ethernet alias.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 .../boot/dts/allwinner/sun50i-h616-acx00-ephy.dtsi | 61 ++++++++++++++++++++++
 .../dts/allwinner/sun50i-h618-orangepi-zero2w.dts  | 13 +++++
 2 files changed, 74 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-acx00-ephy.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616-acx00-ephy.dtsi
new file mode 100644
index 000000000000..26521429957a
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-acx00-ephy.dtsi
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Common X-Powers AC200/AC300 Ethernet PHY support for H616-family SoCs
+ *
+ * Copyright (C) 2026 James Hilliard <james.hilliard1@gmail.com>
+ */
+
+&emac1 {
+	phy-handle = <&acx00_ephy>;
+	status = "okay";
+};
+
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3_pa_pins>;
+	status = "fail-needs-probe";
+
+	ac200: mixed-signal@10 {
+		compatible = "x-powers,ac200";
+		reg = <0x10>;
+		clocks = <&pwm 5>;
+		nvmem-cells = <&ac200_bandgap>;
+		nvmem-cell-names = "bandgap";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm5_pin>;
+
+		ac200_ephy_ctl: ethernet-phy-control {
+			compatible = "x-powers,ac200-ephy-ctl";
+			nvmem-cells = <&ephy_calibration>;
+			nvmem-cell-names = "calibration";
+			phy-mode = "rmii";
+		};
+	};
+};
+
+&mdio1 {
+	ac300_ephy_ctl: ethernet-phy-control@10 {
+		compatible = "x-powers,ac300-ephy-ctl";
+		reg = <0x10>;
+		clocks = <&pwm 5>;
+		nvmem-cells = <&ephy_calibration>;
+		nvmem-cell-names = "calibration";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm5_pin>;
+		phy-mode = "rmii";
+		status = "fail-needs-probe";
+	};
+
+	acx00_ephy: ethernet-phy@0 {
+		compatible = "ethernet-phy-id0044.1400";
+		reg = <0>;
+		nvmem-cells = <&ephy_config>;
+		nvmem-cell-names = "configuration";
+		x-powers,ac200-control = <&ac200_ephy_ctl>;
+		x-powers,ac300-control = <&ac300_ephy_ctl>;
+	};
+};
+
+&pwm {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero2w.dts b/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero2w.dts
index b340bbcb710d..e833ee267c83 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero2w.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero2w.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include "sun50i-h616.dtsi"
+#include "sun50i-h616-acx00-ephy.dtsi"
 #include "sun50i-h616-cpu-opp.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
@@ -17,6 +18,7 @@ / {
 	compatible = "xunlong,orangepi-zero2w", "allwinner,sun50i-h618";
 
 	aliases {
+		ethernet0 = &emac1;
 		serial0 = &uart0;
 	};
 
@@ -54,6 +56,17 @@ reg_vcc3v3: vcc3v3 {
 	};
 };
 
+&ac200 {
+	ac-ldoin-supply = <&reg_vcc3v3>;
+	ephy-vcc-supply = <&reg_vcc3v3>;
+	rtc-vcc-supply = <&reg_vcc3v3>;
+	tv-vcc-supply = <&reg_vcc3v3>;
+};
+
+&ac300_ephy_ctl {
+	vcc1-supply = <&reg_vcc3v3>;
+};
+
 &codec {
 	allwinner,audio-routing = "Line Out", "LINEOUT";
 	status = "okay";

-- 
2.53.0

