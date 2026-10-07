Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFF244C665
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 08:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791361604; cv=none; b=WITQm9iUI0Rg97duppEK9nY9L4Y6BmuNw4AgJuWo1gavve1S9gaPSTIF+MFzsFO3S16flIrTpiBs6HJbQAvPYeCBix/FBl+APzggeNDOg774hW03x4VXe9wKSEH5m08kMx17LT3f/gl9ep5evknMCDxtWahzyjo+fBnwy4YCasU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791361604; c=relaxed/simple;
	bh=c7GRPa1MRnZgahEhAkMuYW/f6BU8clPM4mNP2WXx2ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WofhJ51FAmIqcmRM8TLfnWBuxg/ytZa7zmRVet1BppKFPvoQsirCqYENoKy05T/EglTjhWnbOCGiwsN4pwJSej95DCTanlHHweI2c+ipUnTal940l2jsPO4SsV4/qwdvJELIRIubceUgjgxd7z0BO+Uiblocv+4zZVZtt4Jns80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a166199820so9463055e9.1
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 01:26:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791361594; x=1791966394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aKKIB8jplVEe3d7I5HpiWgRDARvx1E69zSOwXtBJM+g=;
        b=gCnUHtZ0vH0jL90A/dpU8bYw0ZHQdm950ctkVXCOD7dGwiFXjQD2Mbwt7YPGlaoKDi
         KnBKdkpc/MkQ/SxxDpucyU2Dj4ph/2q3QjUSznegeyJOf0x4j0DKwKin7vk1LIXh+E3G
         Du2L0DhODRTGSdkiKAhlaEGcJoMMxNW3mbDRVRL9KMtX+i5T1+xe6xmhJN9NVzLRVVwN
         1xc3crwZJHni2168EuNtEHSp3XGc3M80kWPa6n6tF6/GNURWSeImIjx3/pibFqDbP7RU
         ZtPrxO9xf31ZlvutGzCckNaFX2syNZsvoI+j0WKs12Ly0FREjpLdPfyYzQWBBJHxjWaH
         TKMg==
X-Gm-Message-State: AFuF++m25DobYD4Wxka65vHjJn67Wcsj2faSgUjSZw4ltyh3uMcj+tC5
	yOVvvDkUiVKFLzh108oghigB9K4jPnPWILbVJruSFMzT7UxMG9mCXslu
X-Gm-Gg: AYBFou37s5upnagHyBzGYQaIWp2LhMjIlQJuSjH4wQdAEU1eiL1RialtFgZ/lFfXAAu
	7C5tYgnrHA8vk1xbmFcJ/+Jz2XcUifSSozmsrhaD+Ocl7v0mg3MQ+8vUl/n9Wf46odr9hzCk3xT
	LtGQgE520MgV/b2IZ8YGBjFExsuBAj/1XueP1vHPkrPgrxYqRT+XDkYJ7Yh4MMGTcw4+iQIh021
	4Rr1Xg/jv3n2EklBgsHTe9G1VOWJ+tmyL/GHsBM43q4kLt+XkeFGYFDJ4bBQjn9X07Owks/Sgdy
	eqIEPVM2fu1ZIvlJSIavqnLxBzD4pmy6ZK6c00HlOf+RshWsksaq5DuT2EIs3imDRMToBLBPM14
	3FIi1B9CHqec7IvBom+2+XpVvRMP4JnVmKY6gXwu2avhgsXbClN3hHA1rZf60O+YOfM9H+ISbSr
	0LfDAuEVXcSaVlY95tE1kZbZqiQBQ5T9pUsPTSKCRKzmrm+bD0SOLJN6q0O8LTteuywKmS2wjmB
	IHeO7mlSO4btCVFN308fbk1SMU65FK5hqg=
X-Received: by 2002:a05:600c:890b:b0:4a1:7e26:9a5a with SMTP id 5b1f17b1804b1-4a17e269ab5mr38619595e9.15.1791361594101;
        Wed, 07 Oct 2026 01:26:34 -0700 (PDT)
Received: from threads.localdomain ([84.70.176.222])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d3b502sm4251370f8f.52.2026.10.07.01.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 01:26:33 -0700 (PDT)
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
Subject: [RFC PATCH v2 6/7] arm64: dts: amlogic: t7: add the ethernet controller
Date: Wed,  7 Oct 2026 09:26:26 +0100
Message-ID: <20261007082627.63807-7-tanure@linux.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261007082627.63807-1-tanure@linux.com>
References: <20261007082627.63807-1-tanure@linux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SoC has a Synopsys gigabit MAC, a block of glue registers that
selects the interface type and trims the clock timing, and a
multiplexer that points the management bus at the on-chip 100M PHY or
the external pins. None of it was described, so no board could use its
ethernet port.

The controller reaches memory through a pipeline stage with a gate of
its own. Nothing else claims that gate, so it would be switched off as
unused and leave the port unable to finish a transfer.

The on-chip PHY is described as on the G12A. No board in tree uses it,
so that path is untested. The controller is left disabled for boards
to enable.

Assisted-by: LLM
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi | 57 +++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
index 7bd53ec16607..140f1836f3dd 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
@@ -250,6 +250,31 @@ gic: interrupt-controller@fff01000 {
 			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
+		ethmac: ethernet@fdc00000 {
+			compatible = "amlogic,t7-dwmac",
+				     "snps,dwmac-5.10a",
+				     "snps,dwmac";
+			reg = <0x0 0xfdc00000 0x0 0x10000>,
+			      <0x0 0xfe024000 0x0 0x8>;
+			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+			clocks = <&clkc_periphs CLKID_SYS_ETH>,
+				 <&scmi_clk CLKID_FCLK_DIV2>,
+				 <&mpll CLKID_MPLL2>,
+				 <&clkc_periphs CLKID_SYS_AMPIPE_ETH>;
+			clock-names = "stmmaceth", "clkin0", "clkin1", "pipeline";
+			power-domains = <&pwrc PWRC_T7_ETH_ID>;
+			rx-fifo-depth = <4096>;
+			tx-fifo-depth = <2048>;
+			status = "disabled";
+
+			mdio0: mdio {
+				compatible = "snps,dwmac-mdio";
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
 		apb4: bus@fe000000 {
 			compatible = "simple-bus";
 			reg = <0x0 0xfe000000 0x0 0x480000>;
@@ -645,6 +670,38 @@ gpio_intc: interrupt-controller@4080 {
 					<10 11 12 13 14 15 16 17 18 19 20 21>;
 			};
 
+			eth_phy: mdio-multiplexer@28000 {
+				compatible = "amlogic,g12a-mdio-mux";
+				reg = <0x0 0x28000 0x0 0xa4>;
+				clocks = <&clkc_periphs CLKID_SYS_ETHPHY>,
+					 <&xtal>,
+					 <&scmi_clk CLKID_FCLK_50M>;
+				clock-names = "pclk", "clkin0", "clkin1";
+				mdio-parent-bus = <&mdio0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				ext_mdio: mdio@0 {
+					reg = <0>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+
+				int_mdio: mdio@1 {
+					reg = <1>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					internal_ephy: ethernet-phy@8 {
+						compatible = "ethernet-phy-id0180.3301",
+							     "ethernet-phy-ieee802.3-c22";
+						interrupts = <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>;
+						reg = <8>;
+						max-speed = <100>;
+					};
+				};
+			};
+
 			uart_a: serial@78000 {
 				compatible = "amlogic,t7-uart", "amlogic,meson-s4-uart";
 				reg = <0x0 0x78000 0x0 0x18>;
-- 
2.56.0

