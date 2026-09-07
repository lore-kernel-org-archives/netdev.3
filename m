Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8E23E95AE;
	Mon,  7 Sep 2026 02:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788749316; cv=none; b=L+qnveEDgpvtnmGUC681viZ4fP4j7+A/RykxTcHTuA8xZMlC1F/W9lPosy5q5z7LEb3YNcSMdXS8p/k9lT/1tvUCyXXRb1pW/u4BwsWW3N56D2T3PTNH93PcSTPomTzJEHrgKb19sDewibsUZ5eAOGeY1v+tEpJ8JlBfbtZfJEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788749316; c=relaxed/simple;
	bh=vAUiddykLX646pm+uXk/rkbKBcK5YWDov5N4UiexjOE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LcJpReWnIW4UjrQNqI6mdCBD70scdToCQgwRN3og07OxtuuEfWEl+YUtP0yxp1dMN61Qw6uv8glj0l0HaVODOTQQRvVv/sPuAUrMGLAcsZZXrBy5IAGQGvFdz0pB6Bo07n4tAzaSx1kvvrJ98hdsKyZYSNB3tIEnxpQQaOM2foM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvhgIaD0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvhgIaD0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFEF51F00A3E;
	Mon,  7 Sep 2026 02:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788749314;
	bh=82oDAmhbaL8wcR8ln5uOWhmRWIFS1wXKMEAQdRXM9WA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HvhgIaD0nzaOJU/PbOTX5F5WXQCG55H4TYaxESp9asUYvOf27WqTr8UKntl8mCo6V
	 JmurR+cr0NuuBkR7DoChEWLO9KQQlga8WS+EpqR64My3y4odv9MUIe+BhqHooonXNL
	 iWPN//hQsNY7l8tvfx95ME8qszNyZQkcAfjZZC5maaqNViF6t5gDQlAxOG9QCbbWN4
	 qmG37UyEGw7HYToVEKLU3RPN7yNojA95oh1NC0Nv6/smfUtQ65BUXJWiq62k+9n3JP
	 n5zRQQNZGomDkGshMSPeF3yupzvTd+nMEOZXy/bsxdUcu7/ixwyOrsXOg1dwVdaqxe
	 gbonYfsX/z7ig==
Subject: Re: [PATCH net-next v3 05/10] net: ethernet: ravb: Propagate error
 from ptp_clock_register()
From: netdev-bot+sashiko@kernel.org
To: niklas.soderlund+renesas@ragnatech.se
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, richardcochran@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
 sergei.shtylyov@gmail.com, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Date: Mon, 07 Sep 2026 02:48:33 +0000
Message-ID: <178874931332.219967.1304331824681845155@kernel.org>
In-Reply-To: <20260902084703.3228504-6-niklas.soderlund+renesas@ragnatech.se>
References: <20260902084703.3228504-6-niklas.soderlund+renesas@ragnatech.se>
X-sashiko-severity: Critical
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider:

Critical: 2 · High: 0 · Medium: 2 · Low: 1

- [Critical] NULL pointer dereference reachable by any unprivileged local
  user via `ethtool -T ethX`.
- [Critical] Dangling PTP clock pointer leading to use-after-free and
  double unregister.
- [Medium] Undisclosed revert of two in-tree stable-tagged fixes.
- [Medium] ravb_ptp_init() publishes the raw result of
  ptp_clock_register() into the shared, hardirq-visible priv->ptp.clock…
- [Low] Concern (baseline decision: false positive after series
  validation): ravb.h now declares `int ravb_ptp_init(struct net_device…

--

net: ethernet: ravb: Propagate error from ptp_clock_register()

ravb_ptp_init() is changed from void to int so that a failed
ptp_clock_register() can be reported to its callers. Along the way the
cached priv->ptp.phc_index field is removed and ravb_get_ts_info() reads
the index directly from priv->ptp.clock.

Link: https://sashiko.dev/#/patchset/20260610102432.3538432-2-niklas.soderlund+renesas@ragnatech.se?part=1

A few questions below.

> diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
> index aa45f5466001d..0c122a8158409 100644
> --- a/drivers/net/ethernet/renesas/ravb.h
> +++ b/drivers/net/ethernet/renesas/ravb.h
> @@ -1028,7 +1028,6 @@ struct ravb_ptp_perout {
>  struct ravb_ptp {
>  	struct ptp_clock *clock;
>  	struct ptp_clock_info info;
> -	int phc_index;
>  	u32 default_addend;
>  	u32 current_addend;
>  	int extts[N_EXT_TS];

[Severity: Medium]
The commit message says the change is about propagating the error from
ptp_clock_register(), but this hunk plus the ravb_ptp_stop() hunk below
also back out two in-tree fixes.  Could the changelog describe that?

The phc_index field being removed here was added by 1f77af0aaf27 ("net:
ravb: avoid dereferencing an invalid PTP clock"), and the
xchg(&priv->ptp.clock, NULL) removed from ravb_ptp_stop() came from
1cb9663789c5 ("net: ravb: serialize PTP clock teardown").  Both carry
Fixes: a0d2f20650e8 and Cc: stable.

The note "Rework to remove the caching of phc_index added by LLM without
access to hardware" is below the --- cut line, so it does not end up in
git history.

There is also a new side effect that is not mentioned: ravb_ptp_init()
now calls ravb_ptp_stop() itself on the registration failure path, so it
writes GIC=0/GIS=0 and runs synchronize_irq() before returning.

[ ... ]

> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index e44d065f77cc8..7c7b3ac81e5d6 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -1785,7 +1785,7 @@ static int ravb_get_ts_info(struct net_device *ndev,
>  			(1 << HWTSTAMP_FILTER_NONE) |
>  			(1 << HWTSTAMP_FILTER_PTP_V2_L2_EVENT) |
>  			(1 << HWTSTAMP_FILTER_ALL);
> -		info->phc_index = READ_ONCE(priv->ptp.phc_index);
> +		info->phc_index = ptp_clock_index(priv->ptp.clock);
>  	}
>  
>  	return 0;

[Severity: Critical]
Can this dereference NULL when the interface has never been opened?

The only guard in ravb_get_ts_info() is the static hardware test:

	if (hw_info->gptp || hw_info->ccc_gac) {
		...
		info->phc_index = ptp_clock_index(priv->ptp.clock);
	}

priv->ptp.clock lives in netdev_priv() and is zeroed at allocation.  It
is only assigned by ravb_ptp_init(), which runs from ravb_dmac_init()
(info->gptp) or ravb_open() (info->ccc_gac), i.e. not before the first
ndo_open.  With CONFIG_PTP_1588_CLOCK=y, ptp_clock_index() in
drivers/ptp/ptp_clock.c is an unconditional dereference:

	int ptp_clock_index(struct ptp_clock *ptp)
	{
		return ptp->index;
	}

ETHTOOL_GET_TS_INFO is in the "allow some commands to be done by anyone"
list in dev_ethtool(), and dev_ethtool() only requires
netif_device_present(), not netif_running(), so on a gen2/gen3/RZ-V2M
board "ethtool -T eth0" on a down interface looks reachable by any local
user.

The second way to get here with a NULL pointer is the failure this patch
is about: ravb_ptp_init() stores NULL on registration failure and both
call sites in this commit discard the return value, so the interface is
brought up with priv->ptp.clock == NULL.

The other readers in the driver, ravb_ptp_interrupt() and
ravb_ptp_stop(), still NULL-check this field, so the new site looks like
it breaks the in-driver invariant.  Should ravb_get_ts_info() keep a
sentinel of -1 for "no PHC" as before?

> @@ -2934,7 +2934,6 @@ static int ravb_probe(struct platform_device *pdev)
>  	priv->rstc = rstc;
>  	priv->ndev = ndev;
>  	priv->pdev = pdev;
> -	priv->ptp.phc_index = -1;
>  	priv->num_tx_ring[RAVB_BE] = BE_TX_RING_SIZE;
>  	priv->num_rx_ring[RAVB_BE] = BE_RX_RING_SIZE;
>  	if (info->nc_queues) {

diff --git a/drivers/net/ethernet/renesas/ravb_ptp.c b/drivers/net/ethernet/renesas/ravb_ptp.c
index f70b616ac847c..19d039b9d24a5 100644
--- a/drivers/net/ethernet/renesas/ravb_ptp.c
+++ b/drivers/net/ethernet/renesas/ravb_ptp.c
> @@ -313,11 +313,11 @@ void ravb_ptp_interrupt(struct net_device *ndev)
>  	ravb_write(ndev, ~(gis | GIS_RESERVED), GIS);
>  }
>  
> -void ravb_ptp_init(struct net_device *ndev)
> +int ravb_ptp_init(struct net_device *ndev)
>  {
>  	struct ravb_private *priv = netdev_priv(ndev);
> -	struct ptp_clock *clock;
>  	unsigned long flags;
> +	int ret = 0;
>  
>  	priv->ptp.info = ravb_ptp_info;
>  
> @@ -338,15 +338,14 @@ void ravb_ptp_init(struct net_device *ndev)
>  	ravb_modify(ndev, GCCR, GCCR_TCSS, GCCR_TCSS_ADJGPTP);
>  	spin_unlock_irqrestore(&priv->lock, flags);
>  
> -	clock = ptp_clock_register(&priv->ptp.info, &priv->pdev->dev);
> -	if (IS_ERR(clock)) {
> -		netdev_err(ndev, "failed to register PTP clock: %pe\n", clock);
> -		clock = NULL;
> +	priv->ptp.clock = ptp_clock_register(&priv->ptp.info, &priv->pdev->dev);
> +	if (IS_ERR(priv->ptp.clock)) {
> +		ret = PTR_ERR(priv->ptp.clock);
> +		priv->ptp.clock = NULL;
> +		ravb_ptp_stop(ndev);
>  	}
>  
> -	WRITE_ONCE(priv->ptp.clock, clock);
> -	if (clock)
> -		WRITE_ONCE(priv->ptp.phc_index, ptp_clock_index(clock));
> +	return ret;
>  }

[Severity: Medium]
Is it intentional that the registration result is published into the
shared field before the error pointer is normalised?

The store to priv->ptp.clock is a plain store outside priv->lock, and it
can briefly contain an ERR_PTR value until the next statements replace
it with NULL.  The lockless hardirq reader still expects "valid if
non-NULL" and still uses READ_ONCE():

drivers/net/ethernet/renesas/ravb_ptp.c:ravb_ptp_interrupt() {
	struct ptp_clock *clock = READ_ONCE(priv->ptp.clock);
	...
	if ((gis & GIS_PTCF) && clock) {
		...
		ptp_clock_event(clock, &event);
	}
}

So the WRITE_ONCE()/READ_ONCE() pairing added by 1cb9663789c5 is now
one-sided.  Keeping the registration result in a local variable and
storing only NULL or a valid pointer, as the previous code did, would
avoid both the plain-store annotation mismatch and the transient
ERR_PTR.

[Severity: Low]
This isn't a regression in behaviour, but the netdev_err("failed to
register PTP clock: %pe") diagnostic is dropped here while both callers
in this commit still ignore the new return value:

drivers/net/ethernet/renesas/ravb_main.c:ravb_dmac_init() {
	/* Initialise PTP Clock driver */
	if (info->gptp)
		ravb_ptp_init(ndev);

	return 0;
}

drivers/net/ethernet/renesas/ravb_main.c:ravb_open() {
	/* Initialise PTP Clock driver */
	if (info->ccc_gac)
		ravb_ptp_init(ndev);
}

The later patch "net: ethernet: ravb: Replace gPTP flags with callbacks"
does consume the error at both sites (dmac_start() and ndev_open()), so
the ignored return is only an intermediate state.  In this intermediate
commit a registration failure is however quieter than before, since
nothing prints anything at all.  Should the message be kept until the
callers report the error?

>  
>  static void ravb_ptp_disable(struct net_device *ndev)
> @@ -369,14 +368,10 @@ static void ravb_ptp_sync_irqs(struct net_device *ndev)
>  void ravb_ptp_stop(struct net_device *ndev)
>  {
>  	struct ravb_private *priv = netdev_priv(ndev);
> -	struct ptp_clock *clock;
> -
> -	WRITE_ONCE(priv->ptp.phc_index, -1);
> -	clock = xchg(&priv->ptp.clock, NULL);
>  
>  	ravb_ptp_disable(ndev);
>  	ravb_ptp_sync_irqs(ndev);
>  
> -	if (clock)
> -		ptp_clock_unregister(clock);
> +	if (priv->ptp.clock)
> +		ptp_clock_unregister(priv->ptp.clock);
>  }

[Severity: Critical]
Does this leave priv->ptp.clock pointing at freed memory?

ptp_clock_unregister() ends with:

drivers/ptp/ptp_clock.c:ptp_clock_unregister() {
	...
	/* The final put, normally here, will invoke ptp_clock_release(). */
	put_device(&ptp->dev);
}

so the struct ptp_clock is released, but the field keeps the old value
because the xchg() to NULL is gone.  Two consequences look possible.

First, a use-after-free read.  After a normal close of a gen3 interface
(ravb_close() -> ravb_ptp_stop()), an unprivileged "ethtool -T eth0"
reaches the new ravb_get_ts_info() -> ptp_clock_index(priv->ptp.clock)
and reads ->index out of freed memory, returning it to userspace as
phc_index.

Second, a double unregister on gptp hardware, where ravb_stop_dma()
tears the clock down:

drivers/net/ethernet/renesas/ravb_main.c:ravb_stop_dma() {
	/* Stop PTP Clock driver */
	if (info->gptp)
		ravb_ptp_stop(ndev);
}

If the following ravb_dmac_init() fails, ravb_ptp_init() is not re-run:

drivers/net/ethernet/renesas/ravb_main.c:ravb_tx_timeout_work() {
	error = ravb_dmac_init(ndev);
	if (error) {
		...
		goto out_unlock;
	}
}

ravb_set_ringparam() has the same early-return shape.  A later
ravb_close() -> ravb_stop_dma() -> ravb_ptp_stop() then sees the stale
non-NULL pointer and calls ptp_clock_unregister() a second time on the
released object, where ptp_vclock_in_use(), get_device(&ptp->dev) and
kthread_destroy_worker() all touch freed memory.

Before this change the xchg() made ravb_ptp_stop() idempotent and made
both sequences impossible.  Would storing NULL after unregistering, or
restoring the xchg(), be preferable?

Neither of these appears to be addressed by the rest of the series;
ravb_ptp_stop() is unchanged at the end of the series and
ravb_gen2_ptp_clock_index() still does "return ptp_clock_index(priv->ptp.clock)".

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902084703.3228504-1-niklas.soderlund%2Brenesas%40ragnatech.se
