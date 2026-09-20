Received: from mail-oo2-f40.google.com (mail-oo2-f40.google.com [74.125.231.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830F548A8A4
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 19:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789933549; cv=none; b=Ej2afd+8FPkfUQyxqumf05iOz7uDysn1HcYj5Y8S9LMiYb/FLvHud2Hte0yUZZsqtFyop+z9ivwbSpDGsrsY3llLAaht0aH3RU+Ndpl53In6ZpLbIgBCeZXaRB63TrilzdZP9Lb3TUZwHWpciaiqb9ATSgthey7cvqW5ojPGRaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789933549; c=relaxed/simple;
	bh=oaAEJTR2oPaosC4rO8wk6R7DRnuHixWUfvmmuYgJ1eA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t6/2bXTRT0Q5s15sFMozDONoGJnD1ADF4CDfvIiblAYuAJ0jS99J0+yiMydOOBnIfQwDEgfoiP2Oaf5XTtDiDugiMBFtTBNS2vaGOwDLszv32AnVp8B8cBHr6Jl8SI3ej0gFpwdsn1AK2CVW5KEKGiqgCp3XzdhfNltMfjvIcqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ToNWCfYE; arc=none smtp.client-ip=74.125.231.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToNWCfYE"
Received: by mail-oo2-f40.google.com with SMTP id 006d021491bc7-6b4bff33ceaso1432743eaf.0
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 12:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789933546; x=1790538346; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GDQtWEdo07Gt04m/i2o6WCXb5iRKSj/hWaaSYGuPoFk=;
        b=ToNWCfYEJqD4Kf0819oEweAReMris2GXt3UmMsTPb0C57kG3hhz5YnIdF4c37+Sx40
         k+KhLR7vILOLa4H7mmkkqXSJi3IVm6r6lxs4OkhzHpP2X//DxprU5Nf+V/H7k1j64lV+
         1PxL/2P8F3i7KLVBOtyBjTPd5neRsrPa8lLNHU0GSWLfAwjTTvw+GgGqEOtE7Tnufn3p
         iQpGjyaYM+4MFZre64NLpgV/pb7vH7m8Z7TDoNAbeNE2x6H+MHtaI28S4IIg3MVMFvRO
         aak64uoNXQVZwh2AvMnM/HGfxGctmEimecbo4gY41LkoNtFqJOLgyU39WN1faBKXW2u/
         dSTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789933546; x=1790538346;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GDQtWEdo07Gt04m/i2o6WCXb5iRKSj/hWaaSYGuPoFk=;
        b=BNa/vQ7OxttMOyh8ubX9Infbg651sS3YY6DZEhUgjJ/mIcVFtGlVZcjObsDDKLNdaP
         LKpQaS3iVSI4uSiEj4SQnANm9GYz/bcHEgr3qJT6OKzDTThzUsZo7UlR/BygSepV0Nvk
         ITX8GfFUipFM6SFNei/mkjI3LKdW42B2FlotRY2I/559HkAK1XYME3GBPp8VBtBk0NcY
         u851s2im3grcAD7IQIrUZ+JVvynbJPsmmcrwjYMHypL3C1yMVKn/oNYytKn5cDaTX7rE
         +fnZMTwkfq6UowtdKYUmXb2535PtBers+FBrP5Ey/2P5ua09IqKj3h3Y6cxZZn+Wr7r4
         PP/w==
X-Forwarded-Encrypted: i=1; AKwUvBweLPLkatBJ8dQ2omSPo6VPMJWQjzI34uSwpGSD7QhJu+9XY1cOFEUJ39evHJKxEk7wtsKylXg=@vger.kernel.org
X-Gm-Message-State: AFuF++nSc1yLd1G9eDtHbeRgNFHJgdF/fzRrikvs8tFtIpNZLeOnlv4a
	RthsbnjkaXKDbG8bkCUk3bbPIrr72KYXy3gr9IcV0Hf7RKDzHi1C4Pla
X-Gm-Gg: AYBFou0gc1ghEkh6BM4f0VYpMweBaQ7TuzEMAF+rKUDNGHnGqXlCRRZ1tooFSdAahWd
	KBLwjUWz/n2nj1ATMmO1Wha909n5Wq8OJ8409HfT6S+l2OXdAwkxeIw7V0+LkYzCNkx1/bx1Wg7
	2nPTxxwhaoQ0vTj/dfBXKx/FdaNOLX1adKEmBbS41A2wUEabVWltbranM5GsqKZvEFaFG0lvjvS
	WkmZc/iGfUNWLtDf9xpAVTnn8Sx0CPSkBR3fTXIweeHHRl/zRs+dLms3qb6J8ejUJxszvBReZ02
	gvdrtNQRSKgwPwtNNbBm5gp8fRqXRT9WPf/D/0xTWkMLN+4L5grhAoppffJc1AFtuzi/wa1Mm7i
	OGGCgrsPy8BhoJUp3RPuf6ljGF+zHHANZ666AbxOXxtToOX0YRcQmivV+M+Ceqo9bq2zjoBolle
	wIdmh5FRhOdGGrfhP5jMihCccHhjzvyy8zkF5KnJ119gh5oNvM6F8Zrb6n86RwSULn0YnZWjUUu
	C+1IkYK/5EJWzLJexrEf8FW3gap8direbK35vmPoRVE3qRErfkH2C09CMw068ZgVf6asyRA+a5s
	cPtOwhxxlS5HVWahOzA1GEyIBTI7W/3clvMW1TvMwxRLNx389cxQfXFjs3zqziMD4y7EKNjmH/q
	zAShl4odEDo0f5JwSzSSY
X-Received: by 2002:a05:6820:160d:b0:6b1:535a:eb8 with SMTP id 006d021491bc7-6ca9a132f99mr8497407eaf.2.1789933546360;
        Sun, 20 Sep 2026 12:45:46 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4881f4d7861sm6103834fac.1.2026.09.20.12.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 12:45:45 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 20 Sep 2026 13:45:30 -0600
Subject: [PATCH net-next v4 4/6] net: stmmac: sun8i: reset the MAC after
 PHY initialization
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-submit-h616-emac1-v1-v4-4-8347dfe2eb7d@gmail.com>
References: <20260920-submit-h616-emac1-v1-v4-0-8347dfe2eb7d@gmail.com>
In-Reply-To: <20260920-submit-h616-emac1-v1-v4-0-8347dfe2eb7d@gmail.com>
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
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Christian Marangi <ansuelsmth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Tiezhu Yang <yangtiezhu@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>
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
Mask interrupts before requesting the reset and retain the existing
DMA and interrupt-register clearing even if the reset times out. Return
reset errors through the normal hardware-setup error path.

Remove the unconditional reset from probe. Keep the separate H3 MDIO-mux
reset after switching the mux and powering the selected PHY, since it is
needed to latch the selected interface before MDIO accesses.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 53 +++++++++++------------
 1 file changed, 26 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 48c52eb96233..9598c386bb21 100644
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
@@ -895,7 +896,9 @@ static int mdio_mux_syscon_switch_fn(int current_child, int desired_child,
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
@@ -1217,10 +1220,6 @@ static int sun8i_dwmac_probe(struct platform_device *pdev)
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

