Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4A43A7839
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 05:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785734156; cv=none; b=iB0Mj5McNUMOhH2WKlGQSC4d81is1WLe/259gy8FvCa26G/IP+aaotDFdXorrDmtZt93O19Pkqkqw1XgNxHZIEEcjDJXI3GriEm6AQ8KlxHQpec+3y2rtQXQnEbonVUTMv5t10qC/OcndDKmAlloqG146ffBB7+FFjJp7xR1NZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785734156; c=relaxed/simple;
	bh=gC2dTirWRvmFzKHVs4SyB39x7wyh/gb+c26PdnYQrvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=brJsJ0eQaRBtNGFEalNPYADEsBtDBgydvM0NMW3RYACeOFbkvSySuis4c34oSP835My/BGJ4WPzpfW6QVwJevWJDu3MGmHUMz2MxUEU8DSK5gJuLCD/HeAKLKFyazq7DcpQCKuPS0uGtVvqD3CrqzyC6/6LCZTKJuhzGYf6kbi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJhRDaH1; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJhRDaH1"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7e6b5737bb2so2730418a34.1
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 22:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785734153; x=1786338953; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1CvTLJea6zWTpGRaWOgZzRKuhjdqcAVM/Zr8VD5aTmI=;
        b=CJhRDaH17sZ+f6WEkcNxZPkH95uufIyaLG4shHeV+yq5C6bXlvM68L7BmJXYwLlBpe
         6/0Y7ryzQmm4lvq4h5S0TEyWNtp/1GzE1c07glZ0xxUa00sh0VeM57HXQ+g+YJe7t90P
         bth6hkrfQ1N/dFyJaHFgziVlKQv7D4tDWIvSc4H47MjC+Okd0pggJ99LNkPPK6W62oqe
         ibBCUiBXObLLdzyHEwgWIxzXXY0fol+hlUmQ3Hc20Ih8139E4IUZqcxC1qrSfD1DnQy/
         VpsZbeAQdIGTuzO/2CzK9O/yRFxSbZBVtBF+raf/LAUnwSNc0tx2wWosOLXk61HTbnwc
         rxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785734153; x=1786338953;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1CvTLJea6zWTpGRaWOgZzRKuhjdqcAVM/Zr8VD5aTmI=;
        b=Qdx5bMd/jDZl6Gcq8teOi2jEFnvitNNtuO+WCgpAT5vA8zDS6/VqQnmaMusuox218V
         AqOLm+8+YF1lUdaO/MlA/CnxmxAj31WmwJkufKq9zD1VWjnBRlxZZ3LUGwFHiUbrk56g
         iMNYlBs0Y4HFDDMpPIzZfa15Cn84aw7ejzwdfj0ejwHihMr067GbCOFYbTkL+ryGht33
         lxPNbHYmzBxRNYWSfUzw2iLRbyrE8jp6ONElTCEKSrmLo58hVrSYn0izQ0YzxwQLy4kq
         XcuyVKD6LXFlj4t9vsVAYUWcF4n3WgGQnfd6hqL0gBquqwqFMDH9sF6qeSzlpao8CjvE
         fidw==
X-Gm-Message-State: AOJu0Yw/+wYV3z447ntMuyYvx2VcbGiLA3dFPzC0LzQQudCDJn3d+C2k
	u3Uh25smGXNnyUZPQvexAvxfmz1WBvBlx6FqChBGzR1tutBLtVSFQYfS
X-Gm-Gg: AR+sD11GvX6+2hvn0KmG5yZNfXtrpNfdhQmKazkPG/QAFe4CG9TQ4BgltxMI6T777vu
	opZelUyZDV7KccuUKagwGmxzwdVwHT5g3+HTMwVCxZqJXsRl3pjYaQKWfWjo2J64XnmQhwqjT/W
	TqP7CP/mKT5VrGzGm1uz8GMoUWlXdVnRYH5uBUHmj2k0rKbFBniRGzjcS4B/A+G/unsN2W2Ij9a
	SBEVIQOmcutzFbZJMXRKpdBhVcs6XcDqTY9eJSYTgTVBxklAiyP6jCr48LTGCAfnXpJVl8yTZ+4
	FVzBInwX8eI55DUQfqTPUw5HusWAXXnbNfFNxMzht0oMhmyReIqCKJrvNihKorgnfrV65IyVshM
	ylSaPrvcLa56njZLek82LLevPbWeaRYHOuofB18WSo2W7vBHGMfp4ervMHIkaYY37wWAh9md4cD
	NjnMGtTc/4pymqvudFmVkc5ZiS0MaCWure0RTnYzOvURxWU4p7RZlwPc1y0Sua/mmx6PJFr+DLi
	WYF8fQdcjO4nUV5ipF0TEttnpAe3mKAHacB/urdwbYjYIsFvFHK74zAMlTTS4LR90gSQBJWIyuv
	MVAEecJEZNwMPuSE70Tp3+L9rBrly8wabTmGdg3vlQl1yRJoIQmGZv81CsjkpUShySx7D2Kg5Fm
	+neBxaCIy6ku65/Tf
X-Received: by 2002:a05:6830:398d:b0:7dc:e090:68a with SMTP id 46e09a7af769-7f1969181f7mr14873339a34.0.1785734152850;
        Sun, 02 Aug 2026 22:15:52 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f18f07a5e3sm6787108a34.15.2026.08.02.22.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 22:15:52 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 02 Aug 2026 23:14:30 -0600
Subject: [PATCH 20/21] arm64: dts: allwinner: h6: tanix: enable AC200 EPHY
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-submit-acx00-of-dynamic-v1-v1-20-0a53cd9e21cc@gmail.com>
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

Enable the AC200 control path and RMII Ethernet link on the Tanix TX6
family, and provide the board's 3.3 V rail to the AC200 function supplies.

Route the PHY interrupt through the AC200 interrupt controller and mark
it as a wakeup source for link interrupts and magic-packet wake.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi
index bb7de37c0d58..6cd75961e3cc 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi
@@ -7,9 +7,11 @@
 #include "sun50i-h6-cpu-opp.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/mfd/x-powers,ac200.h>
 
 / {
 	aliases {
+		ethernet0 = &emac;
 		serial0 = &uart0;
 	};
 
@@ -84,6 +86,22 @@ wifi_pwrseq: wifi-pwrseq {
 	};
 };
 
+&ac200 {
+	ac-ldoin-supply = <&reg_vcc3v3>;
+	ephy-vcc-supply = <&reg_vcc3v3>;
+	rtc-vcc-supply = <&reg_vcc3v3>;
+	tv-vcc-supply = <&reg_vcc3v3>;
+	status = "okay";
+};
+
+&ac200_ephy_ctl {
+	status = "okay";
+};
+
+&ac200_pwm_clk {
+	status = "okay";
+};
+
 &cpu0 {
 	cpu-supply = <&reg_vdd_cpu_gpu>;
 };
@@ -104,6 +122,14 @@ &ehci3 {
 	status = "okay";
 };
 
+&emac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ext_rmii_pins>;
+	phy-mode = "rmii";
+	phy-handle = <&ac200_ephy>;
+	status = "okay";
+};
+
 &gpu {
 	mali-supply = <&reg_vdd_cpu_gpu>;
 	status = "okay";
@@ -119,6 +145,21 @@ hdmi_out_con: endpoint {
 	};
 };
 
+&i2c3 {
+	status = "okay";
+};
+
+&mdio {
+	ac200_ephy: ethernet-phy@1 {
+		compatible = "ethernet-phy-id0044.1400";
+		reg = <1>;
+		interrupts-extended = <&ac200 AC200_IRQ_EPHY>;
+		wakeup-source;
+		x-powers,ac200-control = <&ac200_ephy_ctl>;
+		x-powers,xmii-rx-clock-inverted;
+	};
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
@@ -162,6 +203,10 @@ &pio {
 	vcc-pg-supply = <&reg_vcc1v8>;
 };
 
+&pwm {
+	status = "okay";
+};
+
 &r_ir {
 	status = "okay";
 };

-- 
2.53.0

