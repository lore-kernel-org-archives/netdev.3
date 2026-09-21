Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C756648EC8F
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 12:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789995513; cv=none; b=siozycBiiB6pmGKH+9vcBHD231SoukyrPeEBLQTUdf+YXtFDciaL9Yb9lXuEnIP2C4o1pw9ZjnRdle40z19n24C3jmmcNnqa88v/Rb6jH7ZHfjPjuQ9yqOpPu5kVKWgYVwFM/hRTWHwCUaSfglNuvJz7fLf1sxxvXZR3RkS+81U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789995513; c=relaxed/simple;
	bh=8Qq6uY0wOjJjqW0nDZ94w4+duWoiGg3MvpwL50/yUoY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U7JryVExftDN0Oaa/4j2WZzDJMjhjtZzWFERL5GaTgdY++tFPEhYMTdH+V02lLrUeWXsu8hm7pwyR8F0kOYIQtvm9e9WiAzxvklbpfHeXftREmeUtl602CcZY1hVuFkmb6e5YSFToQ8zs8vs3hXwM2zdvXbyBOAQYcPxivF9AVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7Xg5UUj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7Xg5UUj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 548C51F00899;
	Mon, 21 Sep 2026 12:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789995511;
	bh=Hp9PMVhcxiOVyBuQt3wRyVKAGDHZYj1R6UQ3CkWOyMo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=X7Xg5UUjjmH6xo4ktaLiPg9sVZAe88uejK+X2QFjo2iF36zlcg9zqIiyefnO5H6ht
	 21jPpsIogTAqtCNfF9oirIfegZP0aNartJ3QzVt58xc0C15I5tOe8Kpd1WhWG/6JBj
	 i64Le+HQ+MUHU7zIR1W1wEHZ9Z+X6CUmPZJx6m0ObhlWjbE5shNX852eJ1Yxcc2qgv
	 Nd3aDfFUF8x6MmzvJzwshy265rKU8qmwptCfj2VGcIx/cJcXzsbfN/6oKFjsWSHSJ+
	 3ETkGteeACgc4E/E9U+TBxDuwCZi0V9rG+E/0tQg50J7lm6q+1ThuAdid7PrTCDjJD
	 Ydo1+TOS5prUA==
Subject: Re: [PATCH net v1] net: emac: move setting of netops to fix crash
From: netdev-bot+sashiko@kernel.org
To: chunkeey@gmail.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, kuba@kernel.org,
 davem@davemloft.net
Date: Mon, 21 Sep 2026 12:58:30 +0000
Message-ID: <178999551085.2160803.13630958553679103031@kernel.org>
In-Reply-To:
 <f11843d8416cb3d94b79a7f224bd4af0bf859c1f.1789644724.git.chunkeey@gmail.com>
References:
 <f11843d8416cb3d94b79a7f224bd4af0bf859c1f.1789644724.git.chunkeey@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In `emac_probe()` (drivers/net/ethernet/ibm/emac/core.c) the
  relocated Gigabit branch now sets `dev->commac.ops =…

--

net: emac: move setting of netops to fix crash

The patch moves the netdev_ops/ethtool_ops assignment in emac_probe() to
right after emac_init_config(), so that ndev->netdev_ops is populated
before of_phy_connect() runs the netdev_need_ops_lock() check added by
commit ded86da4bbb7. The dev->commac.ops selection was moved along with
it.

> diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
> index 1d46cf6c2c127..48ece86bcc8e0 100644
> --- a/drivers/net/ethernet/ibm/emac/core.c
> +++ b/drivers/net/ethernet/ibm/emac/core.c
> @@ -3044,6 +3044,14 @@ static int emac_probe(struct platform_device *ofdev)
>  	if (err)
>  		goto err_gone;
>  
> +	if (emac_phy_supports_gige(dev->phy_mode)) {
> +		ndev->netdev_ops = &emac_gige_netdev_ops;
> +		dev->commac.ops = &emac_commac_sg_ops;
> +	} else {
> +		ndev->netdev_ops = &emac_netdev_ops;
> +	}
> +	ndev->ethtool_ops = &emac_ethtool_ops;
> +

[Severity: High]
Does moving dev->commac.ops together with netdev_ops make this store dead?
Later in emac_probe(), the "Register with MAL" block still overwrites it
unconditionally:

drivers/net/ethernet/ibm/emac/core.c:emac_probe() {
	...
	/* Register with MAL */
	dev->commac.ops = &emac_commac_ops;
	dev->commac.dev = dev;
	dev->commac.tx_chan_mask = MAL_CHAN_MASK(dev->mal_tx_chan);
	dev->commac.rx_chan_mask = MAL_CHAN_MASK(dev->mal_rx_chan);
	err = mal_register_commac(dev->mal, &dev->commac);
	...
}

Before this patch the gige branch ran after that block, so the scatter/gather
table won. Now it runs before it, so every gige-capable EMAC appears to be
registered with mal_register_commac() using emac_commac_ops while
ndev->netdev_ops is emac_gige_netdev_ops.

The two tables differ only in peek_rx:

static struct mal_commac_ops emac_commac_ops = {
	.poll_tx = &emac_poll_tx,
	.poll_rx = &emac_poll_rx,
	.peek_rx = &emac_peek_rx,
	.rxde = &emac_rxde,
};

static struct mal_commac_ops emac_commac_sg_ops = {
	.poll_tx = &emac_poll_tx,
	.poll_rx = &emac_poll_rx,
	.peek_rx = &emac_peek_rx_sg,
	.rxde = &emac_rxde,
};

emac_peek_rx() reports work as soon as the current slot is not empty, while
emac_peek_rx_sg() walks the chain and only reports work when it sees
MAL_RX_CTRL_LAST:

drivers/net/ethernet/ibm/emac/core.c:emac_peek_rx_sg() {
	...
		if (ctrl & MAL_RX_CTRL_EMPTY)
			return 0;
		else if (ctrl & MAL_RX_CTRL_LAST)
			return 1;
	...
}

Can that cause mal_poll() to treat a partially received multi-descriptor or
jumbo frame as a complete "rotting packet"?

drivers/net/ethernet/ibm/emac/mal.c:mal_poll() {
	...
		if (unlikely(mc->ops->peek_rx(mc->dev) ||
			     test_bit(MAL_COMMAC_RX_STOPPED, &mc->flags))) {
			MAL_DBG2(mal, "rotting packet" NL);
			if (!napi_schedule(napi))
				goto more_work;

			spin_lock_irqsave(&mal->lock, flags);
			mal_disable_eob_irq(mal);
	...
}

Would it be enough to hoist only ndev->netdev_ops and ndev->ethtool_ops,
which is what the netdev_need_ops_lock() check in phy_link_topo_add_phy()
needs before of_phy_connect(), and leave the commac.ops selection where it
was, or alternatively set dev->commac.ops = &emac_commac_ops only in the
non-gige case?

The commit message describes this as moving "the code that sets
netdev_ops+ethtool_ops", so the change in commac.ops selection for gige
instances does not seem to be intentional.

>  	dev->emacp = devm_platform_ioremap_resource(ofdev, 0);
>  	if (IS_ERR(dev->emacp)) {
>  		err = PTR_ERR(dev->emacp);
> @@ -3144,12 +3152,6 @@ static int emac_probe(struct platform_device *ofdev)
>  		ndev->features |= ndev->hw_features | NETIF_F_RXCSUM;
>  	}
>  	ndev->watchdog_timeo = 5 * HZ;
> -	if (emac_phy_supports_gige(dev->phy_mode)) {
> -		ndev->netdev_ops = &emac_gige_netdev_ops;
> -		dev->commac.ops = &emac_commac_sg_ops;
> -	} else
> -		ndev->netdev_ops = &emac_netdev_ops;
> -	ndev->ethtool_ops = &emac_ethtool_ops;
>  
>  	/* MTU range: 46 - 1500 or whatever is in OF */
>  	ndev->min_mtu = EMAC_MIN_MTU;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/f11843d8416cb3d94b79a7f224bd4af0bf859c1f.1789644724.git.chunkeey%40gmail.com
