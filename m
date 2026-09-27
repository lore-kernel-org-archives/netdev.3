Received: from mail-oo2-f36.google.com (mail-oo2-f36.google.com [74.125.231.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EC0439328
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 18:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790535155; cv=none; b=Hylf6PQfTDTo7cKjTdVnWWnJ/jbyHoVKCzk8QGzchi69NJyC7tas8SKNvZubORrYxyXmu0GF5TBfHUm+/Iw28lx1hggya0EgpWyklqEjT31ETs8CkKqoU5oWwcoleX2+fsTqIo/YqctCRDmAC8PjQ/uhZw0PiIxhS7RtfdYqHjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790535155; c=relaxed/simple;
	bh=psnWFMW3NPVNytYJTkQa/ZphUpHOQe34G4oYriA8Hk0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sr3CFdI76XakMdfzRnZfShmAmXMI/dZke9SDk0AVGBzdZrAjb2gJHHs2uxsgSVUCBoz9A8JcAQd5g86kIKtx/aYxLfHIQqqa2CM844lbCLsnSntSHSkkd/G5kq4rIKeWL3Ws/DBIgrwdStDIkz0NEyrEhARroqDv+Sb4Vz7dSsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NzPqsZcY; arc=none smtp.client-ip=74.125.231.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzPqsZcY"
Received: by mail-oo2-f36.google.com with SMTP id 006d021491bc7-6d7530420abso675008eaf.2
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 11:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790535152; x=1791139952; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DLWTLjVNNOaJBBp+6jLPkB34blfAphSZQL2nUEax2lA=;
        b=NzPqsZcYPWNlpOL7iawfeAJF6HI4LxbvIyor4lUFGIMzbmGWdFBIHFFOnNDkK9F7VL
         0XiA6yzuPQU5KKcHk6PR4aMW60TbbiLoKfhS/k0nCYxZno1cz1li2TZsBfsLVPIiPHhf
         SfHvj5PqlRT6bYfSm7VhY6kHcbVYp9BQHnab0mjXJKLOkHIHQhZQDUMHLvfsMdzfqp6C
         4wCftZ0YTdmM3KOER76T80SUq8STPjsCCSoYZPWqr6kKV/XYyH1qG4xzSzVTqdSo6IKu
         nG3kbaKCPfsCX/qO9wkVQjQdB2C2fmQRGl3C9OW9JWIRVSN9k71mF1J+3MXqt6YJe0ss
         iKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790535152; x=1791139952;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DLWTLjVNNOaJBBp+6jLPkB34blfAphSZQL2nUEax2lA=;
        b=CRSIheMyFxgoeP0I/y0Gr4Jv1bg3tbAQITRlavXGuCm3KeDlMfgMtPCSiqcC/PCFDI
         zMuvAtfxAP7F9MQ15a2wKGptNNkhR32tNIW+CH0f2S3nNlLjX2txeEZbvfXNikqko07i
         DG0ETRNZqFxX1iSCMO0DWXymJMdpJ+fu6bKYa0yykagZK+0fG/o2V2Bhg4SuYpar4nvM
         VHKIpsjiG6z8P9i68fipt4wpz0ILfGA56XjgwDdd0tF8/GqM9dhs4Hna9Vx9C9zwWQq8
         pkuxIRm5WkldYxvfA2+TPn7j3ajunZMCqpMk84Jj/nbpI7izDulzx4362/9mE7nJ4B2U
         ER5g==
X-Forwarded-Encrypted: i=1; AKwUvBwzlGcmX8Gj8pHCDEsNPbJ40D383DighE7a3x8IGFJNv2BiYG3tCyhRorDGQcTRsr6PH6luw/E=@vger.kernel.org
X-Gm-Message-State: AFuF++k5fTvz3+ysZQ+nNmzLzHvUpFSfJEYu1JazITrOz/6oyuJDAbUv
	CFzIaEyzsgGY+IdL26tVe2g3KcpNIja/xXCNKWr8vsP+LZdxJ4wk2n60
X-Gm-Gg: AYBFou2jZbA3S2v54+AUp3kxpaT+7bTx5Lt2vecvYbsJwkqqAbNsedOxE+weBqM3zbX
	tVnRdSyCOBMMclaEeHQzvhbkRwTRbbtUtbhPIYh8OxtLZ7kRYcNlshdW++7tS1DQwYwgkNqjsLE
	0OmA9+oYoDUgAFQsiDm15as8z3HLQrcq/0G7BNi+2KH3T4N2rL9/lkYmztYZSytW1exLBu5vwLJ
	BI73EMb87JBrW1lyKfH6R6XgreRLuD9xRxXde9oOZIbvrNClhuERFexzD9dB+e3rGjIotOM04Gi
	VPzY09acSxqSuCoCL7FwEnljjBXmSHFw2DwOFTu0sfltSe2zHlxZZE3iELKCx/RbUvc1TQupS64
	O8NF9fV3WcUsKuULDJ515ibpJrWWTfhCe+L0hwERzyFNknMazm61xUj4QzGoiKHwClvfAKHhJaT
	RUesrBL7e1gkfPS9O6Fo4F+qWVVhUv1XFVPP4HLrVLWfOpCvbC3pYMKmt8kq1SZOnkPVOqFp19V
	0fxi7UiHMn2mVlnYaShVhqwOGpL5cTnA+ZHvbda4pB5aM0TSWkmGlmOhyYfLZCQC0GxKKZjsP2H
	B2tEwv5DL0ULwgi+HXGCj224+Cs6UvZPBLioWPqMHTfMJ1aWOFHo/yTcfyXa0WSjWqARVCoarVP
	7Q4cxo/mPrYdK9s/WP96R
X-Received: by 2002:a05:6820:4c82:b0:6b7:46fa:169a with SMTP id 006d021491bc7-6d43ff69796mr10523773eaf.47.1790535152003;
        Sun, 27 Sep 2026 11:52:32 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-494877590e5sm4489452fac.13.2026.09.27.11.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 11:52:29 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 27 Sep 2026 12:52:19 -0600
Subject: [PATCH net-next v6 1/3] net: stmmac: sun8i: reset the MAC after
 PHY initialization
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-submit-h616-emac1-v1-v6-1-e64971f4e414@gmail.com>
References: <20260927-submit-h616-emac1-v1-v6-0-e64971f4e414@gmail.com>
In-Reply-To: <20260927-submit-h616-emac1-v1-v6-0-e64971f4e414@gmail.com>
To: Richard Genoud <richard.genoud@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 LABBE Corentin <clabbe.montjoie@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>
Cc: Alastair D'Silva <alastair@d-silva.org>, 
 Maxime Ripard <mripard@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, netdev@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.15.2

The MAC software reset needs a running receive clock from the PHY.
Resetting the MAC at the end of probe therefore fails when the PHY driver
has not been loaded or its probe has deferred on a missing supplier. The
failure removes the MAC and its MDIO bus, so loading the missing driver
later cannot recover the interface without reprobing the MAC.

Perform the software reset in the DMA reset callback instead. The stmmac
core calls it during hardware setup after attaching and initializing the
PHY, and resumes a suspended PHY before reopening or resuming the MAC.
Mask interrupts before requesting the reset and retain the existing
DMA and interrupt-register clearing even if the reset times out. Return
reset errors through the normal hardware-setup error path.

Remove the unconditional reset from probe. Keep the separate H3 MDIO-mux
reset after switching the mux and powering the selected PHY, since it is
needed to latch the selected interface before MDIO accesses.

Fixes: 9f93ac8d4085 ("net-next: stmmac: Add dwmac-sun8i")
Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 53 +++++++++++------------
 1 file changed, 26 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 38d7e71de925..5691da796454 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -269,11 +269,33 @@ static const struct emac_variant emac_variant_h6 = {
 #define SYSCON_ETCS_EXT_GMII	0x1
 #define SYSCON_ETCS_INT_GMII	0x2
 
+static int sun8i_dwmac_reset(void __iomem *ioaddr)
+{
+	u32 v;
+
+	v = readl(ioaddr + EMAC_BASIC_CTL1);
+	writel(v | 0x01, ioaddr + EMAC_BASIC_CTL1);
+
+	/* The timeout was previously set to 10ms, but some board (OrangePI0)
+	 * need more if no cable plugged. 100ms seems OK
+	 */
+	return readl_poll_timeout(ioaddr + EMAC_BASIC_CTL1, v,
+				  !(v & 0x01), 100, 100000);
+}
+
 /* sun8i_dwmac_dma_reset() - reset the EMAC
  * Called from stmmac via stmmac_dma_ops->reset
  */
 static int sun8i_dwmac_dma_reset(void __iomem *ioaddr)
 {
+	int ret;
+
+	writel(0, ioaddr + EMAC_INT_EN);
+
+	/* The PHY receive clock must be running for the reset to complete. */
+	ret = sun8i_dwmac_reset(ioaddr);
+
+	/* Leave DMA and interrupts disabled even if the reset timed out. */
 	writel(0, ioaddr + EMAC_RX_CTL1);
 	writel(0, ioaddr + EMAC_TX_CTL1);
 	writel(0, ioaddr + EMAC_RX_FRM_FLT);
@@ -281,7 +303,7 @@ static int sun8i_dwmac_dma_reset(void __iomem *ioaddr)
 	writel(0, ioaddr + EMAC_TX_DESC_LIST);
 	writel(0, ioaddr + EMAC_INT_EN);
 	writel(0x1FFFFFF, ioaddr + EMAC_INT_STA);
-	return 0;
+	return ret;
 }
 
 /* sun8i_dwmac_dma_init() - initialize the EMAC
@@ -738,27 +760,6 @@ static void sun8i_dwmac_flow_ctrl(struct mac_device_info *hw,
 	writel(v, ioaddr + EMAC_TX_FLOW_CTL);
 }
 
-static int sun8i_dwmac_reset(struct stmmac_priv *priv)
-{
-	u32 v;
-	int err;
-
-	v = readl(priv->ioaddr + EMAC_BASIC_CTL1);
-	writel(v | 0x01, priv->ioaddr + EMAC_BASIC_CTL1);
-
-	/* The timeout was previously set to 10ms, but some board (OrangePI0)
-	 * need more if no cable plugged. 100ms seems OK
-	 */
-	err = readl_poll_timeout(priv->ioaddr + EMAC_BASIC_CTL1, v,
-				 !(v & 0x01), 100, 100000);
-
-	if (err) {
-		dev_err(priv->device, "EMAC reset timeout\n");
-		return err;
-	}
-	return 0;
-}
-
 /* Search in mdio-mux node for internal PHY node and get its clk/reset */
 static int get_ephy_nodes(struct stmmac_priv *priv)
 {
@@ -899,7 +900,9 @@ static int mdio_mux_syscon_switch_fn(int current_child, int desired_child,
 		/* After changing syscon value, the MAC need reset or it will
 		 * use the last value (and so the last PHY set).
 		 */
-		ret = sun8i_dwmac_reset(priv);
+		ret = sun8i_dwmac_reset(priv->ioaddr);
+		if (ret)
+			dev_err(priv->device, "EMAC reset timeout\n");
 	}
 	return ret;
 }
@@ -1221,10 +1224,6 @@ static int sun8i_dwmac_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev, "Failed to register mux\n");
 			goto dwmac_mux;
 		}
-	} else {
-		ret = sun8i_dwmac_reset(priv);
-		if (ret)
-			goto dwmac_remove;
 	}
 
 	pm_runtime_put(&pdev->dev);

-- 
2.53.0

