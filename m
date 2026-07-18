Received: from shout02.mail.de (shout02.mail.de [62.201.172.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A551EF36E
	for <netdev@vger.kernel.org>; Sat, 18 Jul 2026 13:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.201.172.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784381538; cv=none; b=oH9MuU2Qw3fiBg3GDc3Gp2y+QOW6HdGD68LSR6vRVeHod+eXmu2rSzgRoZR4cvCkDNMT0T9v671/ZYdbp6nruetLgxwxUoQbAWGQnoEl4GrdjkHbcPSWtYH+qiSF61XfkZEzypXuHOsKqbPhattoIb1uw2xknSnOjx6PxCWme6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784381538; c=relaxed/simple;
	bh=i2B9Fykno3BucfFuLCw/ivb9NLxboWJEPV0PeGQi+ik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jiBFCQMYqes+UZ4+e5/MHX+CaSgDyUjlMbGxkXqO5a2TQdeTZN19E5/O94YB/laMTnNDc8eEgWcN/c75usPs+hF8HJJ5ce4dfxlhJq3BzMxkfMhJpxsSAtZZn/qXMQQmmPRZxUx1TRWvYJU0Bx0lIg8JuVaCsaBGDiHkH31Mri8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de; spf=pass smtp.mailfrom=mail.de; dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b=ZO9Nwgom; arc=none smtp.client-ip=62.201.172.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b="ZO9Nwgom"
Received: from postfix02.mail.de (postfix02.bt.mail.de [10.0.121.126])
	by shout02.mail.de (Postfix) with ESMTP id 35D372407DD;
	Sat, 18 Jul 2026 15:32:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
	s=mailde202009; t=1784381535;
	bh=i2B9Fykno3BucfFuLCw/ivb9NLxboWJEPV0PeGQi+ik=;
	h=Message-ID:Date:Subject:To:Cc:From:From:To:CC:Subject:Reply-To;
	b=ZO9Nwgommx1IliBjiVW43TcZle1l11bpYaXunZok5weHtnr1aNkvNTUHnE6emiO+f
	 bRnqYbuytd26rhUCWsODpHx0F8wr/uGz9ptQUzxDqFSuVggzEXvN4yjG+Rb2TGNfYL
	 sW++lmExENAC30TJRge/XxDn0IMuR+iX61Y4UVjlWL+lbF9u2mh6X1PMFgHemtsesH
	 DSVOoqI3/2xPIMwxgZ/+OHqwV2NgbsTC/rEo0L9pnblr8kmy5T/3dY9Y0uxU7mcGq4
	 tQvZ1sFjbPl55zXp9eLvb9DoLwb6VB/4Gaq2x0UAWcMoZh5OLpQPq8qkBK0IuaFqh4
	 TSoD6R5u833pQ==
Received: from smtp01.mail.de (smtp02.bt.mail.de [10.0.121.212])
	by postfix02.mail.de (Postfix) with ESMTP id 135BE2405BE;
	Sat, 18 Jul 2026 15:32:15 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp01.mail.de (Postfix) with ESMTPSA id 37917240CF9;
	Sat, 18 Jul 2026 15:32:13 +0200 (CEST)
Message-ID: <54128253-eb77-48f5-a673-94fb65edb78f@mail.de>
Date: Sat, 18 Jul 2026 15:32:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [REGRESSION][BISECTED] stmmac: suspend hangs since 1b9707e6f1a9
 ("net: stmmac: enable RPS and RBU interrupts")
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, regressions@lists.linux.dev,
 rmk+kernel@armlinux.org.uk, kuba@kernel.org
References: <7941d239-e5f5-43b5-ae0f-20398221e027@mail.de>
 <17ebe5ba-16a5-4b3a-94cd-e9707c88df3e@lunn.ch>
 <72b91ec7-202c-4301-bcd8-b818cf8d72a0@mail.de>
 <21068662-c44b-4266-b634-24e5eac8cd96@lunn.ch>
 <8f6aca6d-6619-401c-bed7-8d42732d166a@mail.de>
 <09ee8651-4f29-4ae0-8e82-a32a1f7ad04a@lunn.ch>
 <97d803a5-ca6e-4d4a-adc2-f97cabfded65@mail.de>
 <46e90a47-4507-40fe-b74e-efef932e9b62@bootlin.com>
Content-Language: en-US
From: tresonic <tresonic@mail.de>
In-Reply-To: <46e90a47-4507-40fe-b74e-efef932e9b62@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 4958
X-purgate-ID: 154282::1784381534-12467780-7EE160EE/0/0

Hi, thanks for testing and feedback!
> I've given this patch a test on imx8mp (that has a dwmac4.10), no regressions found
> from running basic tests :) I think this is a good fix, if you submit it can you
> address both dwmac410 and dwmac4 ? They both should be impacted by that problem.

I've added the deinit_chan for dwmac4.
Sorry for the noob question, how would I submit this fix?
Just commit and separately git send-email to netdev@vger.kernel.org?
These are my currernt changes:

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
index 829a23bdad01..23ffe1adcd0d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
@@ -106,6 +106,17 @@ static void dwmac4_dma_init_channel(struct stmmac_priv *priv,
 	       ioaddr + DMA_CHAN_INTR_ENA(dwmac4_addrs, chan));
 }
 
+static void dwmac4_dma_deinit_channel(struct stmmac_priv *priv,
+				      void __iomem *ioaddr, u32 chan)
+{
+	const struct dwmac4_addrs *dwmac4_addrs = priv->plat->dwmac4_addrs;
+	u32 value;
+
+	value = readl(ioaddr + DMA_CHAN_INTR_ENA(dwmac4_addrs, chan));
+	value &= ~DMA_CHAN_INTR_DEFAULT_MASK;
+	writel(value, ioaddr + DMA_CHAN_INTR_ENA(dwmac4_addrs, chan));
+}
+
 static void dwmac410_dma_init_channel(struct stmmac_priv *priv,
 				      void __iomem *ioaddr,
 				      struct stmmac_dma_cfg *dma_cfg, u32 chan)
@@ -125,6 +136,17 @@ static void dwmac410_dma_init_channel(struct stmmac_priv *priv,
 	       ioaddr + DMA_CHAN_INTR_ENA(dwmac4_addrs, chan));
 }
 
+static void dwmac410_dma_deinit_channel(struct stmmac_priv *priv,
+					void __iomem *ioaddr, u32 chan)
+{
+	const struct dwmac4_addrs *dwmac4_addrs = priv->plat->dwmac4_addrs;
+	u32 value;
+
+	value = readl(ioaddr + DMA_CHAN_INTR_ENA(dwmac4_addrs, chan));
+	value &= ~DMA_CHAN_INTR_DEFAULT_MASK_4_10;
+	writel(value, ioaddr + DMA_CHAN_INTR_ENA(dwmac4_addrs, chan));
+}
+
 static void dwmac4_dma_init(void __iomem *ioaddr,
 			    struct stmmac_dma_cfg *dma_cfg)
 {
@@ -548,6 +570,7 @@ const struct stmmac_dma_ops dwmac4_dma_ops = {
 	.reset = dwmac4_dma_reset,
 	.init = dwmac4_dma_init,
 	.init_chan = dwmac4_dma_init_channel,
+	.deinit_chan = dwmac4_dma_deinit_channel,
 	.init_rx_chan = dwmac4_dma_init_rx_chan,
 	.init_tx_chan = dwmac4_dma_init_tx_chan,
 	.axi = dwmac4_dma_axi,
@@ -577,6 +600,7 @@ const struct stmmac_dma_ops dwmac410_dma_ops = {
 	.reset = dwmac4_dma_reset,
 	.init = dwmac4_dma_init,
 	.init_chan = dwmac410_dma_init_channel,
+	.deinit_chan = dwmac410_dma_deinit_channel,
 	.init_rx_chan = dwmac4_dma_init_rx_chan,
 	.init_tx_chan = dwmac4_dma_init_tx_chan,
 	.axi = dwmac4_dma_axi,
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index e6317b94fff7..04dafec021b4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -170,6 +170,8 @@ struct stmmac_dma_ops {
 	void (*init)(void __iomem *ioaddr, struct stmmac_dma_cfg *dma_cfg);
 	void (*init_chan)(struct stmmac_priv *priv, void __iomem *ioaddr,
 			  struct stmmac_dma_cfg *dma_cfg, u32 chan);
+	void (*deinit_chan)(struct stmmac_priv *priv, void __iomem *ioaddr,
+			    u32 chan);
 	void (*init_rx_chan)(struct stmmac_priv *priv, void __iomem *ioaddr,
 			     struct stmmac_dma_cfg *dma_cfg,
 			     dma_addr_t phy, u32 chan);
@@ -235,6 +237,8 @@ struct stmmac_dma_ops {
 	stmmac_do_void_callback(__priv, dma, init, __args)
 #define stmmac_init_chan(__priv, __args...) \
 	stmmac_do_void_callback(__priv, dma, init_chan, __priv, __args)
+#define stmmac_deinit_chan(__priv, __args...) \
+	stmmac_do_void_callback(__priv, dma, deinit_chan, __priv, __args)
 #define stmmac_init_rx_chan(__priv, __args...) \
 	stmmac_do_void_callback(__priv, dma, init_rx_chan, __priv, __args)
 #define stmmac_init_tx_chan(__priv, __args...) \
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 2a0d7eff88d3..8504ecc3dbeb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2560,13 +2560,16 @@ static void stmmac_stop_all_dma(struct stmmac_priv *priv)
 {
 	u8 rx_channels_count = priv->plat->rx_queues_to_use;
 	u8 tx_channels_count = priv->plat->tx_queues_to_use;
+	u8 max_chan = max(rx_channels_count, tx_channels_count);
 	u8 chan;
 
-	for (chan = 0; chan < rx_channels_count; chan++)
-		stmmac_stop_rx_dma(priv, chan);
-
-	for (chan = 0; chan < tx_channels_count; chan++)
-		stmmac_stop_tx_dma(priv, chan);
+	for (chan = 0; chan < max_chan; chan++) {
+		if (chan < rx_channels_count)
+			stmmac_stop_rx_dma(priv, chan);
+		if (chan < tx_channels_count)
+			stmmac_stop_tx_dma(priv, chan);
+		stmmac_deinit_chan(priv, priv->ioaddr, chan);
+	}
 }
 
 /**

tresonic
