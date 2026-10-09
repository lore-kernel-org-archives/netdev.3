Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABE1366DD3;
	Fri,  9 Oct 2026 09:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791536577; cv=none; b=UiJ5MJwAgJpPYMtBpj6twLbiHoDCJbmxYO3ohLRsdBy2hHDvseRyTHSD0ll91tparLK802kpcDyB8zYNWGE/SPAlHLkCoJQZmxDrZ5fDbXcDxvDo6vTsbs9hUk+fVV9OdsBqYD/wLo0FcWODkv49p2SYbKaG9R6VGXXwm0v7ZdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791536577; c=relaxed/simple;
	bh=taOUFV9kmNv+nErGFJjRq/NqQH+ksEPY6YlPKqh2v48=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yuy0ZPZzwCLRXegA04BZqlahRkjgsrVbTKVq5NEAkEFcirOGlLhD3159itsxP0bbF1l5jNOgF5GzkamJHz5xFIGZ/Jb4PVAP4HJM93hnD4iaXMRPi8xuDheRfE8JFMi3yK0/cenoQp6n82beY8uY4DalRR7ojOCwc1OCQkLSLgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=yeDfXltA; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="yeDfXltA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1791536576; x=1823072576;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=taOUFV9kmNv+nErGFJjRq/NqQH+ksEPY6YlPKqh2v48=;
  b=yeDfXltAbYomhXxVgXBgYiwn7sVGvLP7zHIi8CjfttTL32T/8qEZX/C+
   KquLR75TcqCxJFWS3OxsE54YCA1LZGs914AnufMlc+w5mLZK/ZtErSM2M
   2jjlEsQ4r8MQjjrl+iv0M3xAlybyYycBMuuTzi1MHsRNqQBCS90Fg4y3K
   3Uayv5pg4YCcvLTL54JisZl9WkUhtPEWNfGtoZnzRHc7YX2qnGOHCwYp4
   JLcEdylq/akZ29qRPRKs3UoCAfs8XP/jbEa0irzemTgBc6fB6Hj/qx3WI
   ckkuUhGXNfNuqWoajygRy/mBeHp45XkLWWs2++Z/R8TMhJUhIbT2HwBD8
   A==;
X-CSE-ConnectionGUID: tZbgE63DSXOYBRuzbNl0lA==
X-CSE-MsgGUID: wCO6vwycTqyDOzPpoi0GGw==
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="75121798"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Oct 2026 02:02:55 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 9 Oct 2026 02:02:54 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 9 Oct 2026 02:02:53 -0700
Date: Fri, 9 Oct 2026 11:02:52 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Igor Velkov <iav@iav.lv>
CC: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v3] net: stmmac: mask the MAC interrupt while resume
 resets the MAC
Message-ID: <20261009090252.cqrmpdn4bpxsbfqr@DEN-DL-M70577.microsemi.net>
References: <20261007031438.3179966-1-iav@iav.lv>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261007031438.3179966-1-iav@iav.lv>

Hi Igor,

Just a question:

> stmmac_resume() resets the MAC in stmmac_hw_setup(). On dwmac1000 the
> reset sets GMAC_INT_MASK to 0, which unmasks every core interrupt, until
> dwmac1000_core_init() writes the mask again. Since commit 2e2c878a3141
> ("net: stmmac: remove SGMII/RGMII/SMII interrupt handling") nothing on
> the RGMII path reads GMAC_RGSMIIIS (only the PCS code does), so RGSMIIIS
> stays pending behind the mask from the first link change on, and the
> reset lets it through. The line storms:
> 
>   dwmac_dma_interrupt: unexpected status 04000000
> 
> A register dump at the first message on ODROID-HC4 showed it:
> 
>   core int_status 00000001 int_mask 00000000 pmt 00000000 rgsmiiis 0000000d
> 
> The mask is written by the resume thread itself. When that thread runs
> on the CPU that takes the MAC interrupt, the storm starves it and the
> board hangs until a watchdog reset or a soft-lockup panic; on another
> CPU the storm ends after a few interrupts.
> 
> Disable the interrupt line around stmmac_hw_setup(). This matches
> open(), which resets the MAC before it requests the interrupt; resume
> resets it with the line live. The window sits under rtnl_lock(), which
> stmmac_reset_subtask() also takes, so the reset task cannot free and
> request the interrupt between the disable and the enable. If the setup
> fails, it may not have written the mask: mask the core interrupts before
> enabling the line.
> 
> Wake-on-LAN resume with the resume thread on the CPU that takes the MAC
> interrupt, 7.3-rc5: without this patch the storm hit the first resume
> on Helios64 (dwmac-rk) twice, ROCK Pi 4A (dwmac-rk) once and ODROID-HC4
> (dwmac-meson8b) twice. With the thread on another CPU and no patch, the
> storm printed at most 3 messages per resume in 30 resumes. 7.3-rc6 with
> this patch: no storm in 10 resumes on ODROID-HC4, 10 on Helios64 with
> the GMAC kept powered across suspend (an Armbian patch) and 10 on
> Helios64 with mainline dwmac-rk plus "net: phy: postpone PHY interrupts
> during sleep with MAC-managed PM"; int_mask read 00000001 after the
> glue resume and before stmmac_hw_setup() in all 30.
> 

The fix seems OK, but it could have implications on other drivers, for an issue
that is dwmac1000 specific. Did you consider a fix that would only touch
dwmac1000?

> Fixes: 2e2c878a3141 ("net: stmmac: remove SGMII/RGMII/SMII interrupt handling")
> Assisted-by: LLM
> Signed-off-by: Igor Velkov <iav@iav.lv>
> ---
> v3:
> - disable the line only around stmmac_hw_setup(), under rtnl_lock() and
>   priv->lock, not for the whole resume (Sashiko)
> - mask the core interrupts if stmmac_hw_setup() fails (Sashiko)
> - results with this window on 7.3-rc6, including Helios64 with mainline
>   dwmac-rk
> v2: https://lore.kernel.org/r/20261002043558.1302590-1-iav@iav.lv
> v1: https://lore.kernel.org/r/20260930-stmmac-irq-shut-v1-1-104d1a1dcb28@iav.lv
> 
> Build-tested on net: allmodconfig and allyesconfig with W=1, no new
> warnings.
> 
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index b837e8e27a35..6091dc2d4ab4 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -8361,7 +8361,15 @@ int stmmac_resume(struct device *dev)
>         stmmac_free_tx_skbufs(priv);
>         stmmac_clear_descriptors(priv, &priv->dma_conf);
> 
> +       /* On dwmac1000 the MAC reset unmasks every core interrupt until the
> +        * mask is written again; we keep a pending status bit from storming.
> +        */
> +       disable_irq(ndev->irq);
>         ret = stmmac_hw_setup(ndev);
> +       /* A failed setup can stop before it writes the mask. */
> +       if (ret < 0)
> +               stmmac_mac_irq_modify(priv, ~0U, 0);
> +       enable_irq(ndev->irq);
>         if (ret < 0) {
>                 netdev_err(priv->dev, "%s: Hw setup failed\n", __func__);
>                 stmmac_legacy_serdes_power_down(priv);
> --
> 2.43.0
> 
> 

/Daniel
