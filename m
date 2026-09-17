Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ED050B41E
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 17:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789667730; cv=none; b=D5YZ2RgyLZp0gmIbXF3eptgeQsE6I2ZzwPyEe2GkFFlik5bKVJS9VRJO4bRr+y66kbL6mN+2zdB+cxyaLzEbWCP5GTda2Yfi+HSx4ceR3WQdj9BjdROOOVI57z+C6uF8F1AvmB0FcXvlsFu4xGg0B6kiAcIYeiQtExWBhdcono8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789667730; c=relaxed/simple;
	bh=uRyBjqqvSFltweei6Uy/M5gNvkY89BEG9UdA/vDzq/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DAL8zT6tg7/FQFjn4KQnH66Fajj2JlcWHw+eigqcHGneE4R5X8yZ2f9XA4pBxwPeHybruTDqowI9Schdt+ii1qNSrG4ietRePVl8b0/0g5bWv0zMzgBkBXFhN14x3qoar/X115npa1z7czh+W9hVsmKdN0ega9wxhl9Nhd2f9HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ta6XfHEi; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ta6XfHEi"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466ccbd478bso544318fac.3
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 10:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789667727; x=1790272527; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=epD9LhruE07/QoJcSKVg/dbrndAnrXPsihPLPnVDq64=;
        b=Ta6XfHEiC0o4bwa/qeXgfuqkqC+9fOGrsij3AFgSYqbhkH9n/afzA5KwEZGc8b9Iqg
         TVJyEUqogBr/bZ8NiTlFnsF1pHd/HCyFVKBgy7MGiq+LeByYlruypHTkSqs6k+CcwEPr
         +xxN7R+cpOMu3t4BrigilmNxwuJZtxw7EYfcvK96+0SVrEv5a3Q3rdWykNw5zL0hBYaM
         rerfYcU0GLZ+LwcNe7CbjlckMX82ifnpxFYvgrfECDqD/9LpZZg+oPQnGrXdRuC90yd6
         AA7v/A0kPacyJ23GKlaA8mKWybwtNWbG5PTeAz9c6GqVI6lCsV9o9IacXzHQp/OplHZS
         WBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789667727; x=1790272527;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=epD9LhruE07/QoJcSKVg/dbrndAnrXPsihPLPnVDq64=;
        b=d8cw3he8vqxz4oBAs99vWiUXOjYcZbCjNT64tKJ8IZcyOakJ3W5yj5bWe/C1lkqZaz
         huKWUQ939+60PLXgYbtaQIy4deUe/7Vt0e9Kbwg+BV1giMBSXFplGIMi1ELgrzXcxRPi
         l30z0DCyv8BlrJNQL/JJI8KY5Z5X9nh1da7XkVWIaUIJHN00lzf+kehrkwO4eJgZQ3sr
         Jh4JV6UeqFkr1kdVsr1CJWArTRTsvV/l8LRc2Ia6IxfCUVe94j8SwvKc2N3aybJ6x2Yj
         EGnUfrEIFLMzI8hs07+LvIYbXqgiF4IDHW6EhR0Wje4l6qr0HakykKkwd4vsO+P+uFNa
         zXMw==
X-Forwarded-Encrypted: i=1; AKwUvBzammZs8K/6Tr9znJJVQglKMkNiuaA1q4W8g9I8F3IzGD8ka4waKyZAHLFxZ3vbm3XJLKfFJu0=@vger.kernel.org
X-Gm-Message-State: AFuF++lImygM60e3DZowheq6mc8jTu+iMguwtxsh2cwoGNKnTgOTHP5z
	t7TQpNRXWxD16c+SzLscKuOBywzQtuSg5E9lCRXXLdx2W1i1BSYe60sQ
X-Gm-Gg: AYBFou0kCeZNfbOaK13hHnSPcZKG3LvhJHTRu4BHm+L2dwbm9C1g9JSFmijwbcSqosS
	rjuF85JWV4s5TweL7Uon7L3A4fLzI7kPqvDDC/72bHgvLFnQsJRvO5ziAVL2k7gHYqJQT9TnRzr
	egMycg9st/qhkBzGXaWPlksP0CrAwsRzsRD3EFWDWqFPFI1MED4jTmIPvGHVLLXpXs30cBfSdIO
	MDUJkz7EoZGtu7axPdGE23HnoilD+GlWfgRNplwY3Cd1I2uvWK2/AcxE7BYT6/qM4ujxfL1vvT9
	478ypMzbxobgR6hXySYdPMn7/wiP+BWkT8hdMSCMoxe9t++V4DgxXleKi1g+LlomijUsdWl/eY4
	zCGx4/CMMwh/0axdIYoq7TBRTOyu8Nt1Uqz6a7xG3E1+13PlanPTCZ/hh/czstFfYpj05O7CSH/
	msMYaFg882J8wiOoo0Jno/9C1oN+3kHS4k8Qp965HoQxiEBp3r5P/VYpYQ8uFa+YcYaZptCmAXD
	zSiFFtTghT8mL9D5dm1pZaK9W496Cq6js9iYBkyh21Hz0tinYPkXhN47b8WGofIcUiNu5NGToVa
	+0qnolmHhHsuHJhPTeW9OheR4+9vpzIxuaptHQz0fnJ+gwLz5sd9Ur4iv5c9lGvtoRVXhHNuSE0
	0Xn0tmA+tpclagyaCvl5MMoVmcjJSaIgN
X-Received: by 2002:a05:6870:224b:b0:475:e0a7:9f27 with SMTP id 586e51a60fabf-48476e837dcmr7230581fac.21.1789667722195;
        Thu, 17 Sep 2026 10:55:22 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-486ab6c1f31sm578446fac.10.2026.09.17.10.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 10:55:21 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 17 Sep 2026 11:55:12 -0600
Subject: [PATCH net-next v3 1/3] net: stmmac: sun8i: reset the MAC after
 PHY initialization
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-submit-h616-emac1-v1-v3-1-62cb8316e19b@gmail.com>
References: <20260917-submit-h616-emac1-v1-v3-0-62cb8316e19b@gmail.com>
In-Reply-To: <20260917-submit-h616-emac1-v1-v3-0-62cb8316e19b@gmail.com>
To: Richard Genoud <richard.genoud@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Maxime Ripard <mripard@kernel.org>, 
 Alastair D'Silva <alastair@d-silva.org>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

The MAC software reset needs a running receive clock from the PHY.
Resetting the MAC at the end of probe therefore fails when the PHY driver
has not been loaded or its probe has deferred on a missing supplier. The
failure removes the MAC and its MDIO bus, so loading the missing driver
later cannot recover the interface without reprobing the MAC.

Perform the software reset in the DMA reset callback instead. The stmmac
core calls it during hardware setup after attaching and initializing the
PHY, and resumes a suspended PHY before reopening or resuming the MAC.
Keep the existing register clearing after a successful reset and return
reset errors through the normal hardware-setup error path.

Remove the unconditional reset from probe. Keep the separate H3 MDIO-mux
reset after switching the mux and powering the selected PHY, since it is
needed to latch the selected interface before MDIO accesses.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 50 +++++++++++------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 48c52eb96233..4523a14f5e0c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -269,11 +269,32 @@ static const struct emac_variant emac_variant_h6 = {
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
+	/* The PHY receive clock must be running for the reset to complete. */
+	ret = sun8i_dwmac_reset(ioaddr);
+	if (ret)
+		return ret;
+
 	writel(0, ioaddr + EMAC_RX_CTL1);
 	writel(0, ioaddr + EMAC_TX_CTL1);
 	writel(0, ioaddr + EMAC_RX_FRM_FLT);
@@ -738,27 +759,6 @@ static void sun8i_dwmac_flow_ctrl(struct mac_device_info *hw,
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
@@ -895,7 +895,9 @@ static int mdio_mux_syscon_switch_fn(int current_child, int desired_child,
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
@@ -1217,10 +1219,6 @@ static int sun8i_dwmac_probe(struct platform_device *pdev)
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

