Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52333CF976;
	Tue, 15 Sep 2026 01:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437284; cv=none; b=RyjcsSXBCMyUJXezSdRph0iPjl2L6iL0hm5S0pt+GgcG+uw4apITgz/7ufS2O+uFz8zqFA5/kbOX20y0zT4u3e1MQM9lJsde2SxY75B/1SXCMObr9l+63mfHH/TvCkssLNqyUgxZqjuM0kRfYhJE+np/1WPQfLwNr3eJLybHhNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437284; c=relaxed/simple;
	bh=D3s2Nxzc1pvu+T2U7VQ0mBQlI5m2/QCFAFwsHSHv5OE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sUAUL0BP0ky1C3Kw4ANzEmylXaO9Tw9kF/Vkt1Z/ShdLK6FVloG0w/B/hDdgb+FIxKV5RKhYhCrJa0spMF7AkqvVFrUiyPSfQk3hRgeiaoNBdLeq6bkPdtRO/QMpwaFkNIhdVpMi9WNYg2//oTNKOBoOPDenmmy/JmI9lXjKHMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9VfZWMy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9VfZWMy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0194B1F00893;
	Tue, 15 Sep 2026 01:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789437282;
	bh=WPHIfi3thFnvvsV+jCd+8R69asTUA/1FoV0dtZwAT/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G9VfZWMyy37Ot66FmImDKWtfqY8KK29ncPaXBtyV7RYFbNUkBuAsaposQOzd7FNTs
	 egTR2uQHpYC4ZxeHJHYAYHXzV6slfgRkzMTFJZCbD+MOevrtv02TwT6bR/lSPQeV2H
	 MjLcyBWoQAJzNf1PwDdsZNXuwQX0EcXHCzxCZMOhZp5rLF2an9K1UqRBqwhgJiT7fd
	 K66Dnx5xq8sf3Ul/cltsBfmhA3xz6WxWBm3K/lLMp4gTcTMKA4jm1cvEs98G2JcRzk
	 uIWokmGiHV4S96AjDIwbMPf9JoejG8ycolA3ygD2Mj9BMIORCBEFl4lJMYEaP2NQs3
	 f4ZS9eXg5x90A==
From: Jakub Kicinski <kuba@kernel.org>
To: niklas.soderlund+renesas@ragnatech.se
Cc: Jakub Kicinski <kuba@kernel.org>,
	paul@pbarker.dev,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	sergei.shtylyov@gmail.com,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 07/10] net: ethernet: ravb: Add callback for gPTP probe
Date: Mon, 14 Sep 2026 18:54:41 -0700
Message-ID: <20260915015441.881258-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909173027.2201560-8-niklas.soderlund+renesas@ragnatech.se>
References: <20260909173027.2201560-8-niklas.soderlund+renesas@ragnatech.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: ethernet: ravb: Add callback for gPTP probe

This adds a probe callback to struct ravb_gptp_info so each RAVB generation
can probe its gPTP timer clock its own way, and moves the GTI computation
into those per-generation callbacks. The gptp_ref_clk hardware flag is
dropped and RZ/V2M gets its own ravb_rzv2m_ptp_info with a probe callback
that fetches the "gptp" clock.

Two questions below about the gPTP callback error paths, both reached
through ravb_open().

> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index 9e9b1c4fbe956..1092e8ada188b 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c

[ ... ]

> @@ -2704,6 +2705,7 @@ static int ravb_gen3_ptp_set_config_mode(struct net_device *ndev)
>  }
>  
>  static const struct ravb_gptp_info ravb_gen3_ptp_info = {
> +	.probe = ravb_gen2_ptp_probe,
>  	.set_config_mode = ravb_gen3_ptp_set_config_mode,
>  	.ndev_open = ravb_ptp_init,
>  	.ndev_close = ravb_ptp_stop,
>  };

[Severity: High]
Gen3 wires PTP registration to .ndev_open and teardown only to
.ndev_close, leaving .dmac_stop unset. In ravb_open() the clock is
registered before the PHY is started, and both failures share one label:

	/* Initialise PTP Clock driver */
	if (info->ptp && info->ptp->ndev_open) {
		error = info->ptp->ndev_open(ndev);
		if (error)
			goto out_ptp_stop;
	}

	/* PHY control start */
	error = ravb_phy_start(ndev);
	if (error)
		goto out_ptp_stop;
...
out_ptp_stop:
	ravb_stop_dma(ndev);

The only PTP teardown reachable from out_ptp_stop is in ravb_stop_dma():

	/* Stop PTP Clock driver */
	if (info->ptp && info->ptp->dmac_stop)
		info->ptp->dmac_stop(ndev);

Since ravb_gen3_ptp_info has no .dmac_stop, does a ravb_phy_start()
failure leave the ptp_clock registered by ravb_ptp_init() unregistered?

A failed ndo_open is not followed by ndo_stop, so ravb_ptp_stop() and its
ptp_clock_unregister() would not run at all. A later successful open calls
ravb_ptp_init() again and overwrites priv->ptp.clock, and on unbind
free_netdev() frees the ravb_private holding priv->ptp.info that the still
registered clock points at.

The baseline error label did this explicitly:

	if (info->gptp || info->ccc_gac)
		ravb_ptp_stop(ndev);

That call was removed earlier in this series by "net: ethernet: ravb:
Simplify gPTP start and stop", which states "There are no functional
change". Should that claim be revisited, or should out_ptp_stop also invoke
the ndev_close callback?

The same shape is still present at the end of the series (c7fa563):
ravb_gen3_ptp_info keeps .ndev_open = ravb_ptp_init with no .dmac_stop, and
out_ptp_stop still only calls ravb_stop_dma(). Gen4 is not affected at the
end of the series because ravb_gen4_ptp_info has no .ndev_open.

> @@ -2763,6 +2765,24 @@ static const struct ravb_hw_info ravb_gen4_hw_info = {
>  	.magic_pkt = 1,
>  };
>  
> +static int ravb_rzv2m_ptp_probe(struct net_device *ndev)
> +{
> +	struct ravb_private *priv = netdev_priv(ndev);
> +
> +	priv->gptp_clk = devm_clk_get(&priv->pdev->dev, "gptp");
> +	if (IS_ERR(priv->gptp_clk))
> +		return PTR_ERR(priv->gptp_clk);
> +
> +	return ravb_compute_gti(ndev, priv->gptp_clk);
> +}
> +
> +static const struct ravb_gptp_info ravb_rzv2m_ptp_info = {
> +	.probe = ravb_rzv2m_ptp_probe,
> +	.set_config_mode = ravb_gen2_ptp_set_config_mode,
> +	.dmac_start = ravb_ptp_init,
> +	.dmac_stop = ravb_ptp_stop,
> +};

[Severity: Medium]
This isn't a bug introduced by this patch, but the .dmac_start =
ravb_ptp_init hook used here (and by ravb_gen2_ptp_info) can fail after the
DMA rings have been allocated. Can that leak the rings?

ravb_dmac_init() allocates first and calls the gPTP hook last:

	error = info->dmac_init(ndev);
	if (error)
		return error;
...
	/* Initialise PTP Clock driver */
	if (info->ptp && info->ptp->dmac_start)
		return info->ptp->dmac_start(ndev);

info->dmac_init() is ravb_dmac_init_rcar(), which allocates both queues via
ravb_ring_init() (RX/TX rings, page pools, SKB arrays and coherent
descriptor memory). Since "net: ethernet: ravb: Propagate error from
ptp_clock_register()" earlier in this series, ravb_ptp_init() returns the
ptp_clock_register() error, and ravb_dmac_init() passes it up to
ravb_open():

	/* Device init */
	error = ravb_dmac_init(ndev);
	if (error)
		goto out_set_reset;
...
out_ptp_stop:
	ravb_stop_dma(ndev);
out_set_reset:
	ravb_set_opmode(ndev, CCC_OPC_RESET);

Neither label calls ravb_ring_free(), and a failed ndo_open is not paired
with ndo_stop, so the rings allocated by ravb_dmac_init_rcar() stay
allocated. A later successful open overwrites priv->rx_ring[],
priv->tx_ring[] and priv->rx_pool[], and ravb_remove() does not free them
either.

The missing ravb_ring_free() on the ravb_open() error labels predates this
series: in the baseline ravb_dmac_init() could already fail at
ravb_set_opmode(CCC_OPC_OPERATION) after ring allocation, and a
ravb_phy_start() failure already returned through out_ptp_stop without
freeing the rings. Should the ravb_open() failure paths call
ravb_ring_free() for both queues?
