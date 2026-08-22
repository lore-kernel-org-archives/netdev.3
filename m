Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB5C331EB5
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 04:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787374614; cv=none; b=UDAB9wll0IgY+uDQN/A1s+hSa6+sgc4Dtv/InofY+FxjEDMrzffta6UtRQoZgiW9z4g+5jSOjb8CYSKrEkfKdel5APfZGsbNM1aE+wb58iENOCxdpgo88ggv1QZ5eo68IBqea5Yb0LsSRWuvw8NXXkxVV2qoS47MrfbnLCSGIl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787374614; c=relaxed/simple;
	bh=fP+qKtTIcy8MzuED25rxZArV9yzQPv2a5Db5TPPQjsg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X/Hw3QrDj1zKnxtUoqWPjq3DnyBeUnqB5DiUn/qVDkOx2JGoO/LIy6EGGLA1nsCPyG+qTFM3LMxZOwjczB7LNB9AkSw8D3z7HhEufwiLkT9sTUsiDyNM/wpVPl0VicvM9AhwYE5CH68TxTSOHt7GSd0vYj7LeRhExOa8dfHj1Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUNS+34G; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUNS+34G"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5bf959b820cso1442041e0c.3
        for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 21:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787374611; x=1787979411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=X7uhZqj8EhSGPrmJQzoEFJmHOmX4H/O39nsiw9Yu8Bo=;
        b=RUNS+34GPbGSEPhv/HDKei1kTj9Gf0nQvxQFOvcMJEgG3nvkwhfE+y7pGRvcP0/kbP
         KH7LB1cFi8gXUrW2xGJNRKRsGhOE3H+vWMtM1/4fRKOZhubUDlYSpo6lMkT/xzVwSomu
         OhOwR6yJ4sK/XEdEMKtZt97B1ZFMQf2YbFCZmePDspwCG1towcbotQrcmbhCRmMwcv2a
         XA/q7GjjokptB/Iymi3spPJfwQ5Lwlvp5qyebLTFo3XtFvshhiUyqbETL2yUWbEawI2B
         l0mkef5UpKvOyBUIyCHiEzzj8BJwIYDdKscvwOwgoPN0v5gR3epL872LBM9r9T36w5cI
         GfVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787374611; x=1787979411;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X7uhZqj8EhSGPrmJQzoEFJmHOmX4H/O39nsiw9Yu8Bo=;
        b=tI2z3qsHCDkH1BZj0+CpKxVaaVd/CpG1B2lSA1co3tQUUCBOlxAhkOeUeA2lGbSzlU
         jQ2SKmISZTE1oQ1EDziXV4oeVf7x3Est9Rmi3ad/OAAooOXVsmMgpxsXAi2RdAFFszUG
         zL2bgLW1gkEChD2Okx2tcDn1W8yup4Fwkplj6CkNAu1DXe/FGpfA4mwW7taQjT5fAqj0
         ZQ0L8K7G2+1Iic/fTD1Drwym+ANLcq15+QvQsXEVoJbuz02mZdu00We30IexBeaP9BGX
         Z8imrGxDljO73OTv8E6p9Z46pCtaeNYtRDvuCGUMtS3b97Mx5u8760zUqwD4P+j/Kr7E
         aqAw==
X-Forwarded-Encrypted: i=1; AHgh+RoLSy9lWEoizUfxuoC38AZws8onDca0FAcrB7093CwGB3XYZE989uSnQCB2gd/vgQVTXa2KlJ8=@vger.kernel.org
X-Gm-Message-State: AFuF++mNv/I5M9O2U77suokTzGcS5V2l7nO7Az9f+/rCMweakWrj6ysh
	+QkJXOf+pOHLeFNZQlwnzgpvgl/DugAU4t9UDHFTSaq2gZRnwwIHACpb5NAnb0mLM+o=
X-Gm-Gg: AR+sD13qYof3IPvkDl43M50rN7aCIujqjSBzltSq3gj+QSQc7NbSptOwKvOUgLRFopk
	mYJfB0gn+vq76mxJLs70rlSYg2fUSTMTLfX//tC8+ncAakEbAI8NCuxEuuc3pNaKLKb4U9Qev28
	ye4rQEKqveRmPaiTuRcgCN4ks+jAR0aGtp/gOC8R5e7K/gWqsoZuxvirtuju45g1AQb5yIGDfwX
	yeq3i0OArhzO8jqqjbaSoPsGEKcT0RZkWQt+7B3YjLQlqNA3Rhw0gu1Og09l2QsFwpuwMskpq5E
	kZDFJq9KNdMsAGg6/KqIJAeSSrD6+Cc2SjBzBAh6Cw43WD5h5MgSceNmN3NL52BpHNhHcSEGp9p
	CVub/6AIbHiDtwT/YuE/xspeXbdMno8FxtP0OO490ANCaO6rlCJqpqGrchRm+SUgSkiGJeCSG7L
	1189Xswtyw/01PTzZO6k7IdL4NNWZPOI4sgK0OWHkZOeJFpjebFCeQB/FVUtoDek84fiPuzk/eE
	8prlpodqdKwKNs56UEI2CpQ/4Q+lsEjA7ebXTpl8xR4+pgSFSH6xlhap2759jqQNZBinPjeoOw7
	sWhTvUmeRV8BdJqUpgklq114iAuvdtTermzesQ==
X-Received: by 2002:a05:6122:311f:b0:5bd:8c84:59aa with SMTP id 71dfb90a1353d-5c5ff847130mr4814260e0c.8.1787374610916;
        Fri, 21 Aug 2026 21:56:50 -0700 (PDT)
Received: from localhost.localdomain ([2803:9810:4a6f:808:807d:a3e1:35a2:f6f6])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c5e2619f16sm10674273e0c.5.2026.08.21.21.56.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Aug 2026 21:56:49 -0700 (PDT)
From: Pedro Santos <hartmnn.p@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Corentin Labbe <clabbe.montjoie@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-kernel@vger.kernel.org,
	Pedro Santos <hartmnn.p@gmail.com>
Subject: [PATCH net] net: stmmac: dwmac-sun8i: reset the EMAC when opening, not when probing
Date: Sat, 22 Aug 2026 01:56:41 -0300
Message-ID: <20260822045641.19282-1-hartmnn.p@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sun8i_dwmac_reset() asserts EMAC_BASIC_CTL1.SOFT_RST and polls for the
hardware to clear it. That bit only clears once the MAC has a running
receive clock, which on external-PHY boards is driven by the PHY.

Bringing the interface down powers the PHY down: phy_detach() calls
phy_suspend(), which for a PHY without wake-on-LAN ends in BMCR_PDOWN.
Boards that wire no reset line to their PHY, and share its supply with
other always-on consumers, have nothing that undoes that. On the Orange
Pi Zero 3 the Motorcomm YT8531 reset is, in the words of the board's
upstream author, "hardwired via a simple RC circuit, so there is no
GPIO", and phy-supply points at a regulator-always-on rail shared with
four GPIO banks and the SD card.

So after a warm reboot the PHY comes back still powered down. Probe
asserts SOFT_RST, no receive clock arrives, and the reset never
completes. Read off an affected board at boot, before anything touched
the PHY: BMCR 0x1800 (PDOWN set) and EMAC_BASIC_CTL1 0x08000001, still
set after polling for ten seconds -- so raising the 100 ms timeout does
not help. Probe fails with -ETIMEDOUT and the interface never appears.

That the interface teardown is what does it can be shown directly. A
reboot via sysrq-b, which skips both the ifdown and device_shutdown(),
comes up with PDOWN clear and resets fine; taking the interface down
first and then using sysrq-b -- so the driver's own shutdown path still
never runs -- reproduces the failure.

The driver already has the right place for the reset.
sun8i_dwmac_dma_reset() is registered as stmmac_dma_ops->reset and is
documented as "reset the EMAC", but only zeroes a few registers. stmmac
calls it from stmmac_init_dma_engine(), under stmmac_hw_setup(), whose
only two callers are __stmmac_open() and stmmac_resume() -- both of which
run after stmmac_init_phy() has attached and resumed the PHY. Doing the
soft reset there means the receive clock is running by construction, for
every PHY, whether or not a PHY driver is bound, without the MAC driver
reaching into phylib.

sun8i is the only stmmac variant that soft-resets at probe rather than in
the reset hook; this brings it into line with the others.

sun8i_dwmac_reset() stays for the mdio-mux switch callback, which needs a
reset after changing the syscon and cannot use the hook.

Tested on an Orange Pi Zero 3 (H618, YT8531, rgmii-rxid). Five warm
reboots: no EMAC reset timeout, interface up at 1Gbps each time. One cold
boot with power physically cycled, to cover the path this moves for
boards that never hit the bug: same result. 20000 and 5000 1472-byte
frames respectively, no loss, every MAC error counter at zero.

Fixes: 9f93ac8d4085 ("net-next: stmmac: Add dwmac-sun8i")
Signed-off-by: Pedro Santos <hartmnn.p@gmail.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 49 ++++++++++++-------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 48c52eb..748ebab 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -272,8 +272,34 @@ static const struct emac_variant emac_variant_h6 = {
 /* sun8i_dwmac_dma_reset() - reset the EMAC
  * Called from stmmac via stmmac_dma_ops->reset
  */
+static int sun8i_dwmac_soft_reset(void __iomem *ioaddr)
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
 static int sun8i_dwmac_dma_reset(void __iomem *ioaddr)
 {
+	int err;
+
+	/* The MAC soft reset only completes once the PHY is driving the RX
+	 * clock. Doing it here rather than at probe means phylib has already
+	 * attached and resumed the PHY, so the clock is running by
+	 * construction -- including after a warm reboot that left the PHY
+	 * powered down.
+	 */
+	err = sun8i_dwmac_soft_reset(ioaddr);
+	if (err)
+		return err;
+
 	writel(0, ioaddr + EMAC_RX_CTL1);
 	writel(0, ioaddr + EMAC_TX_CTL1);
 	writel(0, ioaddr + EMAC_RX_FRM_FLT);
@@ -740,23 +766,12 @@ static void sun8i_dwmac_flow_ctrl(struct mac_device_info *hw,
 
 static int sun8i_dwmac_reset(struct stmmac_priv *priv)
 {
-	u32 v;
-	int err;
-
-	v = readl(priv->ioaddr + EMAC_BASIC_CTL1);
-	writel(v | 0x01, priv->ioaddr + EMAC_BASIC_CTL1);
+	int err = sun8i_dwmac_soft_reset(priv->ioaddr);
 
-	/* The timeout was previously set to 10ms, but some board (OrangePI0)
-	 * need more if no cable plugged. 100ms seems OK
-	 */
-	err = readl_poll_timeout(priv->ioaddr + EMAC_BASIC_CTL1, v,
-				 !(v & 0x01), 100, 100000);
-
-	if (err) {
+	if (err)
 		dev_err(priv->device, "EMAC reset timeout\n");
-		return err;
-	}
-	return 0;
+
+	return err;
 }
 
 /* Search in mdio-mux node for internal PHY node and get its clk/reset */
@@ -1217,10 +1232,6 @@ static int sun8i_dwmac_probe(struct platform_device *pdev)
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
2.50.1 (Apple Git-155)

