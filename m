Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2CA43E4B0
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 08:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791361593; cv=none; b=qNOstNDh9Klb44ZQKe1HnYWUSMz9nWeE8H5oZ77sJIXULffYCxdMJtfq+XVMm4s/EQV+uJ7YAFaJjLHbDv+6vDkVjvRJED7ldI/fz6g4hqfmftdkPOnlZ1mKvdPoGnnlPaKKTK+L+FQo9IWUeM1ORBVn+F4wYx21mgeKYUAVXD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791361593; c=relaxed/simple;
	bh=vpIj2UvLb9aw8rcNInqkcoO/0+5t9pSXrN9HKJ6PL/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ESUf+p3jJSkyl8BA0vVp2AKfo7m4lgp5BLrAEjAXPD7A9JQblGHrGXPEzj3fPm+avBQ/q0RVUP6S5fpbPXWT6Nt1foGeJldz1SvWNJJvlFfS8U77AbYjRzc1gTVVMMUckhoNYUu15AtahQNdAyGIKMvda97ofKlkSp2OPS9not0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48afcd7ba9bso890255f8f.3
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 01:26:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791361590; x=1791966390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qQePSOktcZsNwbFN9JzDoxNSE7kDsX9flymDNSHZKFQ=;
        b=JwwgyrLdLuDPeYtR5r6jkj+SeKFSXb0otHgM/52ygoLKiF8DViq0hE/cM252Tm7Udc
         PXUu4+mrNC7z7DVr7Vk1WwFNQGbvyvA3i8al+bA0wYrti7bBZShgOdVV4+CWmDj2l1Mj
         lUp4Js+3gu3IT3se3PazVa3wdi827pXxNJgOV9G+15lhXd3nUCuRjr5yXbHAXl00sFCW
         3bfozOtnPfQU1itN+qNsR0tbXua+h1eY40KFHU3VIJb119/BdajUyXVAz4Le0XFuZ3qN
         cPQCl32otneNbCyVAENMRzdZWVcJcdTCt3DJSRmeszq6qJAVtJM0DN9ZZa0Qo0r6FBIq
         K40A==
X-Gm-Message-State: AFq9FYLhQN/nhu5Qk3nKd9r35HFoOy53Tt6sab+ZIYF0Rtq23B4FIiP1
	nlU6cT9FkiABleEHiRaeJ3guAUHYWNssDkVSf1+WNdeIruo6jyXAzlY5
X-Gm-Gg: AYBFou37u88z0eRWFeVNsVywx++Gw3j+CccehZTSV4h1nDSyd++Hb2XhoJ/tvqtIGMm
	CpotOGRFyM2BCJSLt7HDOTcQUb1PCDnpA9NYKdHZN+A3RJe9GJQAJ0fvR8tEx/pQjXlUOwabp2D
	VFwKS4SVitdMGUCwtNziC62zgXAhTrTElEsfXcaSPOt7QFPPl9ikBwHmGBwXh6jLb4R9JR/pfMp
	ZCrwmgeXKaMYSQBTWQ6yhFVublXRhbqzkAfm/c9tCIufP9b7G5koEMvH0MAxiCnvjLh6VRxd8C7
	un2wipnoJCmFUDAAz6ilp9xRucFcqwXdZuFCTJ7aucWYfMUMC9boWfshm/BHa1XB+lJUhVdbkaN
	dkn6CzgG2UOjlfOdM8ff7xKlfwKY0VBfhFwCC645Ptbw1NIyt9YX0oskq/3/TdJO1OcvgRGaRWZ
	Mq0yyayXi73edKheud6b+oAWY5oN2sQBGbxR9q5EMCmO2p3HW4ou6i6X9qMihR3c9oZHZEBK1Mm
	ZL9l5JOv/jDZbJZ1o2J4wpHglau6ocDMd/d
X-Received: by 2002:a5d:5f92:0:b0:48b:a6:61b0 with SMTP id ffacd0b85a97d-48c7289c820mr3137268f8f.47.1791361589960;
        Wed, 07 Oct 2026 01:26:29 -0700 (PDT)
Received: from threads.localdomain ([84.70.176.222])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d3b502sm4251370f8f.52.2026.10.07.01.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 01:26:29 -0700 (PDT)
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
Subject: [RFC PATCH v2 1/7] net: stmmac: dwmac-meson8b: let the controller apply the RGMII delays
Date: Wed,  7 Oct 2026 09:26:21 +0100
Message-ID: <20261007082627.63807-2-tanure@linux.com>
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

RGMII needs a delay on each of its two clocks. A board can get it from
the length of its tracks, from the PHY, or from the controller.
"rgmii-id" in the device tree says the delay is added inside the chips
but not which chip adds it, and the generic tx-internal-delay-ps and
rx-internal-delay-ps properties name the controller.

This driver ignored those properties. In the "-id" modes it switched
its own delays off and left the whole job to the PHY, so a board that
asks the controller for one of them does not get it, and a board whose
PHY cannot supply that delay has no usable link at all.

Boards not using those properties behave as before.

Assisted-by: LLM
Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 .../ethernet/stmicro/stmmac/dwmac-meson8b.c   | 46 ++++++++++++++++++-
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
index e4d5c41294f4..d73dfd0ac167 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
@@ -92,6 +92,8 @@ struct meson8b_dwmac {
 	struct clk			*rgmii_tx_clk;
 	u32				tx_delay_ns;
 	u32				rx_delay_ps;
+	bool				mac_tx_delay;
+	bool				mac_rx_delay;
 	struct clk			*timing_adj_clk;
 };
 
@@ -299,6 +301,22 @@ static int meson8b_init_rgmii_delays(struct meson8b_dwmac *dwmac)
 		delay_config = rx_adj_config;
 		break;
 	case PHY_INTERFACE_MODE_RGMII_ID:
+		/*
+		 * "rgmii-id" only says the delays are internal, not which
+		 * side applies them. The *-internal-delay-ps properties say
+		 * it is this controller, so leave ours switched on.
+		 */
+		if (dwmac->mac_tx_delay || dwmac->mac_rx_delay) {
+			delay_config = 0;
+			if (dwmac->mac_tx_delay)
+				delay_config |= tx_dly_config;
+			if (dwmac->mac_rx_delay)
+				delay_config |= rx_adj_config;
+			else
+				cfg_rxclk_dly = 0;
+			break;
+		}
+		fallthrough;
 	case PHY_INTERFACE_MODE_RMII:
 		delay_config = 0;
 		cfg_rxclk_dly = 0;
@@ -384,6 +402,7 @@ static int meson8b_dwmac_probe(struct platform_device *pdev)
 	struct plat_stmmacenet_data *plat_dat;
 	struct stmmac_resources stmmac_res;
 	struct meson8b_dwmac *dwmac;
+	u32 tx_delay_ps;
 	int ret;
 
 	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
@@ -409,9 +428,13 @@ static int meson8b_dwmac_probe(struct platform_device *pdev)
 	dwmac->dev = &pdev->dev;
 	dwmac->phy_mode = plat_dat->phy_interface;
 
+	/* the generic property is preferred over the vendor one */
+	if (!of_property_read_u32(pdev->dev.of_node, "tx-internal-delay-ps",
+				  &tx_delay_ps))
+		dwmac->tx_delay_ns = tx_delay_ps / 1000;
 	/* use 2ns as fallback since this value was previously hardcoded */
-	if (of_property_read_u32(pdev->dev.of_node, "amlogic,tx-delay-ns",
-				 &dwmac->tx_delay_ns))
+	else if (of_property_read_u32(pdev->dev.of_node, "amlogic,tx-delay-ns",
+				      &dwmac->tx_delay_ns))
 		dwmac->tx_delay_ns = 2;
 
 	/* RX delay defaults to 0ps since this is what many boards use */
@@ -424,6 +447,25 @@ static int meson8b_dwmac_probe(struct platform_device *pdev)
 			dwmac->rx_delay_ps *= 1000;
 	}
 
+	/*
+	 * Each property names one clock this controller delays itself. The
+	 * PHY must be asked for whatever is left, or the two would delay the
+	 * same clock and push it past the window.
+	 */
+	dwmac->mac_tx_delay = of_property_present(pdev->dev.of_node,
+						  "tx-internal-delay-ps");
+	dwmac->mac_rx_delay = of_property_present(pdev->dev.of_node,
+						  "rx-internal-delay-ps");
+
+	if (dwmac->phy_mode == PHY_INTERFACE_MODE_RGMII_ID) {
+		if (dwmac->mac_tx_delay && dwmac->mac_rx_delay)
+			plat_dat->phy_interface = PHY_INTERFACE_MODE_RGMII;
+		else if (dwmac->mac_tx_delay)
+			plat_dat->phy_interface = PHY_INTERFACE_MODE_RGMII_RXID;
+		else if (dwmac->mac_rx_delay)
+			plat_dat->phy_interface = PHY_INTERFACE_MODE_RGMII_TXID;
+	}
+
 	if (dwmac->data->has_prg_eth1_rgmii_rx_delay) {
 		if (dwmac->rx_delay_ps > 3000 || dwmac->rx_delay_ps % 200) {
 			dev_err(dwmac->dev,
-- 
2.56.0

