Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24CC3E51EF
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 12:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787661694; cv=none; b=TP3KdH23dh27ZUN7JqjiJ5RuKRLjOjoAE/lE1DhfxQpz2ZRi92W7OkDgVY1cZfXHgXylLBFYwDK2wT6BL31piLGH2VZ3hww2mVDMBIoIymSTRhWIuNH3AeK0dEaX8W7QusR7Z5p7zNVuZ5Dx1Jhen+TGEG4SzIutkKqkhmct8qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787661694; c=relaxed/simple;
	bh=iMp5GpN6/U9igSQL5wYc6AzZa2yF6+l/LN+CLRuICME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X2OUJjJhg9NzcG4UAX5gY4NGAH8SKiRu7Rda9IOz1GWBE1SlQBCrVWRleCSGGCNClDi5cBaECdHpWzsb+4dul0GvxHuyqVaUUteN7wdTL54cJy9EQ0XPL42HEzRfWvB504S3Zx4SVkDbb6qg1iIAfNll2/TmFKodmEHWrsvrce0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gx7iodAo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gx7iodAo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787661691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xyj2t2ZPJet7pQNjQ/Ax+H9J0fk7chnHKPGRi/WPS70=;
	b=gx7iodAovOt6UHD45gufOYl0OiHLpixg70TWIeaiJCk2EydpF19qCNCGP9qf+I/hkn+CQz
	oOK8Ut49jPEESPGbQmfnohSvRHvf07DfLmrCgIWfOvVpRK23zeULCeTexZ9vn51AOZGcCL
	oRDGnjB2C5YHSHfK+UH92HjFeIpkR4I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-170-kVtEiiVEOIqlkY40LMcG6w-1; Tue,
 25 Aug 2026 08:41:28 -0400
X-MC-Unique: kVtEiiVEOIqlkY40LMcG6w-1
X-Mimecast-MFC-AGG-ID: kVtEiiVEOIqlkY40LMcG6w_1787661683
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C71D91955DDF;
	Tue, 25 Aug 2026 12:41:22 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.127])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 20396362;
	Tue, 25 Aug 2026 12:41:15 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: hartmnn.p@gmail.com
Cc: maxime.chevallier@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	wens@kernel.org,
	jernej.skrabec@gmail.com,
	samuel@sholland.org,
	andre.przywara@arm.com,
	clabbe.montjoie@gmail.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: dwmac-sun8i: reset the EMAC when opening, not when probing
Date: Tue, 25 Aug 2026 14:41:11 +0200
Message-ID: <20260825124111.178799-1-pabeni@redhat.com>
In-Reply-To: <20260822045641.19282-1-hartmnn.p@gmail.com>
References: <20260822045641.19282-1-hartmnn.p@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
net: stmmac: dwmac-sun8i: reset the EMAC when opening, not when probing

The EMAC soft reset is moved out of sun8i_dwmac_probe() and into the
stmmac_dma_ops->reset hook, so it runs from stmmac_init_dma_engine()
instead of at probe time.  A new helper sun8i_dwmac_soft_reset() holds the
assert-and-poll sequence, and sun8i_dwmac_reset() is kept as a thin
wrapper for the mdio-mux switch callback.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> index 48c52eb96233..748ebabd933c 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> @@ -272,8 +272,34 @@ static const struct emac_variant emac_variant_h6 = {
>  /* sun8i_dwmac_dma_reset() - reset the EMAC
>   * Called from stmmac via stmmac_dma_ops->reset
>   */
> +static int sun8i_dwmac_soft_reset(void __iomem *ioaddr)

[Severity: Low]
This isn't a bug, but the existing header block now sits above the wrong
function.  Neither statement in it holds for sun8i_dwmac_soft_reset():
the ops table binds .reset = sun8i_dwmac_dma_reset, and the new helper
has a second caller, sun8i_dwmac_reset(), used by the mdio-mux switch
callback.  sun8i_dwmac_dma_reset() is then the only dma ops callback in
this file without a header comment naming it, unlike
sun8i_dwmac_dma_init() just below.  Should the comment move down with the
function it describes?

> +{
> +	u32 v;
> +
> +	v = readl(ioaddr + EMAC_BASIC_CTL1);
> +	writel(v | 0x01, ioaddr + EMAC_BASIC_CTL1);
> +
> +	/* The timeout was previously set to 10ms, but some board (OrangePI0)
> +	 * need more if no cable plugged. 100ms seems OK
> +	 */
> +	return readl_poll_timeout(ioaddr + EMAC_BASIC_CTL1, v,
> +				  !(v & 0x01), 100, 100000);
> +}

[Severity: Medium]
Is 100 ms still enough in the new context?  The comment above the poll
was written for a probe-time reset, where the PHY had been powered and
clocking since boot.

In the new call site the PHY may have left BMCR_PDOWN only microseconds
earlier.  __stmmac_open() and stmmac_resume() both do:

	phylink_prepare_resume(priv->phylink);
	...
	ret = stmmac_hw_setup(dev);

and phylink_prepare_resume() itself says:

	/* IEEE 802.3 22.2.4.1.5 allows PHYs to stop their receive clock
	 * when PDOWN is set. ... Note that 802.3 allows PHYs 500ms before
	 * the clock meets requirements. We do not implement this delay.
	 */
	if (pl->config->mac_requires_rxc && phydev && phydev->suspended)
		phy_resume(phydev);

Only stmmac_reset_queues_param() and descriptor clearing sit between
phy_resume() and stmmac_init_dma_engine() -> sun8i_dwmac_dma_reset(), so
on a PHY that is slow to restart RXC after power-down the poll can expire
and stmmac_hw_setup() returns -ETIMEDOUT on ifup, MTU change and system
resume.

The other stmmac variants that soft-reset in this hook allow more
headroom: 200 ms in dwmac_lib.c, 1 s in dwmac4_lib.c and dwmac-imx.c, 2 s
in dwmac-loongson.c.  Would raising the budget here be reasonable?

>  static int sun8i_dwmac_dma_reset(void __iomem *ioaddr)
>  {
> +	int err;
> +
> +	/* The MAC soft reset only completes once the PHY is driving the RX
> +	 * clock. Doing it here rather than at probe means phylib has already
> +	 * attached and resumed the PHY, so the clock is running by
> +	 * construction -- including after a warm reboot that left the PHY
> +	 * powered down.
> +	 */

[Severity: Medium]
Is the stated precondition accurate for all callers of the hook?  The
commit message says:

  "stmmac calls it from stmmac_init_dma_engine(), under stmmac_hw_setup(),
   whose only two callers are __stmmac_open() and stmmac_resume() -- both
   of which run after stmmac_init_phy() has attached and resumed the PHY."

stmmac_resume() does not call stmmac_init_phy() at all, and __stmmac_open()
is also reached from stmmac_change_mtu() and the XDP re-open path without
going through stmmac_open() -> stmmac_init_phy().

What actually guarantees a running receive clock before stmmac_hw_setup()
on those paths is phylink_prepare_resume(), added by commit 06232cb44bc8e
three weeks before this patch:

	phylink_prepare_resume(priv->phylink);

	stmmac_reset_queues_param(priv);

	ret = stmmac_hw_setup(dev);

In the current tree the behaviour is fine, since stmmac sets
mac_requires_rxc unconditionally, so phylink_prepare_resume() does resume
a suspended PHY first.  But the patch carries Fixes: 9f93ac8d4085 (2017).
In a stable tree without 06232cb44bc8e, would sun8i_dwmac_dma_reset()
assert SOFT_RST with an external PHY still in BMCR_PDOWN on every resume
and every MTU change, turning a probe-time failure into a resume and
MTU-change failure?

Could the commit message name phylink_prepare_resume() as the actual
dependency, and note it explicitly for backporters?

> +	err = sun8i_dwmac_soft_reset(ioaddr);
> +	if (err)
> +		return err;
> +
>  	writel(0, ioaddr + EMAC_RX_CTL1);
>  	writel(0, ioaddr + EMAC_TX_CTL1);
>  	writel(0, ioaddr + EMAC_RX_FRM_FLT);
> @@ -740,23 +766,12 @@ static void sun8i_dwmac_flow_ctrl(struct mac_device_info *hw,
>  
>  static int sun8i_dwmac_reset(struct stmmac_priv *priv)
>  {
> -	u32 v;
> -	int err;
> -
> -	v = readl(priv->ioaddr + EMAC_BASIC_CTL1);
> -	writel(v | 0x01, priv->ioaddr + EMAC_BASIC_CTL1);
> +	int err = sun8i_dwmac_soft_reset(priv->ioaddr);

[Severity: Medium]
This isn't a problem introduced by this patch -- the mdio-mux reset call
site predates it -- but does the failure mode survive there for the
H3/V3s variants, the only ones with soc_has_internal_phy = true?

The commit message mentions the retained caller:

  "sun8i_dwmac_reset() stays for the mdio-mux switch callback, which needs
   a reset after changing the syscon and cannot use the hook."

That callback still runs at probe time.  mdio_mux_read() invokes the
switch callback before forwarding the first MDIO transfer:

drivers/net/mdio/mdio-mux.c:mdio_mux_read() {
	...
	r = pb->switch_fn(pb->current_child, cb->bus_number, pb->switch_data);
	if (r)
		goto out;
	...
}

so during sun8i_dwmac_probe() -> sun8i_dwmac_register_mdio_mux() ->
mdio_mux_init() -> of_mdiobus_register(), the callback runs with
current_child == -1, selects the external child, unpowers the internal
PHY and calls sun8i_dwmac_reset() -> sun8i_dwmac_soft_reset() before
phylib has attached or resumed the external PHY.

On a board whose external PHY came back from a warm reboot in BMCR_PDOWN
-- the scenario in the commit message -- would the poll return -ETIMEDOUT,
switch_fn fail, mdio_mux_read() abort, and the external PHY never be
discovered?

The new comment in sun8i_dwmac_dma_reset() states that phylib has already
attached and resumed the PHY, which this second caller of the same helper
does not honour.

>  
> -	/* The timeout was previously set to 10ms, but some board (OrangePI0)
> -	 * need more if no cable plugged. 100ms seems OK
> -	 */
> -	err = readl_poll_timeout(priv->ioaddr + EMAC_BASIC_CTL1, v,
> -				 !(v & 0x01), 100, 100000);
> -
> -	if (err) {
> +	if (err)
>  		dev_err(priv->device, "EMAC reset timeout\n");
> -		return err;
> -	}
> -	return 0;
> +
> +	return err;
>  }

[ ... ]
-- 
This is an AI-generated review.

