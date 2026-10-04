Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2A145A288
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 14:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791124864; cv=none; b=WhRMHgqqh+wN6pKKGivAwEuP3A/q6KybX4N6+pNwUgIYZLnxJN0fVuX6oWdOv95FVKxQzyUrGFssrW+E34SRIHrRgwKLnnN4PO+mvippbYNN+NWrNZdxjMH1koo0CHwfd5jKEzrZCQIpS1K2CE7CuhysxLcuGF4pjnnSaO2KXQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791124864; c=relaxed/simple;
	bh=GmvhDuHgpMxF2f93Qq0ERl8r8HiaQxqlwog46212BSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rdl0nrNJ8iVRPG/3YrExRtkpA/b+jkV47p2F15ise9RpGlWYxGjSv57wK07LS04SJ8nA6a7blyzW7yq1td2xlwoW5lQuFK3Yks/a47JMvcHJH0vq53zx4nFRhQwP4daLrrYGPh4azPazffi20dAIyHoG3Tuq3SeTptpHhqTfPiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd5462b69so6178395e9.1
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 07:40:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791124854; x=1791729654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MZRgdojaRbZiMOWyCy78Vo+uAB8tMtaxuR0FMlqF6Sc=;
        b=uJFWm/ujJmbyzz36VhET8P267s/o+AD901O3RBDcMwaKjhQlf8iohjvZfwNLKg9B77
         wLXzz+7TGXOZ9PuJhOWH8uOgSfwQVg+Mgxa0hGH54e71eQhIlbJ/Eaw6SSZX4UrzUr9G
         OUtJtTufVMqNVB/C2eT0y8KyDdhkKpQqSZ6jXcetBmo4bebUQ/GtTNk+GIVodxcMF54H
         RCw8K2M0ki/cO5a8vWo1I/3Gnw9NbZCow1VHRpC3Yb2A95MZF9LXnza6O8LyohPKGI5x
         NnEhArAY1ZEdCkp81A+hp7/2Ih6ILKIBOZl9zKjOj60pIW3K9/Z2h6oYhYnbdACP++2/
         B39g==
X-Gm-Message-State: AFuF++lxBRh/gtUawwDB4CFl/K6gaWDD0vIqHDXnp5YraQuf6PTqnrxF
	BjfyaJtwbesqTLp3SyI6SKns3ydSaDvupH11NJX+AS1ZwcASMgiutWDC
X-Gm-Gg: AYBFou3sM+GaXsIB6TbIUe55M2Nv2Y8lnld4sUwEBd9sHYlbWgHap7RBGYQw0wal5aw
	gdB+WivHHGYN5JW2uIXWZT/MHZMfbP7JDHPA42Lu4v9C4ZI1HQkFsZGUw/ulqA/QQ4283Z02PXM
	cflAFL6FJzRrxra6jrZ+U9X5NQwZ83YXAOBCp4zv//X/gDt4WD47OEy11QoK+7XxiSbR4kY2aXM
	NrzcrJHhbO3tauVMCkV1NPwq54g4W6EPRWN2RtDPZwirS2rlucPXCxIzOKuwZr+ZZwzaLGaLcTZ
	BNvGvBDAEIyoKrZ7p3tv8PmEQArVnqvKbsgPZ0SA77ejpbqEekbLcPU2YLxS1+yznfRDJiRBtIR
	9A/Jw2Sr5Oz/Uni5fDFvbTEoUSPY5Ttsj0VBrw26wTQWZP4Yi9VPyiu43lVj6msgvCBB//idgUU
	PbpsyVb47Tz34paC9Qgv+7m0x621C5pykOMZD6BDummktv6g+4IAFoSarrfbFWPVuWhx2Uu7qG1
	7V+XzXw8455l5XAn5Nj/iLc7GpPaWk2jQ==
X-Received: by 2002:a05:600c:8b30:b0:4a0:2644:80db with SMTP id 5b1f17b1804b1-4a0276c0b12mr117321955e9.35.1791124854357;
        Sun, 04 Oct 2026 07:40:54 -0700 (PDT)
Received: from threads.localdomain ([84.68.183.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027740a2fsm298907685e9.13.2026.10.04.07.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 07:40:53 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [RFC PATCH 5/6] arm64: dts: amlogic: t7: add the ethernet controller
Date: Sun,  4 Oct 2026 15:40:45 +0100
Message-ID: <20261004144046.391444-6-tanure@linux.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261004144046.391444-1-tanure@linux.com>
References: <20261004144046.391444-1-tanure@linux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SoC pairs a Synopsys gigabit MAC with a small block of glue
registers that selects the interface type and trims the clock timing,
and with a multiplexer that points the management bus at either the
on-chip 100M PHY or the external pins. None of it was described, so the
port could not be used at all.

Add the controller and the multiplexer. The MAC reports a 5.10a core.
The path the controller reaches memory over runs through a pipeline
stage with a gate of its own, so hand that to the controller as well;
nothing else claims it and it would otherwise be switched off as unused,
leaving the port unable to complete a transfer.

The on-chip PHY behind the second port of the multiplexer is described
the way the G12A does it. No board in tree uses it and that path is
untested.

The controller is left disabled for boards to enable.

Assisted-by: LLM
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

