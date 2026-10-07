Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC38442397
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 08:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791361604; cv=none; b=boxkgOTZ5X2SoHzobPhbcWsGofZvdhiiNNCf/KMc6+ZI6MPHXh3c/LNUvJ+W92TsJ7kDqw7/zI9ppZ3sVwbS8D9X6C60Vlpred+nGatcvyEdiMXLchcq14bLMnBt+tSLfUX6OJakdK3ZJQLXOv+YjCRvO74A/1Vg19aR5q9NsTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791361604; c=relaxed/simple;
	bh=5tlL+2agJ2s9km+DZ2KGJFImg/1CkMbVGilWBDkZMNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bBdGUuYTkM0V/U0YxEdbCKBvgG3OX/v64blmO8b9Lvac2Uw16hs6UD0xFx+HiUUSL94IU9SQb+8aQ/m0Z6TTk4Mw+kbCE1E5J0mw6NdxH/UG5EZei5Em4EFQ7VybWPeOzc+RoM6PDakjcXfSgNbvmzs4Uj+6y5QC2/uWxGXLdbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48870973bddso946337f8f.1
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 01:26:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791361595; x=1791966395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rz1uNP1/6zGDpEzl8JcWI5dNkU1Wh/FOy/3g1YXciIM=;
        b=Wpid0+bjbcOYPpyDVl4FTQJiy/OiAo0/cy/ArrirD73VpiXMA/+jxfymdC587AnXEf
         a1gHje8kYun+oSCI5A4heaU1xUmgm9M/+ZuUwZLXLd9lwt4avwh33BDsSgAijvw4fUCp
         +rYZY2ro797hpKEmamkMfijpa9mfgR9l92yFPdIjv/KEZ+I7DoKsQlCcgOIS60QYKK56
         yHNWHD7i+tGAlpoCE+xJqWYFoU/AMvmbbjdgGi/xas66wlpWWYu0Zb55TKEYICG2A38n
         bd8+0UL0hxXvlGmr81YtbtFjfn1JuG0AT4jWNVvkmqlW/aLJ0f5FnM+EAF12WWpeIIX3
         EGJQ==
X-Gm-Message-State: AFq9FYIdeCLqB1hJ2gNJUEH3y35EW0E5d2x80Mg8n4I+tXINLTlF2CCk
	P+PxlpjPOHFUHDMJ4N8sj/hfGnhjMKxZBRNjZjPRG6AgSX91XUl6+S9d
X-Gm-Gg: AYBFou0GWFEcYh/ugUCKAQtL9IP93xctA5LJLC0u3KcTTT3YK25/9JNqrukh69HtVYs
	McSVQetSXQzIrFw0IJOoSr7f9NKvc79l/AmciGpQG7SyaRW0wfb9RzbM6st7oMmVNyDv/8mYTeQ
	IU1MESXuzr8C7CkOvpPlxb4zl5Uzvdyavan+XQEWwtODa2+y4v22R9/2TjW8GUBldUXnrPHvMLu
	wW8DhaKIlrvu8/spxrQN5sBf4zSbpGsPrCy1WZViAEBWivoe96766ghqTGNF5pdE1GpUlZ6LUVO
	dsK0TVHZqfY4IANcQnHyL1Lv8GDrSSVIP7vBskoJwfWF5q4suScDxv8EuknVcnhtpmePgWZyY7R
	g7p7THM9sR4j/9/FsuKMKcguU/MzfmMne8RaLzV2pFH+QhJDkL02YRYTWCfLRWjj9T1xPhRflUu
	nSjkBWiZnRi0jTqQn2bYua6xDW7ctmFDkJpy+40wYdZcOcHrjKSP7yerOy+cIDnTamlUjo/+TSM
	u57KPyobVg6HYlwqpdSpuDM4dN3Y6koi8o=
X-Received: by 2002:a05:6000:454f:b0:488:7892:1932 with SMTP id ffacd0b85a97d-48c7256fa0bmr2028288f8f.0.1791361594943;
        Wed, 07 Oct 2026 01:26:34 -0700 (PDT)
Received: from threads.localdomain ([84.70.176.222])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d3b502sm4251370f8f.52.2026.10.07.01.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 01:26:34 -0700 (PDT)
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
Subject: [RFC PATCH v2 7/7] arm64: dts: amlogic: t7: khadas-vim4: enable the ethernet port
Date: Wed,  7 Oct 2026 09:26:27 +0100
Message-ID: <20261007082627.63807-8-tanure@linux.com>
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

The board carries a Realtek RTL8211F gigabit PHY on the external
management bus, connected to the MAC over RGMII.

Enable the controller, hand it the ethernet pins and point it at the
PHY. RGMII needs a delay on each of its two clocks, and on this board
both come from inside the chips, not from the board tracks. The PHY
adds the one on receive. Its transmit delay does not work here, so the
controller adds that one.

The PHY interrupt output is wired to GPIOH_6, so link changes are
reported instead of polled. The PHY reset is an RC network on the
board, not a SoC pin, so there is no reset line to describe.

Assisted-by: LLM
Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 .../amlogic/amlogic-t7-a311d2-khadas-vim4.dts | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
index 0fa83362b417..4a2b0b563655 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
+++ b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
@@ -14,6 +14,7 @@ / {
 	compatible = "khadas,vim4", "amlogic,a311d2", "amlogic,t7";
 
 	aliases {
+		ethernet0 = &ethmac;
 		serial0 = &uart_a;
 		mmc0 = &sd_emmc_c;
 		mmc1 = &sd_emmc_b;
@@ -256,6 +257,27 @@ xtal: xtal-clk {
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
+		max-speed = <1000>;
+
+		interrupt-parent = <&gpio_intc>;
+		/* RGMII_INT on GPIOH_6 */
+		interrupts = <154 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
 &i2c_m_ao_a {
 	status = "okay";
 	pinctrl-0 = <&i2c0_ao_d_pins>;
-- 
2.56.0

