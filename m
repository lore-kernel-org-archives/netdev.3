Received: from shout02.mail.de (shout02.mail.de [62.201.172.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B363348C7D
	for <netdev@vger.kernel.org>; Sat, 18 Jul 2026 07:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.201.172.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784360148; cv=none; b=MYgvQNKNceXJIHMcPpyK28nK7G8MJ5BCHhbp1Nfl41307pHIqiD+iqthAikdU3kWougLiBqLa2mGycVrWTMbbJ1wAYvZSloBEz2tI1Q+nmOrBq7dKyjcWYI8TCZGZQybo7Ww0DKugZm6m6rEsFo3uXipEx7OrYJTBBAalxM8Bxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784360148; c=relaxed/simple;
	bh=dq62vZ7x72Lt9eZ4YiM9fHmYGcZcxSHkxrEZsXPNFm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nR98OQfJJuMksokbAUUT+TPorgKXP8CMW55v6HHruwTq+E5peJi8A4nUVSeZZuK+CvN6HdheZHlfJIVZfC52/6UB3JXENiScKQUFRCXv9o5wbsX0qqn/lgH23oJOPJAngjGW6N7hI/aWQ79Be/2lhYbWPCSXjEymyXxEWi/q66E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de; spf=pass smtp.mailfrom=mail.de; dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b=i7vIN3lt; arc=none smtp.client-ip=62.201.172.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b="i7vIN3lt"
Received: from postfix01.mail.de (postfix01.bt.mail.de [10.0.121.125])
	by shout02.mail.de (Postfix) with ESMTP id B63C62407CA;
	Sat, 18 Jul 2026 09:35:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
	s=mailde202009; t=1784360144;
	bh=dq62vZ7x72Lt9eZ4YiM9fHmYGcZcxSHkxrEZsXPNFm4=;
	h=Message-ID:Date:Subject:To:Cc:From:From:To:CC:Subject:Reply-To;
	b=i7vIN3ltR/Sa3AFPDL1an5rRPJIJkytZ+SiQhKwmEdYDjLQ3DkMCAS8uz56DTKVNS
	 LmbUxesbDmSB4fGg9Cb640cNJmsbmXVBAgx5AKFFT1q7wb6HLvy0siX01CaI8qfhUa
	 DN0dwqL3C2XthgtqAQvB6+u8aqiWKYatsFjAM9t2aNT1TIhIeCn3D/3VtQgg5/C4Rc
	 uLWjFfdMrTGiWa4/cV6OsyBbptF8BpfsxDPjF96RkPPrLaTvPotRaWjgYh48opem2l
	 nfybyKeQtFkeLwnVfe4P8UHSAXo8xXDYy2PlrfVvx2V+fk5ewGF5xmfRzVXmj1gUnd
	 5XpuVjdy0Ocpw==
Received: from smtp01.mail.de (smtp03.bt.mail.de [10.0.121.213])
	by postfix01.mail.de (Postfix) with ESMTP id 98779240564;
	Sat, 18 Jul 2026 09:35:44 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp01.mail.de (Postfix) with ESMTPSA id 0D9D0240660;
	Sat, 18 Jul 2026 09:35:42 +0200 (CEST)
Message-ID: <97d803a5-ca6e-4d4a-adc2-f97cabfded65@mail.de>
Date: Sat, 18 Jul 2026 09:35:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [REGRESSION][BISECTED] stmmac: suspend hangs since 1b9707e6f1a9
 ("net: stmmac: enable RPS and RBU interrupts")
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, regressions@lists.linux.dev,
 rmk+kernel@armlinux.org.uk, kuba@kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
References: <7941d239-e5f5-43b5-ae0f-20398221e027@mail.de>
 <17ebe5ba-16a5-4b3a-94cd-e9707c88df3e@lunn.ch>
 <72b91ec7-202c-4301-bcd8-b818cf8d72a0@mail.de>
 <21068662-c44b-4266-b634-24e5eac8cd96@lunn.ch>
 <8f6aca6d-6619-401c-bed7-8d42732d166a@mail.de>
 <09ee8651-4f29-4ae0-8e82-a32a1f7ad04a@lunn.ch>
Content-Language: en-US
From: tresonic <tresonic@mail.de>
In-Reply-To: <09ee8651-4f29-4ae0-8e82-a32a1f7ad04a@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 4494
X-purgate-ID: 154282::1784360144-EF6E9C36-31FD0AD6/0/0

Thank you for you explanations!

> The interrupt is being enabled in the init_chan call in
> stmmac_dma_ops. Ideally, it should be disabled in a mirror function,
> which currently does not exist. So maybe deinit_chan() needs
> adding. But where to call it from? init_chan() is called from
> stmmac_init_dma_engine(), from stmmac_hw_setup(). stmmac_resume() does
> call this. So we need something in stmmac_suspend(). Maybe in
> stmmac_stop_all_dma()?
> 
> stmmac is messy, there are often not mirror functions. If there is a
> stmmac_init_dma_engine() there should be
> stmmac_deinit_dma_engine(). If there is stmmac_hw_setup() there should
> be stmmac_hw_tairdown(). But none of these seem to exist. 
> 
> Anyway, do you want to try to implement deinit_chan() and call it from
> stmmac_stop_all_dma()?
Yes I'd really like to implement a solution here.
This is my try, but I still have some questions:
- is it ok to disable all interrupts on deinit_chan()?
- maybe the interrupt could also just be disabled in stop_rx?

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
index 829a23bdad01..65c243fb829f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
@@ -125,6 +125,17 @@ static void dwmac410_dma_init_channel(struct stmmac_priv *priv,
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
@@ -577,6 +588,7 @@ const struct stmmac_dma_ops dwmac410_dma_ops = {
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

