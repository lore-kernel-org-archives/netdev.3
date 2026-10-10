Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A837941169F
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 10:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791629957; cv=none; b=AvqNPpnc+Hw5X52gV+mQx7gsMGdMMW/4PfbGY0Sfj1V9pYVk4J+pXcB3nWWBqyJ7eIMegdzdfeu34cZbVgEWNcMsWi/XeHJbDsHZ7g/Qq9h2EMEfknJk/lrt3WI0IL0NKMJ+5Jky+FQcmci2NJhJ+mQXXQGkhaFP7GdCKZCpb1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791629957; c=relaxed/simple;
	bh=qqF/9hNJkZvz5igwPUH17BMZnyUc6DBPLiCg9tn2gMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qoItPhRuYN8kDJA9J2gLcKTdyD0ZxALwD0OgXacHn32sRlanbG2sFachirGLTIjT6FspgnIPZrX2MEgIazSfXehzX0eDenTiJLkmwxlVrSIZ10svWiqUAUkIqwZeiGYjJB9D0yYszvpnNM6La8KHI3mcsCY8ZSkpmn48bnMWCLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48870973bddso283318f8f.1
        for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 03:59:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791629952; x=1792234752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RQBX2EsGilW7uIgdk0tYqFZ4ZqmuLdnOK0NA9yKXMRg=;
        b=zvTTYAZjQGEhTza5w40A6Q22+g9tDo4SbPwEDsWXhOkamaiWmsyn3TCuTzok4kL543
         h0F/q7yJ7B4iLqY4TI68X25ot/QJDTrsu3qnQueFC70C8x2ZlLceXqQvDPuxPC3jelG3
         boVKLYAr930nm7EgXahk95l629KqW8gh7MtwdIKUvhHEjXVlPW22Ge7XxFJRNeNyMexx
         tb+SoPgxGrwjDGl6Lq2NNrLGXponAStpe0QnVwpaQDRzQi/7DctFD20ZoLCyG1+kCC15
         Azgaw+l/z9UapSzZp2tj2Th0isHfu4TKL3C/Oe1xP890kTFbFPl1vRNNpp30XR+0gIuZ
         nwPQ==
X-Gm-Message-State: AFq9FYJg6WGyH3ryrAvAXsWG7iENwvgIWKlSrEa+CRZo3GAGaT2GLPXZ
	kF0nI7IEyyeeLIsMt2jCVAHi+N7kA/k1Y5A2NMfzhW9q0XXVfS2CgPjp
X-Gm-Gg: AYBFou05Re/JuOPntlVRpBvYffybPxlRpZu4TlZO2zn2ViWRTiUViQRf3qQXrwfD+bD
	Sy6pTF3Xyfc8+d6N5kNyhiuAXO7/RqxD21xLQe0RfNxifzMDXQygZBNcv7IrYUrvAJM56MAl9Op
	5Z6zqez6MwfoP9TAr2JgYa9YjXse1sKhOxVMTSG+KiMcEwZjMM1j1pwwyrnO4R9ZqJCO8YZaipZ
	4/IKqx5Q1MY9PSAEgioWZECeiUw/V29FvNHGkwr2Kmjh9TT8W15NKRcNe7cfrx5FfNl5MvYgNo1
	YEGigashitH0at3uk0dhB2wZG1C6xkGY4khxXaLZQfecwbhJ4rZaQjP1k1lzB0yR97WAmsi+vXS
	I8VcMFCRFOXsksuWaI7cf5/+aj9hBqbBaaWnMztdzBBjjvHP1qPugH8m2WOO2/kJNR5YncyQ9Lx
	Jk7C7IO4i+Yxp9ClxrwGlERjmCaKvxgbrqfzcrb91gw4stwNLsrMj9H58FY6+5L0Zg3RvUL8juq
	/xjDDOgMoMAQVK3Pk5R9tllShYZb4o4wxs=
X-Received: by 2002:a05:6000:2306:b0:488:8347:a110 with SMTP id ffacd0b85a97d-48dba9e6163mr7697023f8f.7.1791629951651;
        Sat, 10 Oct 2026 03:59:11 -0700 (PDT)
Received: from threads.localdomain ([84.70.176.222])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9ae17e9sm8709526f8f.57.2026.10.10.03.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 03:59:10 -0700 (PDT)
From: Lucas Tanure <tanure@linux.com>
To: xianwei.zhao@amlogic.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/8] arm64: dts: amlogic: t7: khadas-vim4: enable the ethernet port
Date: Sat, 10 Oct 2026 11:58:59 +0100
Message-ID: <20261010105900.247342-8-tanure@linux.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261010105900.247342-1-tanure@linux.com>
References: <20261010105900.247342-1-tanure@linux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The board carries a Realtek RTL8211F gigabit PHY on the external
management bus, connected to the MAC over RGMII.

Enable the controller, hand it the ethernet pins and point it at the
PHY. RGMII needs a delay on each of its two clocks, and on this board
both come from inside the chips, not from the board traces. The PHY
adds the one on receive. Its transmit delay does not work here, so the
controller adds that one.

The PHY interrupt output is wired to GPIOH_6, so link changes are
reported instead of polled. The PHY reset is an RC network on the
board, not a SoC pin, so there is no reset line to describe.

Assisted-by: LLM
Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 .../amlogic/amlogic-t7-a311d2-khadas-vim4.dts | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
index 0fa83362b417..c18bde02ac40 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
+++ b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
@@ -14,6 +14,7 @@ / {
 	compatible = "khadas,vim4", "amlogic,a311d2", "amlogic,t7";
 
 	aliases {
+		ethernet0 = &ethmac;
 		serial0 = &uart_a;
 		mmc0 = &sd_emmc_c;
 		mmc1 = &sd_emmc_b;
@@ -256,6 +257,25 @@ xtal: xtal-clk {
 	};
 };
 
+&ethmac {
+	status = "okay";
+	pinctrl-0 = <&eth_pins>, <&eth_rgmii_pins>;
+	pinctrl-names = "default";
+	phy-mode = "rgmii-id";
+	phy-handle = <&external_phy>;
+	tx-internal-delay-ps = <2000>;
+};
+
+&ext_mdio {
+	external_phy: ethernet-phy@0 {
+		/* Realtek RTL8211FD-CG */
+		reg = <0>;
+
+		interrupt-parent = <&gpio_intc>;
+		interrupts = <GPIOH_6 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
 &i2c_m_ao_a {
 	status = "okay";
 	pinctrl-0 = <&i2c0_ao_d_pins>;
-- 
2.56.0

