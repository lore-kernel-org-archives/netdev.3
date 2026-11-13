Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794572341;
	b=KhHeZGAeAbAqawiHWhEycltBJjcGlO52cGTexkp/NvghnDotsNTTPeWAqSB6296ne5AE
	 aeRk6+l8pQvVWLER777UHQs/3DmS+4b/1mqcxjMspDeOmE3JhyUvLBKd6GalD7GTnY0X3
	 ER8fMa3BEb+z8I4bUHAjtymN8Wsw6XOc0Hxp+TZmIiur9Ngq/LraymjGqBE8VLK7Ig12D
	 bDmzdL1N+fs6Mv+eP86EDozA5+NLmoMB2lUFN94cR42uSyHGHXsB2OnVyDDmJlh253/9u
	 3ZWdhe2R6+9gl0D8AJRU3dF0b+bZhLk1YI1NcHA44WlUwGhPdBOGmjWJSMfc4+sDfDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794572341;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=k8LUINT1uPJGcPtj79NOLQhhl8W2gjYoDk+VmjrsPuU=;
	b=n60tNCJM9qCQOvI9254oDkRPb1lPUbwFzIXgCw33CYeuLRK+VNQCWagi7JocNFEOHb3N
	 oJOJNmENmovF69UZF47wlwneyg8bm95plUAJ670htc14zZtv7l0vjxySGq9MujzQjQLWM
	 LGptkdjOcgigUCFfCYd7Mqy7MLIc4+BzK7fce/2MLl/rj8sAaGGCyZKlWYYMW1uqwKOtG
	 bjQUPdWlZXnX9A0aYRAmWn02aheBfbqoUfXYa0sX8MwulfvIweN4cR6q6agcH/tKJaKf7
	 M3vzDtexTqgVV03FZ4VUk24C/74jp7x4QKSb+qIynOnOFpOtsE1d5tZfOEvIVFmVEsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66D260A3809
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 12:19:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E66D260A3809
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-492fcbfaa88so395557f8f.3
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 04:19:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794572339; x=1795177139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k8LUINT1uPJGcPtj79NOLQhhl8W2gjYoDk+VmjrsPuU=;
        b=ts92DbdcdpWyYJkf/0ksA2fct2mVmSjyC3FTFItgk82ucSGQWCpVjLZh0vy/JJSK94
         zm5kvmU6kGIdUTcLYKXYdBLS/o3Jo6nyAQ5dkYo5tX3eKa4T8KXqi/L9WQhKIr+6S7J5
         t1JQ4ggK3z4cWwuP8G6xYwS4izlQ8S91AcgLz//vSYX9kNjFvF4lihRyMG3UTDscY4g/
         kLFjsH9LfrSH90c0TjzAxp/nE1K5g2QuGxv0Dl6Xs7pRXXwHsgDKjxqgVqvv5P0TY8Sc
         3iE7frGZV2Da6+fzfT70rQ5sQb6FOoIidomPoo0g4jsdvCDroi28VGGXoD/kFk2/FABk
         gkcA==
X-Gm-Message-State: APuU4Z8e/v0lDFlKfAvrCYolJ2Hxwj7mQq9LYTCMLS/yOz308bcqini8
	rXq4dptsNUy7mm8hyh/WGdkanJfVTOqGIi9U3wJCildKotp4RGfziqZi
X-Gm-Gg: AYBFou2dH6IGEmbIp3bXx7oGQ3cQPk5VV4vPrDREFHi7mMPQ5Oj/6S4vq51L6zyK1LI
	A8gVuPPBuOPjnPZSGSii6O8bdrAnLuPD3lWopUm5gW/0eMCX6gg893V6SPXi6rDXo4WFp1EwDuW
	qSLStdf9vNq6t2uKUtKf6AvEuEXTL4+N0vYVy1xEeODG8dklgcEiIVODvWFHHakEQTWCQH80/EI
	fNPI8tuByT7MnO0tSDLLrwlGgWeD3droRd+2+lHep5w3JXtFUlZqDXVKqt39GloWIx0o2jj4cIF
	KKfud6mgDo0qt7zGsIQfcmVHucATboER8O7hYyD4DmdE6PCJ+ij8R9Hv00/ZJfZrqn/FC1+eOSl
	2HHtJPdAsPxPKVNcytho31KBRia11DPgjVegEVAtepHt7o+yrzGweMBTeTxgy8y11KDaFvNdNcu
	DA1XHRsBzepxX1SnpUNE7fqO+MSOgNHnZNbEXnzGb9vmLWiPzJ32bpiY4PXun2oSQvAVakyT1g6
	0x7SN5YA3sKVkXc3jugUNd+jrN7409Riy1PrlZOK6tGwo3io2CmOKJtNMhaQVg55bA8RNI2tY6a
	TMkqqFZBWLbmmbGbJh75EijxmmAxBR2BdM+C9TfibyM2/oGuncCT/DnzV6vj2wnISadq8L1QH5+
	ZBq84DDJytAW7q5SetNEEvhIp
X-Received: by 2002:a05:6000:18a9:b0:498:88f:14c8 with SMTP id ffacd0b85a97d-49c73259e2bmr5745745f8f.9.1794572339177;
        Fri, 13 Nov 2026 04:18:59 -0800 (PST)
Received: from threads.localdomain ([84.70.166.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c605e5b2fsm5167103f8f.40.2026.11.13.04.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 04:18:58 -0800 (PST)
From: Lucas Tanure <tanure@linux.com>
To: xianwei.zhao@amlogic.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
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
Subject: [PATCH v7 6/7] arm64: dts: amlogic: t7: add the ethernet controller
Date: Fri, 13 Nov 2026 12:18:51 +0000
Message-ID: <20261113121852.334604-7-tanure@linux.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261113121852.334604-1-tanure@linux.com>
References: <20261113121852.334604-1-tanure@linux.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SoC has a Synopsys gigabit MAC, glue registers for the interface
type and clock timing, and a multiplexer that points the management bus
at the on-chip 100M PHY or the external pins. None of it was described.

The controller reaches memory through a pipeline stage with a gate
nothing else claims, so it is switched off as unused. The
glue registers share a clock with the multiplexer, which probes after
the controller has programmed them: unless the controller holds that
clock, the writes are lost and the port keeps the
bootloader's delays.

The multiplexer and the on-chip PHY bus start disabled: a board enables
the multiplexer with the controller, and the on-chip bus only when it
uses that PHY.

Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi | 58 +++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
index 7bd53ec16607..c6797688805b 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
@@ -250,6 +250,31 @@ gic: interrupt-controller@fff01000 {
 			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
+		ethmac: ethernet@fdc00000 {
+			compatible = "amlogic,t7-dwmac", "snps,dwmac-5.10a";
+			reg = <0x0 0xfdc00000 0x0 0x10000>,
+			      <0x0 0xfe024000 0x0 0x8>;
+			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+			clocks = <&clkc_periphs CLKID_SYS_ETH>,
+				 <&scmi_clk CLKID_FCLK_DIV2>,
+				 <&mpll CLKID_MPLL2>,
+				 <&clkc_periphs CLKID_SYS_AMPIPE_ETH>,
+				 <&clkc_periphs CLKID_SYS_ETHPHY>;
+			clock-names = "stmmaceth", "clkin0", "clkin1", "pipeline",
+				      "pclk";
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
@@ -645,6 +670,39 @@ gpio_intc: interrupt-controller@4080 {
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
+				status = "disabled";
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
+					status = "disabled";
+
+					internal_ephy: ethernet-phy@8 {
+						compatible = "ethernet-phy-id0180.3301",
+							     "ethernet-phy-ieee802.3-c22";
+						interrupts = <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>;
+						reg = <8>;
+					};
+				};
+			};
+
 			uart_a: serial@78000 {
 				compatible = "amlogic,t7-uart", "amlogic,meson-s4-uart";
 				reg = <0x0 0x78000 0x0 0x18>;
-- 
2.56.1

